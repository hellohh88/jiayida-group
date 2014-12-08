package com.joinway.mobile.bean.view;

import com.joinway.bean.BaseBean;

public class DemoItem extends BaseBean {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	String name;
	
	double price;

	public DemoItem(String name, double price) {
		this.name = name;
		this.price = price;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}
	
}
