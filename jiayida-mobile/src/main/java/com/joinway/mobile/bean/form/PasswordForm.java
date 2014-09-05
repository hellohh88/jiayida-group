package com.joinway.mobile.bean.form;

import org.jsondoc.core.annotation.ApiObject;
import org.jsondoc.core.annotation.ApiObjectField;

import com.joinway.bean.form.Form;
import com.joinway.bean.logging.annotation.LogIgnore;
import com.joinway.bean.logging.annotation.LogMask;
import com.joinway.common.bean.annotation.LoginName;
import com.joinway.common.bean.annotation.Password;

@ApiObject(name = "PasswordForm", description = "修改密码")
public class PasswordForm extends Form {

	/**
	 * 
	 */
	private static final long serialVersionUID = 435544859530234412L;

	@ApiObjectField(description = "登录用户名")
	@LoginName
	@LogMask
	String name;
	
	@ApiObjectField(description = "原密码")
	@Password
	@LogIgnore
	String oldPassword;
	
	@ApiObjectField(description = "新密码")
	@Password
	@LogIgnore
	String newPassword;

	public String getOldPassword() {
		return oldPassword;
	}

	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}

	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
