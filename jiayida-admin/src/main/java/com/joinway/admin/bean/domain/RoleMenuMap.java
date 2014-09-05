package com.joinway.admin.bean.domain;

import com.joinway.bean.domain.DomainEntity;

public class RoleMenuMap extends DomainEntity {

	/**
* 
*/
	private static final long serialVersionUID = 8783447342731640907L;

	int roleId;

	int menuId;

	public int getRoleId() {
		return roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}

	public int getMenuId() {
		return menuId;
	}

	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}

}
