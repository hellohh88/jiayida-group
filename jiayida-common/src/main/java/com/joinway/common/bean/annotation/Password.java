package com.joinway.common.bean.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import javax.validation.Constraint;
import javax.validation.Payload;

import com.joinway.common.bean.validator.PasswordValidator;

@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Constraint(validatedBy = PasswordValidator.class)
public @interface Password {
	String message() default "密码必须为6-20个字符";
	
	Class<?>[] groups() default { };

	Class<? extends Payload>[] payload() default { };
}
