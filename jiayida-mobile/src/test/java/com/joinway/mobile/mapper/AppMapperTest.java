package com.joinway.mobile.mapper;

import java.util.Date;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.joinway.common.bean.domain.LoginUser;
import com.joinway.mobile.BaseTest;
import com.joinway.mobile.mapper.MobileMapper;

/**
 * 确保SQL语句没有语法错误
 * 
 * @author sc
 *
 */
public class AppMapperTest extends BaseTest {

	@Autowired MobileMapper mapper;
	
	@Test public void testSelectLoginUser(){
		mapper.selectLoginUser("", "");
	}
	
//	@Test public void testSelectTreeMenu(){
//		mapper.selectTreeMenu();
//	}
	
//	@Test public void testUpdateUser(){
//		LoginUser user = createLoginUser();
//		mapper.updateLoginUser(user);
//	}
	
//	@Test public void testInsertLoginUser(){
//		LoginUser user = createLoginUser();
//		mapper.insertLoginUser(user);
//	}
	
	LoginUser createLoginUser(){
		LoginUser user = new LoginUser();
		user.setLoginName("a");
		user.setPassword("b");
		user.setLastLoginTime(new Date());
		
		return user;
	}
}
