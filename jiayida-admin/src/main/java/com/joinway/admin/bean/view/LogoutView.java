package com.joinway.admin.bean.view;

import org.jsondoc.core.annotation.ApiObject;
import org.jsondoc.core.annotation.ApiObjectField;

import com.joinway.bean.logging.annotation.LogMask;
import com.joinway.bean.view.View;

@ApiObject(name = "LoginView", description = "登出成功返回结果")
public class LogoutView extends View {

	/**
	 * 
	 */
	private static final long serialVersionUID = -203091649501603433L;

	@ApiObjectField(description = "登录用户名")
	@LogMask
	String userName;

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
}
