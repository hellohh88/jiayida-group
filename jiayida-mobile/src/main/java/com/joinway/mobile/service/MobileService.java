package com.joinway.mobile.service;

import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.joinway.appx.repository.SystemRepository;
import com.joinway.appx.repository.TableRepository;
import com.joinway.bean.exception.ValidationException;
import com.joinway.common.bean.domain.LoginUser;
import com.joinway.mobile.bean.form.LoginForm;
import com.joinway.mobile.bean.form.LogoutForm;
import com.joinway.mobile.bean.form.PasswordForm;
import com.joinway.mobile.bean.view.LoginView;
import com.joinway.mobile.bean.view.LogoutView;
import com.joinway.mobile.bean.view.PasswordView;
import com.joinway.mobile.bean.view.VersionView;
import com.joinway.mobile.exception.MobileErrorConstants;
import com.joinway.mobile.exception.MobileException;
import com.joinway.mobile.repository.MobileRepository;
import com.joinway.utils.CipherUtils;

@Service
public class MobileService {

	private final static Logger log = LoggerFactory.getLogger(MobileService.class);
	
	@Autowired MobileRepository mobileRepository;
	
	@Autowired TableRepository tableRepository;
	
	@Autowired SystemRepository systemRepository;
	
	@Transactional(rollbackFor=Throwable.class)
	public LoginView register(String name, String password, String cellPhone, String cellPhoneType, String imId) throws Exception {
		LoginUser loginUser = mobileRepository.findLoginUser(name.toLowerCase());
		if(loginUser != null){
			throw new MobileException(MobileErrorConstants.RepeatRegister.Code, MobileErrorConstants.RepeatRegister.Description);
		}
		
		Date today = Calendar.getInstance().getTime();
		
		/*
		 * 保存用户注册信息
		 */
		loginUser = new LoginUser();
		loginUser.setLoginName(name.toLowerCase());
		loginUser.setPassword(CipherUtils.secureEncrypt(password, name));
		loginUser.setImId(imId);
		loginUser.setCellPhone(Integer.valueOf(cellPhone));
		loginUser.setCellPhoneType(cellPhoneType);
		loginUser.setLoginCount(1);
		loginUser.setLastLoginTime(today);
		loginUser.setCreateTime(today);
		
		tableRepository.save(loginUser);
		
		if(StringUtils.isBlank(cellPhoneType)){
			log.warn("got empty cellPhoneType for user id {}", loginUser.getId());
		}

		if(StringUtils.isBlank(imId)){
			log.warn("got empty imid for user id {}", loginUser.getId());
		}

		LoginView view = new LoginView();
		
		view.setUserId(loginUser.getId());
		
		return view;
	}
	
	@Transactional(rollbackFor=Throwable.class)
	public LoginView login(String name, String password, String cellPhoneType, String imId) throws Exception {
		LoginUser loginUser = mobileRepository.findLoginUser(name.toLowerCase(), CipherUtils.secureEncrypt(password, name));
		if(loginUser == null){
			throw new MobileException(MobileErrorConstants.UserNotExists.Code, MobileErrorConstants.UserNotExists.Description);
		}
		
		/*
		 * 更新用户登录信息
		 */
		Date today = Calendar.getInstance().getTime();
		if(StringUtils.isNotBlank(imId)){
			loginUser.setImId(imId);
		}
		loginUser.setCellPhoneType(cellPhoneType);
		
		int count = loginUser.getLoginCount();
		loginUser.setLoginCount(count + 1);
		
		loginUser.setLastLoginTime(today);
		
		tableRepository.save(loginUser);
		
		LoginView view = new LoginView();
		
		view.setUserId(loginUser.getId());
		
		return view;
	}
	
	@Transactional(rollbackFor=Throwable.class)
	public LogoutView logout(LogoutForm form) throws Exception{
		return new LogoutView();
	}
	
	public VersionView getLatestVersion() throws Exception {
		VersionView view = new VersionView();
		view.setVersion(systemRepository.getStringValue(SystemRepository.ClientVersion));
		view.setUrl(systemRepository.getStringValue(SystemRepository.ClientDownlaodUrl));
		
		return view;
	}
	
	public PasswordView changePassword(PasswordForm form) throws Exception {
		// TODO 修改密码加密方式以及用户名大小写敏感
		LoginUser loginUser = mobileRepository.findLoginUser(form.getName().toLowerCase(), CipherUtils.encrypt(form.getOldPassword()));
		
		if(loginUser == null){
			throw new ValidationException("密码错误");
		}
		
		loginUser.setPassword(CipherUtils.encrypt(form.getNewPassword()));
		tableRepository.save(loginUser);
		
		return new PasswordView();
	}
	
}

