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

	public MobileException(String code, String message, Throwable cause) {
		super(message, cause);
		super.code = Integer.valueOf(code);
	}

	public MobileException(String code, String message) {
		super(message);
		super.code = Integer.valueOf(code);
	}

	public MobileException(String code, Throwable cause) {
		super(cause);
		super.code = Integer.valueOf(code);
	}
	
	

}
