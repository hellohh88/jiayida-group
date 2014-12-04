package com.joinway.mobile.exception;

import com.joinway.bean.exception.InternalException;

public class MobileException extends InternalException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public MobileException() {
		super();
	}

	public MobileException(String code, String description, String message, Throwable cause) {
		super(message, cause);
		super.code = Integer.valueOf(code);
		super.description = description;
	}

	public MobileException(String code, String description, String message) {
		super(message);
		super.code = Integer.valueOf(code);
		super.description = description;
	}

	public MobileException(String code, String description, Throwable cause) {
		super(cause);
		super.code = Integer.valueOf(code);
		super.description = description;
	}
	
	public MobileException(String code, String description) {
		super.code = Integer.valueOf(code);
		super.description = description;
	}

}
