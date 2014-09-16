package com.joinway.mobile.bean.view;

import org.jsondoc.core.annotation.ApiObject;
import org.jsondoc.core.annotation.ApiObjectField;

import com.joinway.bean.view.View;

@ApiObject(name = "UserView", description = "用户信息")
public class UserView extends View {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5697166039571340724L;

	@ApiObjectField(description = "手机号码")
	String cellPhone;

	public String getCellPhone() {
		return cellPhone;
	}

	public void setCellPhone(String cellPhone) {
		this.cellPhone = cellPhone;
	}
	
}
