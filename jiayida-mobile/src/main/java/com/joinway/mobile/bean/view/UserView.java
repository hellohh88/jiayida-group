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

	@ApiObjectField(description = "用户姓名")
	String name;
	
	@ApiObjectField(description = "手机号码")
	String cellPhone;
	
	@ApiObjectField(description = "身份证号")
	String idCard;
	
	@ApiObjectField(description = "教练姓名")
	String coach;
	
	@ApiObjectField(description = "考试状态")
	String testStatus;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCellPhone() {
		return cellPhone;
	}

	public void setCellPhone(String cellPhone) {
		this.cellPhone = cellPhone;
	}

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	public String getCoach() {
		return coach;
	}

	public void setCoach(String coach) {
		this.coach = coach;
	}

	public String getTestStatus() {
		return testStatus;
	}

	public void setTestStatus(String testStatus) {
		this.testStatus = testStatus;
	}
	
}
