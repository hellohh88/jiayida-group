package com.joinway.mobile.service;

import java.util.Calendar;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.joinway.appx.repository.SystemRepository;
import com.joinway.appx.repository.TableRepository;
import com.joinway.bean.constant.DBValueConstants;
import com.joinway.bean.exception.DuplicateDataException;
import com.joinway.bean.exception.ValidationException;
import com.joinway.common.bean.domain.DriveTrainee;
import com.joinway.common.bean.domain.LoginUser;
import com.joinway.mobile.bean.form.LoginForm;
import com.joinway.mobile.bean.form.LogoutForm;
import com.joinway.mobile.bean.form.PasswordForm;
import com.joinway.mobile.bean.form.RegisterForm;
import com.joinway.mobile.bean.view.LoginView;
import com.joinway.mobile.bean.view.LogoutView;
import com.joinway.mobile.bean.view.PasswordView;
import com.joinway.mobile.bean.view.VersionView;
import com.joinway.mobile.repository.MobileRepository;
import com.joinway.utils.CipherUtils;

@Service
public class MobileService {

	@Autowired MobileRepository mobileRepository;
	
	@Autowired TableRepository tableRepository;
	
	@Autowired SystemRepository systemRepository;
	
	@Transactional(rollbackFor=Throwable.class)
	public LoginView register(RegisterForm form) throws Exception {
		LoginUser loginUser = mobileRepository.findLoginUser(form.getName().toLowerCase());
		if(loginUser != null){
			throw new DuplicateDataException("用户已注册");
		}
		
		Date today = Calendar.getInstance().getTime();
		
		/*
		 * 保存用户注册信息
		 */
		loginUser = new LoginUser();
		loginUser.setLoginName(form.getName());
		loginUser.setPassword(CipherUtils.encrypt(form.getPassword()));
		loginUser.setLoginCount(0);
		loginUser.setCreateTime(today);
		
		tableRepository.save(loginUser);
		
		/*
		 * 保存用户信息
		 */
		
		DriveTrainee user = new DriveTrainee();
		user.setId(loginUser.getId());
		user.setCellPhone(form.getCellPhone());
		user.setName(form.getUserName());
		user.setRegisterDate(today);
		
		tableRepository.save(user);
		
		LoginView view = new LoginView();
		
		view.setUserId(loginUser.getId());
		
		return view;
	}
	
	@Transactional(rollbackFor=Throwable.class)
	public LoginView login(LoginForm form) throws Exception {
		LoginUser loginUser = mobileRepository.findLoginUser(form.getName(), CipherUtils.encrypt(form.getPassword()));
		if(loginUser == null){
			throw new ValidationException("用户名或密码错误");
		}
		
		/*
		 * 更新用户登录信息
		 */
		int count = loginUser.getLoginCount();
		Date today = Calendar.getInstance().getTime();
		
		loginUser.setLoginCount(count + 1);
		loginUser.setLastLoginTime(today);
		loginUser.setLoginStatus(DBValueConstants.YES);
		loginUser.setImId(form.getImId());
		loginUser.setCellPhoneType(form.getMobileType());
		tableRepository.save(loginUser);
		
//		DriveTrainee user = tableRepository.find(loginUser.getId(), DriveTrainee.class);
//		tableRepository.save(user);
		
		LoginView view = new LoginView();
		
		view.setUserId(loginUser.getId());
		
		return view;
	}
	
	@Transactional(rollbackFor=Throwable.class)
	public LogoutView logout(LogoutForm form) throws Exception{
		LoginUser loginUser = tableRepository.find(form.getUserId(), LoginUser.class);
		
		if(loginUser == null){
			throw new ValidationException("用户不存在");
		}
		
		/*
		 * 保存用户登出信息
		 */
		loginUser.setLoginStatus(DBValueConstants.NO);
		tableRepository.save(loginUser);
		
		return new LogoutView();
	}
	
	public VersionView getLatestVersion() throws Exception {
		VersionView view = new VersionView();
		view.setVersion(systemRepository.getStringValue(SystemRepository.ClientVersion));
		view.setUrl(systemRepository.getStringValue(SystemRepository.ClientDownlaodUrl));
		
		return view;
	}
	
	public PasswordView changePassword(PasswordForm form) throws Exception {
		LoginUser loginUser = mobileRepository.findLoginUser(form.getName().toLowerCase(), CipherUtils.encrypt(form.getOldPassword()));
		
		if(loginUser == null){
			throw new ValidationException("密码错误");
		}
		
		loginUser.setPassword(CipherUtils.encrypt(form.getNewPassword()));
		tableRepository.save(loginUser);
		
		return new PasswordView();
	}
}

