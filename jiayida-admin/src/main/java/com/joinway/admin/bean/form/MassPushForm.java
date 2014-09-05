package com.joinway.admin.bean.form;


public class MassPushForm extends PushAllForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3599903282267771914L;

	/**
	 * comma split ids
	 */
	String targetUserIds;

	public String getTargetUserIds() {
		return targetUserIds;
	}

	public void setTargetUserIds(String targetUserIds) {
		this.targetUserIds = targetUserIds;
	}

}
