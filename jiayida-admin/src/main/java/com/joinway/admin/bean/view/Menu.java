package com.joinway.admin.bean.view;

import java.util.List;

import org.jsondoc.core.annotation.ApiObject;
import org.jsondoc.core.annotation.ApiObjectField;

import com.joinway.bean.BaseBean;

@ApiObject(name = "Menu", description = "UI菜单")
public class Menu extends BaseBean {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2350776997220196320L;
	
	@ApiObjectField(description = "菜单id")
	int id;
	
	@ApiObjectField(description = "菜单文字")
	String text;
	
	@ApiObjectField(description = "菜单")
	MenuAttribute attribute;

	@ApiObjectField(description = "子菜单")
	List<Menu> children;
	
	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public List<Menu> getChildren() {
		return children;
	}

	public void setChildren(List<Menu> children) {
		this.children = children;
	}

	public MenuAttribute getAttribute() {
		return attribute;
	}

	public void setAttribute(MenuAttribute attribute) {
		this.attribute = attribute;
	}

}
