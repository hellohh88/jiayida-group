package com.joinway.admin.controller;

import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.jsondoc.core.annotation.ApiBodyObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.joinway.admin.bean.UserContext;
import com.joinway.admin.bean.form.LoginForm;
import com.joinway.admin.bean.form.MassPushForm;
import com.joinway.admin.bean.form.PushAllForm;
import com.joinway.admin.bean.form.RegisterForm;
import com.joinway.admin.bean.form.ResendForm;
import com.joinway.admin.bean.view.LoginView;
import com.joinway.admin.bean.view.LogoutView;
import com.joinway.admin.bean.view.PushView;
import com.joinway.admin.bean.view.TreeMenuView;
import com.joinway.admin.service.AdminService;
import com.joinway.admin.service.DriveTraineeTableService;
import com.joinway.admin.utils.SessionHelper;
import com.joinway.appx.bean.view.DataGridView;
import com.joinway.bean.exception.ValidationException;
import com.joinway.bean.logging.annotation.InputLog;
import com.joinway.bean.logging.annotation.LogIgnore;
import com.joinway.bean.logging.annotation.OutputLog;
import com.joinway.web.audit.ExceptionController;
import com.joinway.web.audit.annotation.Audit;
import com.joinway.web.security.annotation.Login;
import com.joinway.web.security.annotation.Logout;
import com.joinway.web.security.annotation.SecurityCheck;

/**
 * ...session.........controller..service.....
 * @author Administrator
 *
 */
@Controller
@RequestMapping("")
@Validated
public class AdminController extends ExceptionController {

	private final static Logger log = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired AdminService service;
	
	
	@RequestMapping(value="register", method=RequestMethod.POST, produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	@Login
	@Audit
	@InputLog
	@OutputLog
	public LoginView register(@ApiBodyObject @Valid RegisterForm form) throws Exception {
		preLogin(form.getName());
		
		LoginView view = service.register(form);
		
		postLogin(view);
		
		return view;
	}
	
	@RequestMapping(value="login", method=RequestMethod.POST, produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	@Login
	@Audit
	@InputLog
	@OutputLog
	public LoginView login(@ApiBodyObject @Valid LoginForm form) throws Exception {
		preLogin(form.getName());
		
		LoginView view = service.login(form);
		
		postLogin(view);
		
		return view;
	}
	
	@RequestMapping(value="login/context", method=RequestMethod.GET, produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	@SecurityCheck
	@Audit
	@InputLog
	@OutputLog
	public LoginView getLoginContext() throws ValidationException {
		LoginView view = new LoginView();
		
		UserContext uc = SessionHelper.getUserContext(true);
		view.setUserId(uc.getUserId());
		view.setLoginName(uc.getLoginName());
		view.setLastLoginTime(uc.getLastLoginTime());
		view.setLoginCount(uc.getLoginCount());
		
		return view;
	}

	@RequestMapping(value="logout", produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	@Audit
	@Logout
	@InputLog
	@OutputLog
	public LogoutView logout(){
		LogoutView view = service.logout();
		
		UserContext uc = SessionHelper.getUserContext();
		if(uc != null){
			view.setUserName(uc.getLoginName());
		}
		
		log.info("user logged out");
		
		return view;
	}
	
	@RequestMapping(value="navigator", produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	@SecurityCheck
	@Audit
	@InputLog
	@OutputLog
	public TreeMenuView navigator() throws Exception {
		return service.getNavigatorMenus(SessionHelper.getUserContext().getUserId());
	}
	
	@RequestMapping(value="push/broadcast", method=RequestMethod.POST, produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	@Audit
	@InputLog
	@OutputLog
	public PushView broadcast(@ApiBodyObject @Valid PushAllForm form) throws Exception {
		return service.push(form);
	}

	@RequestMapping(value="push/mass", method=RequestMethod.POST, produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	@Audit
	@InputLog
	@OutputLog
	public PushView massPush(@ApiBodyObject @Valid MassPushForm form) throws Exception {
		return service.massPush(form, SessionHelper.getUserContext());
	}
	
	@RequestMapping(value="push/resend", method=RequestMethod.POST, produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	@Audit
	@InputLog
	@OutputLog
	public PushView resendPush(@ApiBodyObject @Valid ResendForm form) throws Exception {
		return service.resendPush(form, SessionHelper.getUserContext());
	}

	void preLogin(String userName){
		UserContext uc = SessionHelper.getUserContext(true);
		// set login user name anyway for audit usage
		uc.setLoginName(userName);
	}

	void postLogin(LoginView view){
		UserContext uc = SessionHelper.getUserContext();

		uc.setLastLoginTime(view.getLastLoginTime());
		uc.setLoginCount(view.getLoginCount());
		uc.setUserId(view.getUserId());
		
//		// ..sso
//		AppContext.set(SecurityConstants.SSO.UID_KEY, uc.getUserId());
	}
	
	@ResponseBody
	@RequestMapping(value="/loginNameCount")
	public int getLoginNameCount(HttpServletRequest request) throws Exception{
		String loginName = request.getParameter("loginName");
		String driveTraineeId = request.getParameter("driveTraineeId");
		return service.getLoginNameCount(loginName ,driveTraineeId);
	}
	
//	@RequestMapping(value="search/{table}", produces=MediaType.APPLICATION_JSON_VALUE)
//	@ResponseBody
//	@Audit("search")
//	@InputLog
//	@OutputLog
//	public DataGridView find(@PathVariable("table") String table, @LogIgnore HttpServletRequest request) throws Exception {
//		driveTraineeTableServiec.
//		return 
//	}
	
	@ResponseBody
	@RequestMapping(value="/dealStauts")
	public boolean dealStauts(HttpServletRequest request) throws Exception{
		String dealStatus = request.getParameter("dealStatus");
		String ids = request.getParameter("ids");
		return service.dealStauts(ids ,dealStatus);
	}
}


