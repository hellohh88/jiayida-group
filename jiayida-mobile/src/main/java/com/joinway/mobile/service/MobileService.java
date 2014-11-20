package com.joinway.mobile.service;

import java.util.Calendar;
import java.util.Date;
import java.util.UUID;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.joinway.appx.repository.SystemRepository;
import com.joinway.appx.repository.TableRepository;
import com.joinway.common.bean.domain.LoginUser;
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
		LoginUser loginUser = mobileRepository.findLoginUser(name);
		if(loginUser != null){
			throw new MobileException(MobileErrorConstants.RepeatRegister.Code, MobileErrorConstants.RepeatRegister.Description);
		}
		
		Date today = Calendar.getInstance().getTime();
		
		/*
		 * 保存用户注册信息
		 */
		String salt = StringUtils.split(UUID.randomUUID().toString(), "-")[0];
		loginUser = new LoginUser();
		loginUser.setLoginName(name.toLowerCase());
		loginUser.setPassword(CipherUtils.secureEncrypt(password, salt));
		loginUser.setSalt(salt);
		loginUser.setImId(imId);
		loginUser.setCellPhone(Integer.valueOf(cellPhone));
		loginUser.setCellPhoneType(cellPhoneType);
		loginUser.setLoginCount(1);
		loginUser.setLastLoginTime(today);
		loginUser.setCreateTime(today);
		
		tableRepository.save(loginUser);
		
//		if(StringUtils.isBlank(cellPhoneType)){
//			log.warn("got empty cellPhoneType for user id {}", loginUser.getId());
//		}

		if(StringUtils.isBlank(imId)){
			log.warn("got empty imid for user id {}", loginUser.getId());
		}

		LoginView view = new LoginView();
		
		view.setUserId(String.valueOf(loginUser.getId()));
		
		return view;
	}
	
	@Transactional(rollbackFor=Throwable.class)
	public LoginView login(String name, String password, String cellPhoneType, String imId) throws Exception {
		LoginUser loginUser = mobileRepository.findLoginUser(name.toLowerCase());
		if(loginUser == null){
			throw new MobileException(MobileErrorConstants.InvalidUserNameOrPassword.Code, MobileErrorConstants.InvalidUserNameOrPassword.Description);
		}
		
		loginUser = mobileRepository.findLoginUser(name, CipherUtils.secureEncrypt(password, loginUser.getSalt()));
		if(loginUser == null){
			throw new MobileException(MobileErrorConstants.InvalidUserNameOrPassword.Code, MobileErrorConstants.InvalidUserNameOrPassword.Description);
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
		
		view.setUserId(String.valueOf(loginUser.getId()));
		
		return view;
	}
	
	@Transactional(rollbackFor=Throwable.class)
	public LogoutView logout(int userId) throws Exception{
		return new LogoutView();
	}
	
	public VersionView getLatestVersion() throws Exception {
		VersionView view = new VersionView();
		view.setVersion(systemRepository.getStringValue(SystemRepository.ClientVersion));
		view.setUrl(systemRepository.getStringValue(SystemRepository.ClientDownlaodUrl));
		
		return view;
	}
	
	public PasswordView changePassword(String name, String oldPassword, String newPassword) throws Exception {
		LoginUser loginUser = mobileRepository.findLoginUser(name.toLowerCase());
		if(loginUser == null){
			throw new MobileException(MobileErrorConstants.InvalidUserNameOrPassword.Code, MobileErrorConstants.InvalidUserNameOrPassword.Description);
		}
		
		loginUser = mobileRepository.findLoginUser(name, CipherUtils.secureEncrypt(oldPassword, loginUser.getSalt()));
		if(loginUser == null){
			throw new MobileException(MobileErrorConstants.InvalidUserNameOrPassword.Code, MobileErrorConstants.InvalidUserNameOrPassword.Description);
		}
		
		loginUser.setPassword(CipherUtils.secureEncrypt(newPassword, loginUser.getSalt()));
		tableRepository.save(loginUser);
		
		return new PasswordView();
	}
	
}

