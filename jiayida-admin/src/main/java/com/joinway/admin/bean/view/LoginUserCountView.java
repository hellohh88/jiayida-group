package com.joinway.admin.bean.view;

import com.joinway.appx.bean.view.ChartView;

public class LoginUserCountView extends ChartView {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	int loginCount;
	
	int registerCount;

	public int getLoginCount() {
		return loginCount;
	}

	public void setLoginCount(int loginCount) {
		this.loginCount = loginCount;
	}

	public int getRegisterCount() {
		return registerCount;
	}

	public void setRegisterCount(int registerCount) {
		this.registerCount = registerCount;
	}
}
