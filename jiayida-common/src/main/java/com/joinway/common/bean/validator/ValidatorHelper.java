package com.joinway.common.bean.validator;

import org.apache.commons.lang3.StringUtils;

public final class ValidatorHelper {

	public static boolean checkLength(String value, int min, int max){
		int len = StringUtils.trimToEmpty(value).length();
		
		return len >= min && len <= max;
	}
	
	private ValidatorHelper(){}
}
