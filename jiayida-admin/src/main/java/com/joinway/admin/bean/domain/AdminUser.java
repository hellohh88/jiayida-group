package com.joinway.admin.bean.domain;

import java.util.Date;

import com.joinway.bean.constant.DBValueConstants;
import com.joinway.bean.domain.DomainEntity;
import com.joinway.bean.domain.annotation.DomainField;
import com.joinway.bean.domain.type.CaseFormat;
import com.joinway.bean.logging.annotation.LogIgnore;
import com.joinway.bean.logging.annotation.LogMask;

public class AdminUser extends DomainEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = -2938665189298158123L;

	@DomainField(CaseFormat.Lower)
	@LogMask
	String loginName;
	
	@LogIgnore
	String password;
	
	int loginCount;
	
	String status = DBValueConstants.YES;
	
	Date createTime;
	
	Date lastLoginTime;

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getLastLoginTime() {
		return lastLoginTime;
	}

	public void setLastLoginTime(Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

	public int getLoginCount() {
		return loginCount;
	}

	public void setLoginCount(int loginCount) {
		this.loginCount = loginCount;
	}

}
