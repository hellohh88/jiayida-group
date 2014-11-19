package com.joinway.mobile.controller;

import org.hibernate.validator.constraints.NotBlank;
import org.jsondoc.core.annotation.Api;
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
import com.joinway.mobile.bean.view.LoginView;
import com.joinway.mobile.bean.view.LogoutView;
import com.joinway.mobile.bean.view.PasswordView;
import com.joinway.mobile.bean.view.VersionView;
import com.joinway.mobile.exception.MobileErrorConstants;
import com.joinway.mobile.service.MobileService;
import com.joinway.utils.DataUtils;
import com.joinway.web.audit.ExceptionController;
import com.joinway.web.audit.annotation.Audit;
import com.joinway.web.input.annotation.Render;
import com.joinway.web.input.type.Case;
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
			@LoginName @RequestParam("name") @Render(format=Case.Lower) @ApiParam(name="name", description="用户名", paramType=ApiParamType.QUERY) @LogMask String name
			, @Password @RequestParam("password") @ApiParam(name="password", description="密码", paramType=ApiParamType.QUERY) @LogIgnore String password
			, @CellPhone @RequestParam("cellPhone") @Render @ApiParam(name="cellPhone", description="手机号", paramType=ApiParamType.QUERY) @LogMask String cellPhone
			, @NotBlank @RequestParam("cellPhoneType") @Render @ApiParam(name="cellPhoneType", description="手机类型", paramType=ApiParamType.QUERY) String cellPhoneType
			, @RequestParam("imId") @Render @ApiParam(name="imId", description="推送用用手机唯一标识符", required=false, paramType=ApiParamType.QUERY) String imId
	) throws Exception {
		return service.register(name, password, cellPhone, cellPhoneType, imId);
	}

	@ApiMethod(path="login", verb=ApiVerb.POST, description="用户登录", produces=MediaType.APPLICATION_JSON_VALUE)
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
			@LoginName @RequestParam("name") @Render(format=Case.Lower) @ApiParam(name="name", description="用户名", paramType=ApiParamType.QUERY) @LogMask String name
			, @Password @RequestParam("password") @ApiParam(name="password", description="密码", paramType=ApiParamType.QUERY) @LogIgnore String password
			, @NotBlank @RequestParam("cellPhoneType") @Render @ApiParam(name="cellPhoneType", description="手机类型", paramType=ApiParamType.QUERY) String cellPhoneType
			, @RequestParam("imId") @Render @ApiParam(name="imId", description="推送用用手机唯一标识符", required=false, paramType=ApiParamType.QUERY) String imId
	) throws Exception {
		return service.login(name, password, cellPhoneType, imId);
	}

	@ApiMethod(path="logout", verb=ApiVerb.GET, description="用户注销", produces=MediaType.APPLICATION_JSON_VALUE)
	@ApiResponseObject
	@ApiErrors(apierrors={
			@ApiError(code=ErrorCodeConstants.INTERNAL_ERROR, description=ErrorCodeConstants.INTERNAL_ERROR_DESC)
		}
	)
	@RequestMapping(value="logout", produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	@Logout
	@Audit
	@InputLog
	@OutputLog
	public LogoutView logout(@RequestParam(value="userId", required=false, defaultValue="") @ApiParam(name="name", description="用户id", required=false, paramType=ApiParamType.QUERY) String userId) throws Exception {
		return service.logout(DataUtils.convertToInt(userId));
	}

	@ApiMethod(path="version", verb=ApiVerb.GET, description="查看最新版本", produces=MediaType.APPLICATION_JSON_VALUE)
	@ApiResponseObject
	@ApiErrors(apierrors={
			@ApiError(code=ErrorCodeConstants.INTERNAL_ERROR, description=ErrorCodeConstants.INTERNAL_ERROR_DESC)
		}
	)
	@RequestMapping(value="version", produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	@Audit
	@InputLog
	@OutputLog
	public VersionView version() throws Exception {
		return service.getLatestVersion();
	}

	@ApiMethod(path="password", verb=ApiVerb.POST, description="修改密码", produces=MediaType.APPLICATION_JSON_VALUE)
	@ApiResponseObject
	@ApiErrors(apierrors={
			@ApiError(code=MobileErrorConstants.UserNotExists.Code, description=MobileErrorConstants.UserNotExists.Description)
			, @ApiError(code=ErrorCodeConstants.INTERNAL_ERROR, description=ErrorCodeConstants.INTERNAL_ERROR_DESC)
			, @ApiError(code=ErrorCodeConstants.INVALID_INPUT, description=ErrorCodeConstants.INVALID_INPUT_DESC)
		}
	)
	@RequestMapping(value="password", method=RequestMethod.POST, produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	@Audit
	@InputLog
	@OutputLog
	public PasswordView password(@LoginName @RequestParam("name") @Render(format=Case.Lower) @ApiParam(name="name", description="用户名", paramType=ApiParamType.QUERY) @LogMask String name
								, @Password @RequestParam("oldPassword") @ApiParam(name="oldPassword", description="旧密码", paramType=ApiParamType.QUERY) @LogIgnore String oldPassword
								, @Password @RequestParam("newPassword") @ApiParam(name="newPassword", description="新密码", paramType=ApiParamType.QUERY) @LogIgnore String newPassword
	) throws Exception {
		return service.changePassword(name, oldPassword, newPassword);
	}

}
