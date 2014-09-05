package com.joinway.mobile.bean.view;

import org.jsondoc.core.annotation.ApiObject;
import org.jsondoc.core.annotation.ApiObjectField;

import com.joinway.bean.view.View;

@ApiObject(name = "LoginView", description = "用户登录结果")
public class LoginView extends View {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5495595369853018268L;

	@ApiObjectField(description = "用户id")
	int userId;

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}
	
	
}
