package com.joinway.mobile.exception;

import org.jsondoc.core.annotation.ApiObject;
import org.jsondoc.core.annotation.ApiObjectField;

@ApiObject(name = "MobileErrorConstants", description = "错误�?")
public final class MobileErrorConstants {

	public final static class RepeatRegister{
//		@ApiObjectField(description = "1-" + REPEAT_REGISTER_DESC)
		public static final String Description = "用户已注�?";
		public static final String Code = "1";
	}
//	public static final String REPEAT_REGISTER_DESC = "用户已注�?";
//	@ApiObjectField(description = "1-" + REPEAT_REGISTER_DESC)
//	public static final String REPEAT_REGISTER = "1";

	private MobileErrorConstants(){}
	
}
