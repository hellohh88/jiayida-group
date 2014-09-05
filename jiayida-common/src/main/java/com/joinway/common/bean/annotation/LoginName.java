package com.joinway.common.bean.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import javax.validation.Constraint;
import javax.validation.Payload;

import com.joinway.common.bean.validator.LoginNameValidator;

@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Constraint(validatedBy = LoginNameValidator.class)
public @interface LoginName {

//	String message() default "{com.joinway.bean.validation.constraints.CellPhone.message}";
	String message() default "登录名必须为3-20个字符";
	
	Class<?>[] groups() default { };

	Class<? extends Payload>[] payload() default { };
	
}