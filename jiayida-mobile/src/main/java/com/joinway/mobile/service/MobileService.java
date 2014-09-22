package com.joinway.mobile.service;

import java.util.Calendar;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.joinway.appx.repository.SystemRepository;
import com.joinway.appx.repository.TableRepository;
import com.joinway.bean.exception.DuplicateDataException;
import com.joinway.bean.exception.ValidationException;
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
		// TODO 查看php端注册用户名数据库里是否区分大小写
		LoginUser loginUser = mobileRepository.findLoginUser(form.getName().toLowerCase());
		if(loginUser != null){
			throw new DuplicateDataException("用户已注册");
		}
		
		Date today = Calendar.getInstance().getTime();
		
		/*
		 * 保存用户注册信息
		 */
		loginUser = new LoginUser();
		loginUser.setUserName(form.getName());
		// TODO set encrypted password here
//		loginUser.setPassword();
		loginUser.setVisitCount(0);
		// TODO 设置注册时间
//		loginUser.setRegTime();
		
		tableRepository.save(loginUser);
		
		LoginView view = new LoginView();
		
		view.setUserId(loginUser.getId());
		
		return view;
	}
	
	@Transactional(rollbackFor=Throwable.class)
	public LoginView login(LoginForm form) throws Exception {
		//TODO 修改密码加密方法，java里查询的sql不区分大小写，确认需要做修改
//		LoginUser loginUser = mobileRepository.findLoginUser(form.getName(), CipherUtils.encrypt(form.getPassword()));
		LoginUser loginUser = mobileRepository.findLoginUser(form.getName(), form.getPassword());
		if(loginUser == null){
			throw new ValidationException("用户名或密码错误");
		}
		
		/*
		 * 更新用户登录信息
		 */
		int count = loginUser.getVisitCount();
		Date today = Calendar.getInstance().getTime();
		
		loginUser.setVisitCount(count + 1);
		// TODO 设置最后登录时间
//		loginUser.setLastLogin();
		loginUser.setImId(form.getImId());
		loginUser.setCellPhoneType(form.getMobileType());
		tableRepository.save(loginUser);
		
		LoginView view = new LoginView();
		
		view.setUserId(loginUser.getUserId());
		
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

