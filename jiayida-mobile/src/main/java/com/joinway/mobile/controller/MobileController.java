package com.joinway.mobile.controller;

import javax.validation.Valid;

import org.jsondoc.core.annotation.Api;
import org.jsondoc.core.annotation.ApiBodyObject;
import org.jsondoc.core.annotation.ApiError;
import org.jsondoc.core.annotation.ApiErrors;
import org.jsondoc.core.annotation.ApiMethod;
import org.jsondoc.core.annotation.ApiParam;
import org.jsondoc.core.annotation.ApiResponseObject;
import org.jsondoc.core.pojo.ApiParamType;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.joinway.bean.constant.ErrorCodeConstants;
import com.joinway.bean.logging.annotation.InputLog;
import com.joinway.bean.logging.annotation.LogIgnore;
import com.joinway.bean.logging.annotation.LogMask;
import com.joinway.bean.logging.annotation.OutputLog;
import com.joinway.bean.validation.constraints.CellPhone;
import com.joinway.common.bean.annotation.LoginName;
import com.joinway.common.bean.annotation.Password;
import com.joinway.mobile.bean.form.LogoutForm;
import com.joinway.mobile.bean.form.PasswordForm;
import com.joinway.mobile.bean.view.LoginView;
import com.joinway.mobile.bean.view.LogoutView;
import com.joinway.mobile.bean.view.PasswordView;
import com.joinway.mobile.bean.view.VersionView;
import com.joinway.mobile.exception.MobileErrorConstants;
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
	
	@ApiMethod(path="register", verb=ApiVerb.POST, description="用户注册", produces=MediaType.APPLICATION_JSON_VALUE)
	@ApiResponseObject
	@ApiErrors(apierrors={
			@ApiError(code=MobileErrorConstants.RepeatRegister.Code, description=MobileErrorConstants.RepeatRegister.Description)
			, @ApiError(code=ErrorCodeConstants.INTERNAL_ERROR, description=ErrorCodeConstants.INTERNAL_ERROR_DESC)
			, @ApiError(code=ErrorCodeConstants.INVALID_INPUT, description=ErrorCodeConstants.INVALID_INPUT_DESC)
		}
	)
	@RequestMapping(value="register", method=RequestMethod.POST, produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	@Login
	@Audit
	@InputLog
	@OutputLog
	public LoginView register(
			@LoginName @RequestParam("name") @ApiParam(name="name", description="用户名", paramType=ApiParamType.QUERY) @LogMask String name
			, @Password @RequestParam("password") @ApiParam(name="password", description="密码", paramType=ApiParamType.QUERY) @LogIgnore String password
			, @CellPhone @RequestParam("cellPhone") @ApiParam(name="cellPhone", description="手机号", paramType=ApiParamType.QUERY) @LogMask String cellPhone
			, @RequestParam("cellPhoneType") @ApiParam(name="cellPhoneType", description="手机类型", paramType=ApiParamType.QUERY) String cellPhoneType
			, @RequestParam("imId") @ApiParam(name="imId", description="推送用用手机唯一标识符", paramType=ApiParamType.QUERY) String imId
	) throws Exception {
		LoginView view = service.register(name, password, cellPhone, cellPhoneType, imId);
		
		return view;
	}

	@ApiMethod(path="login", verb=ApiVerb.POST, description="用户登录", consumes=MediaType.APPLICATION_JSON_VALUE, produces=MediaType.APPLICATION_JSON_VALUE)
	@ApiResponseObject
	@ApiErrors(apierrors={
			@ApiError(code=MobileErrorConstants.UserNotExists.Code, description=MobileErrorConstants.UserNotExists.Description)
			, @ApiError(code=ErrorCodeConstants.INTERNAL_ERROR, description=ErrorCodeConstants.INTERNAL_ERROR_DESC)
			, @ApiError(code=ErrorCodeConstants.INVALID_INPUT, description=ErrorCodeConstants.INVALID_INPUT_DESC)
		}
	)
	@RequestMapping(value="login", method=RequestMethod.POST, produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	@Login
	@Audit
	@InputLog
	@OutputLog
	public LoginView login(
			@LoginName @RequestParam("name") @ApiParam(name="name", description="用户名", paramType=ApiParamType.QUERY) @LogMask String name
			, @Password @RequestParam("password") @ApiParam(name="password", description="密码", paramType=ApiParamType.QUERY) @LogIgnore String password
			, @RequestParam("cellPhoneType") @ApiParam(name="cellPhoneType", description="手机类型", paramType=ApiParamType.QUERY) String cellPhoneType
			, @RequestParam("imId") @ApiParam(name="imId", description="推送用用手机唯一标识符", paramType=ApiParamType.QUERY) String imId
	) throws Exception {
		return service.login(name, password, cellPhoneType, imId);
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
