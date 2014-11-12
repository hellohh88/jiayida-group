package com.joinway.admin.service;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.joinway.admin.BaseTest;
import com.joinway.admin.bean.form.LoginForm;
import com.joinway.admin.service.AdminPortalService;
import com.joinway.utils.CipherUtils;

/**
 * 这里包含service业务逻辑的测试用例
 * 
 * @author sc
 *
 */
public class AdminServiceTest extends BaseTest {

	@Autowired AdminPortalService service;
	
	@Test public void testLogin() throws Exception {
		LoginForm form = new LoginForm();
//		form.setName("lee");
//		form.setPassword("123");
		service.login("lee", "123");
	}
	
	@Test public void test(){
		System.out.println(CipherUtils.encrypt("super123"));
	}
}
