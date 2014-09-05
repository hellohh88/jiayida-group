package com.joinway.admin.bean.domain;

import java.util.Date;

import com.joinway.bean.domain.DomainEntity;

public class AcknowledgeLog extends DomainEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6194333580816831200L;

	int userId;
	
	String page;
	
	Date acknowledgeTime;

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getPage() {
		return page;
	}

	public void setPage(String page) {
		this.page = page;
	}

	public Date getAcknowledgeTime() {
		return acknowledgeTime;
	}

	public void setAcknowledgeTime(Date acknowledgeTime) {
		this.acknowledgeTime = acknowledgeTime;
	}
	
}

