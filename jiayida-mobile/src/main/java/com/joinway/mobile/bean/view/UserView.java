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

	@ApiObjectField(description = "真实姓名")
	String name;
	
	@ApiObjectField(description = "性别")
	String gender;
	
	@ApiObjectField(description = "收货地址")
	String address;
	
	@ApiObjectField(description = "邮编")
	String postalCode;
	
	@ApiObjectField(description = "电子邮箱")
	String email;
	
	@ApiObjectField(description = "qq号码")
	String qq;
	
	@ApiObjectField(description = "手机号码")
	String cellPhone;

	public String getCellPhone() {
		return cellPhone;
	}

	public void setCellPhone(String cellPhone) {
		this.cellPhone = cellPhone;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public String getPostalCode() {
		return postalCode;
	}

	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}
	
}
