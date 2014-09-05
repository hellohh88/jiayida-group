package com.joinway.mobile.mapper;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.joinway.common.bean.domain.LoginUser;

@Repository
public interface MobileMapper {

	LoginUser selectLoginUser(@Param("name") String name, @Param("password") String password);
	
//	void updateLoginUser(LoginUser user);
	
//	void insertLoginUser(LoginUser user);
	
}
