package com.joinway.admin.utils;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;

import com.joinway.admin.bean.domain.TreeMenu;
import com.joinway.admin.bean.view.Menu;
import com.joinway.admin.bean.view.MenuAttribute;
import com.joinway.utils.data.Filter;
import com.joinway.utils.data.bean.Condition;

public final class UIHelper {

	public static List<Menu> convert(List<TreeMenu> menus) throws Exception {
		List<TreeMenu> roots = Filter.create(menus, Condition.create("parentId", 0)).result();
		List<Menu> rootMenus = null;
		
		if(CollectionUtils.isNotEmpty(roots)){
			rootMenus = new ArrayList<>();
			
			for(TreeMenu tm : roots){
				Menu menu = create(tm);
				rootMenus.add(menu);
			}
			
			for(Menu parent : rootMenus){
				setChildrenMenus(parent ,menus);
			}
			
		}
		
		return rootMenus;
	}
	
	static void setChildrenMenus(Menu parent, List<TreeMenu> menus) throws Exception {
		List<TreeMenu> childrenMenus = Filter.create(menus, Condition.create("parentId", parent.getId())).result();
		
		if(CollectionUtils.isNotEmpty(childrenMenus)){
			List<Menu> children = new ArrayList<>();
			
			for(TreeMenu tm : childrenMenus){
				Menu menu = create(tm);
				children.add(menu);
			}
			
			parent.setChildren(children);
			
			for(Menu p : children){
				setChildrenMenus(p, menus);
			}
		}
	}
	
	static Menu create(TreeMenu tm){
		Menu menu = new Menu();
		
		menu.setId(tm.getId());
		menu.setText(tm.getText());
		
		MenuAttribute attribute = new MenuAttribute();
		attribute.setUrl(tm.getUrl());
		
		menu.setAttribute(attribute);
		
		return menu;
	}
	
	private UIHelper(){}
}
