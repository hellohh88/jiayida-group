package com.joinway.mobile.bean.form;

import org.hibernate.validator.constraints.NotBlank;
import org.jsondoc.core.annotation.ApiObject;
import org.jsondoc.core.annotation.ApiObjectField;

import com.joinway.bean.logging.annotation.LogMask;
import com.joinway.bean.validation.constraints.CellPhone;

@ApiObject(name = "RegisterForm", description = "用户注册信息")
public class RegisterForm extends AuthForm {

	/**
	 * 
	 */

	private static final long serialVersionUID = -5927696607207875369L;

	@ApiObjectField(description = "手机号")
	@CellPhone
	@LogMask
	String cellPhone;
	
	@ApiObjectField(description = "真实姓名")
	@NotBlank
	@LogMask
	String userName;
	
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

	public String getCellPhone() {
		return cellPhone;
	}

	public void setCellPhone(String cellPhone) {
		this.cellPhone = cellPhone;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

}
