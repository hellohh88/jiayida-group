package com.joinway.admin.bean.view;

import org.jsondoc.core.annotation.ApiObject;
import org.jsondoc.core.annotation.ApiObjectField;

import com.joinway.bean.BaseBean;

@ApiObject(name = "MenuAttribute", description = "菜单属性")
public class MenuAttribute extends BaseBean {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2727313860928577953L;

	@ApiObjectField(description = "菜单url")
	String url;

//	String title;
	
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

//	public String getTitle() {
//		return title;
//	}
//
//	public void setTitle(String title) {
//		this.title = title;
//	}
	
}
