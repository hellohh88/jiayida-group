package com.joinway.mobile.bean.form;

import javax.validation.constraints.Min;

import org.jsondoc.core.annotation.ApiObject;
import org.jsondoc.core.annotation.ApiObjectField;

import com.joinway.bean.form.Form;
import com.joinway.bean.logging.annotation.LogMask;

@ApiObject(name = "LogoutForm", description = "用户注销信息")
public class LogoutForm extends Form {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2345238275392039284L;

	@ApiObjectField(description = "登录用户ID")
	@Min(1)
//	@LogMask
	int userId;

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

}
