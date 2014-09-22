package com.joinway.mobile.controller;

import javax.validation.constraints.Min;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.joinway.bean.constant.ErrorCodeConstants;
import com.joinway.bean.logging.annotation.InputLog;
import com.joinway.bean.logging.annotation.OutputLog;
import com.joinway.mobile.bean.view.UserView;
import com.joinway.mobile.service.UserService;
import com.joinway.web.audit.ExceptionController;
import com.joinway.web.audit.annotation.Audit;

@Api(name = "User", description = "手机用户相关接口")
@Controller
@RequestMapping("user")
@Validated
public class UserController extends ExceptionController {

	@Autowired UserService service;
	
	@ApiMethod(path="user?userId={userId}", verb=ApiVerb.GET, description="获得用户信息", produces=MediaType.APPLICATION_JSON_VALUE)
	@ApiResponseObject
	@ApiErrors(apierrors={
			@ApiError(code=ErrorCodeConstants.INVALID, description="用户不存在")
		}
	)
	@RequestMapping(value="", produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	@Audit
	@InputLog
	@OutputLog
	public UserView getUser(@ApiParam(name="userId", description="用户id", paramType = ApiParamType.QUERY) @RequestParam("userId") @Min(1) int userId) throws Exception {
		return service.getUser(userId);
	}

}
