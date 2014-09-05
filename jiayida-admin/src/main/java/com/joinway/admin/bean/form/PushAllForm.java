package com.joinway.admin.bean.form;

import javax.validation.constraints.Min;

import org.hibernate.validator.constraints.NotBlank;

import com.joinway.bean.form.Form;

public class PushAllForm extends Form {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1834597870964496690L;

	/**
	 * 发送通知的管理员id
	 */
	@Min(1)
	int userId;
	
	String title;
	
	@NotBlank
	String text;

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
}

