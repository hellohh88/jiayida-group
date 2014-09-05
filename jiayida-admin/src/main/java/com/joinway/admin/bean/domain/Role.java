package com.joinway.admin.bean.domain;

import com.joinway.bean.domain.DomainEntity;

public class Role extends DomainEntity {

	/**
* 
*/
	private static final long serialVersionUID = 3921926246008108958L;

	int roleId;

	String roleName;

	String description;

	public int getRoleId() {
		return roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
}
