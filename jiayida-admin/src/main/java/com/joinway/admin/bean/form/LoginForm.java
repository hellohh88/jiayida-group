package com.joinway.admin.bean.form;

import org.hibernate.validator.constraints.Length;

import com.joinway.bean.form.Form;
import com.joinway.bean.logging.annotation.LogIgnore;
import com.joinway.bean.logging.annotation.LogMask;

public class LoginForm extends Form {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6560550145301724019L;

	@Length(min=1,max=20)
	@LogMask
	String name;
	
	@Length(min=1,max=20)
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
