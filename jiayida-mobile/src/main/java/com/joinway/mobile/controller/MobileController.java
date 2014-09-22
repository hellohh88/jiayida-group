package com.joinway.mobile.controller;

import javax.validation.Valid;

import org.jsondoc.core.annotation.Api;
import org.jsondoc.core.annotation.ApiBodyObject;
import org.jsondoc.core.annotation.ApiError;
import org.jsondoc.core.annotation.ApiErrors;
import org.jsondoc.core.annotation.ApiMethod;
import org.jsondoc.core.annotation.ApiResponseObject;
import org.jsondoc.core.pojo.ApiVerb;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.joinway.bean.constant.ErrorCodeConstants;
import com.joinway.bean.logging.annotation.InputLog;
import com.joinway.bean.logging.annotation.OutputLog;
import com.joinway.mobile.bean.form.LoginForm;
import com.joinway.mobile.bean.form.LogoutForm;
import com.joinway.mobile.bean.form.PasswordForm;
import com.joinway.mobile.bean.form.RegisterForm;
import com.joinway.mobile.bean.view.LoginView;
import com.joinway.mobile.bean.view.LogoutView;
import com.joinway.mobile.bean.view.PasswordView;
import com.joinway.mobile.bean.view.VersionView;
import com.joinway.mobile.service.MobileService;
import com.joinway.web.audit.ExceptionController;
import com.joinway.web.audit.annotation.Audit;
import com.joinway.web.security.annotation.Login;
import com.joinway.web.security.annotation.Logout;

@Api(name = "Mobile", description = "手机 用户登录，登出")
@Controller
@RequestMapping("")
@Validated
public class MobileController extends ExceptionController {
	
	private final static Logger log = LoggerFactory.getLogger(MobileController.class);
	
	@Autowired MobileService service;
	
	@ApiMethod(path="register", verb=ApiVerb.POST, description="用户注册", consumes=MediaType.APPLICATION_JSON_VALUE, produces=MediaType.APPLICATION_JSON_VALUE)
	@ApiResponseObject
	@ApiErrors(apierrors={
			@ApiError(code=ErrorCodeConstants.DUPLICATE_DATA, description="用户已注册")
		}
	)
	@RequestMapping(value="register", method=RequestMethod.POST, consumes=MediaType.APPLICATION_JSON_VALUE, produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	@Login
	@Audit
	@InputLog
	@OutputLog
	public LoginView register(@ApiBodyObject @Valid @RequestBody RegisterForm form) throws Exception {
		LoginView view = service.register(form);
		
		return view;
	}

	@ApiMethod(path="login", verb=ApiVerb.POST, description="用户登录", consumes=MediaType.APPLICATION_JSON_VALUE, produces=MediaType.APPLICATION_JSON_VALUE)
	@ApiResponseObject
	@ApiErrors(apierrors={
			@ApiError(code=ErrorCodeConstants.INVALID, description="用户不存在")
		}
	)
	@RequestMapping(value="login", method=RequestMethod.POST, consumes=MediaType.APPLICATION_JSON_VALUE, produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	@Login
	@Audit
	@InputLog
	@OutputLog
	public LoginView login(@ApiBodyObject @Valid @RequestBody LoginForm form) throws Exception {
		return service.login(form);
	}

	@ApiMethod(path="logout", verb=ApiVerb.POST, description="用户注销", consumes=MediaType.APPLICATION_JSON_VALUE, produces=MediaType.APPLICATION_JSON_VALUE)
	@ApiResponseObject
	@ApiErrors(apierrors={
			@ApiError(code=ErrorCodeConstants.INVALID, description="用户不存在")
		}
	)
	@RequestMapping(value="logout", method=RequestMethod.POST, consumes=MediaType.APPLICATION_JSON_VALUE, produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	@Logout
	@Audit
	@InputLog
	@OutputLog
	public LogoutView logout(@ApiBodyObject @Valid @RequestBody LogoutForm form) throws Exception {
		return service.logout(form);
	}

	@ApiMethod(path="version", verb=ApiVerb.GET, description="查看最新版本", produces=MediaType.APPLICATION_JSON_VALUE)
	@ApiResponseObject
	@RequestMapping(value="version", produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	@Audit
	@InputLog
	@OutputLog
	public VersionView version() throws Exception {
		return service.getLatestVersion();
	}

	@ApiMethod(path="password", verb=ApiVerb.POST, description="修改密码", consumes=MediaType.APPLICATION_JSON_VALUE, produces=MediaType.APPLICATION_JSON_VALUE)
	@ApiResponseObject
	@ApiErrors(apierrors={
			@ApiError(code=ErrorCodeConstants.INVALID, description="密码错误")
		}
	)
	@RequestMapping(value="password", method=RequestMethod.POST, consumes=MediaType.APPLICATION_JSON_VALUE, produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	@Audit
	@InputLog
	@OutputLog
	public PasswordView password(@ApiBodyObject @Valid @RequestBody PasswordForm form) throws Exception {
		return service.changePassword(form);
	}

}
