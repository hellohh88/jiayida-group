package com.joinway.admin.bean.form;

import com.joinway.bean.form.Form;

public class ResendForm extends Form {

	/**
	 * 
	 */
	private static final long serialVersionUID = -92641713961788395L;

	int userId;

	String targetUserIds;

	String pageName;
	
	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getTargetUserIds() {
		return targetUserIds;
	}

	public void setTargetUserIds(String targetUserIds) {
		this.targetUserIds = targetUserIds;
	}

	public String getPageName() {
		return pageName;
	}

	public void setPageName(String pageName) {
		this.pageName = pageName;
	}

}


