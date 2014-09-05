package com.joinway.admin.bean.domain;

import com.joinway.bean.domain.DomainEntity;
import com.joinway.bean.domain.annotation.DomainField;
import com.joinway.bean.domain.type.CaseFormat;

public class TreeMenu extends DomainEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2057603312861779030L;

	String text;
	
	int parentId;
	
	@DomainField(CaseFormat.Upper)
	String status;
	
	@DomainField(CaseFormat.Lower)
	String url;

	int order;
	
	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public int getParentId() {
		return parentId;
	}

	public void setParentId(int parentId) {
		this.parentId = parentId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public int getOrder() {
		return order;
	}

	public void setOrder(int order) {
		this.order = order;
	}

//	public String getTitle() {
//		return title;
//	}
//
//	public void setTitle(String title) {
//		this.title = title;
//	}
	
}
