package com.joinway.admin.bean.domain;

import com.joinway.bean.domain.DomainEntity;

public class UserRole extends DomainEntity {

	/**
* 
*/
	private static final long serialVersionUID = -8792339660692981136L;

	int userId;

	int roleId;

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getRoleId() {
		return roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}

}