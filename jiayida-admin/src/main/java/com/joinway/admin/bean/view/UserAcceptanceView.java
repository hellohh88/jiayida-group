package com.joinway.admin.bean.view;

import java.util.Date;

import com.joinway.bean.view.View;

@Deprecated
public class UserAcceptanceView extends View {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8259705813427780509L;

	String name;
	
	String status;
	
	Date acceptTime;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getAcceptTime() {
		return acceptTime;
	}

	public void setAcceptTime(Date acceptTime) {
		this.acceptTime = acceptTime;
	}
}

