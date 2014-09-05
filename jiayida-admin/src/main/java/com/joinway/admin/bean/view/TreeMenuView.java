package com.joinway.admin.bean.view;

import java.util.List;

import org.jsondoc.core.annotation.ApiObject;
import org.jsondoc.core.annotation.ApiObjectField;

import com.joinway.bean.view.View;

@ApiObject(name = "TreeMenuView", description = "树形菜单")
public class TreeMenuView extends View {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2374561582000158764L;

	@ApiObjectField(description = "菜单项")
	List<Menu> menus;

	public List<Menu> getMenus() {
		return menus;
	}

	public void setMenus(List<Menu> menus) {
		this.menus = menus;
	}
}
