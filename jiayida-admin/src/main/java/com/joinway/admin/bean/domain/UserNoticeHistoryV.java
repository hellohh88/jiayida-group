package com.joinway.admin.bean.domain;

import java.util.Date;

import com.joinway.bean.domain.DomainEntity;

public class UserNoticeHistoryV extends DomainEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5681020546395127003L;

	int noticeId;
	
	int userId;
	
	String name;
	
	String cellPhone;
	
	String status;
	
	Date acceptTime;

//	String pageName;
	
	String loginName;
	
	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

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

//	public String getPageName() {
//		return pageName;
//	}
//
//	public void setPageName(String pageName) {
//		this.pageName = pageName;
//	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	
	public int getNoticeId() {
		return noticeId;
	}

	public void setNoticeId(int noticeId) {
		this.noticeId = noticeId;
	}
}


