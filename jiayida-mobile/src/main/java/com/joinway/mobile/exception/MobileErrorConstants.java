package com.joinway.mobile.exception;

import org.jsondoc.core.annotation.ApiObject;

@ApiObject(name = "MobileErrorConstants", description = "错误�?")
public final class MobileErrorConstants {

	public final static class RepeatRegister{
//		@ApiObjectField(description = "1-" + REPEAT_REGISTER_DESC)
		public static final String Description = "用户已注册";
		public static final String Code = "1";
	}
	
	public final static class InvalidUserNameOrPassword {
		public static final String Description = "用户名或密码错误";
		public static final String Code = "2";
	}
	
	private MobileErrorConstants(){}
	
}
