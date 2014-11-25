package com.joinway.mobile.controller;

import org.hibernate.validator.constraints.Length;
import org.jsondoc.core.annotation.Api;
import org.jsondoc.core.annotation.ApiError;
import org.jsondoc.core.annotation.ApiErrors;
import org.jsondoc.core.annotation.ApiMethod;
import org.jsondoc.core.annotation.ApiParam;
import org.jsondoc.core.annotation.ApiResponseObject;
import org.jsondoc.core.pojo.ApiParamType;
import org.jsondoc.core.pojo.ApiVerb;
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
import com.joinway.bean.logging.annotation.OutputLog;
import com.joinway.bean.validation.constraints.CellPhone;
import com.joinway.bean.view.View;
import com.joinway.mobile.bean.view.UserView;
import com.joinway.mobile.service.UserService;
import com.joinway.utils.DataUtils;
import com.joinway.web.audit.ExceptionController;
import com.joinway.web.audit.annotation.Audit;
import com.joinway.web.input.annotation.Render;

@Api(name = "User", description = "手机用户相关接口")
@Controller
@RequestMapping("user")
@Validated
public class UserController extends ExceptionController {

	@Autowired UserService service;
	
	@ApiMethod(path="profile?userId={userId}", verb=ApiVerb.GET, description="获得用户信息", produces=MediaType.APPLICATION_JSON_VALUE)
	@ApiResponseObject
	@ApiErrors(apierrors={
			@ApiError(code=ErrorCodeConstants.INTERNAL_ERROR, description=ErrorCodeConstants.INTERNAL_ERROR_DESC)
			, @ApiError(code=ErrorCodeConstants.INVALID_INPUT, description=ErrorCodeConstants.INVALID_INPUT_DESC)

		}
	)
	@RequestMapping(value="profile", method=RequestMethod.GET, produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	@Audit
	@InputLog
	@OutputLog
	public UserView getProfile(@Length(min=1) @RequestParam("userId") @Render @ApiParam(name="userId", description="用户id", paramType = ApiParamType.QUERY) String userId) throws Exception {
		return service.getUserProfile(DataUtils.convertToInt(userId));
	}

	@ApiMethod(path="profile?userId={userId}&name={name}&gender={gender}&address={address}&postalCode={postalCode}&email={email}&qq={qq}"
				, verb=ApiVerb.POST, description="更新用户信息", produces=MediaType.APPLICATION_JSON_VALUE)
	@ApiResponseObject
	@ApiErrors(apierrors={
			@ApiError(code=ErrorCodeConstants.INTERNAL_ERROR, description=ErrorCodeConstants.INTERNAL_ERROR_DESC)
			, @ApiError(code=ErrorCodeConstants.INVALID_INPUT, description=ErrorCodeConstants.INVALID_INPUT_DESC)

		}
	)
	@RequestMapping(value="profile", method=RequestMethod.POST, produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	@Audit
	@InputLog
	@OutputLog
	public View updateProfile(
			@Length(min=1) @RequestParam("userId") @Render @ApiParam(name="userId", description="用户id", paramType = ApiParamType.QUERY) String userId
			, @RequestParam(value="name",required=false,defaultValue="") @Render @ApiParam(name="name", description="真实姓名", paramType = ApiParamType.QUERY) @LogIgnore String name
			, @RequestParam(value="gender",required=false,defaultValue="") @Render @ApiParam(name="gender", description="性别", allowedvalues={"男","女"}, paramType = ApiParamType.QUERY) String gender
			, @RequestParam(value="address",required=false,defaultValue="") @Render @ApiParam(name="address", description="收货地址", paramType = ApiParamType.QUERY) String address
			, @RequestParam(value="postalCode",required=false,defaultValue="") @Render @ApiParam(name="postalCode", description="邮政编码", paramType = ApiParamType.QUERY) String postalCode
			, @RequestParam(value="email",required=false,defaultValue="") @Render @ApiParam(name="email", description="电子邮箱", paramType = ApiParamType.QUERY) String email
			, @RequestParam(value="qq",required=false,defaultValue="") @Render @ApiParam(name="qq", description="qq号码", paramType = ApiParamType.QUERY) String qq
	){
		return new View();
	}
}
