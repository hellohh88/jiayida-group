package com.joinway.admin.bean.form;

import org.hibernate.validator.constraints.Length;

import com.joinway.bean.form.Form;
import com.joinway.bean.logging.annotation.LogIgnore;
import com.joinway.bean.logging.annotation.LogMask;

public class RegisterForm extends Form {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6350947483883363829L;

	@Length(min=1,max=20)
	@LogMask
	protected String name;
	
	@Length(min=1,max=20)
	@LogIgnore
	protected String password;

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
