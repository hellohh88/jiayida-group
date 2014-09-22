package com.joinway.mobile.bean.form;

import org.jsondoc.core.annotation.ApiObject;
import org.jsondoc.core.annotation.ApiObjectField;

import com.joinway.bean.form.Form;
import com.joinway.bean.logging.annotation.LogIgnore;
import com.joinway.bean.logging.annotation.LogMask;
import com.joinway.common.bean.annotation.LoginName;
import com.joinway.common.bean.annotation.Password;

@ApiObject(name = "AuthForm", show = false)
public abstract class AuthForm extends Form {
	/**
	 * 
	 */
	private static final long serialVersionUID = -6643400074363702461L;

	@ApiObjectField(description = "用户登录账号,6到20个字符")
	@LoginName
	@LogMask
	String name;
	
	@ApiObjectField(description = "用户密码,6到20个字符")
	@Password
	@LogIgnore
	String password;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}


}
