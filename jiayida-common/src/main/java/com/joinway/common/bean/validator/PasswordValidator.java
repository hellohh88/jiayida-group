package com.joinway.common.bean.validator;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

import com.joinway.common.bean.annotation.Password;

public class PasswordValidator implements ConstraintValidator<Password, String> {

	final static int MIN_LEN = 6;
	final static int MAX_LEN = 20;

	@Override
	public void initialize(Password constraintAnnotation) {
		
	}

	@Override
	public boolean isValid(String value, ConstraintValidatorContext context) {
		return ValidatorHelper.checkLength(value, MIN_LEN, MAX_LEN);
	}

}
