package com.joinway.mobile.controller;

import static java.lang.System.out;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.fasterxml.jackson.core.type.TypeReference;
import com.joinway.bean.view.View;
import com.joinway.mobile.ControllerTest;
import com.joinway.mobile.bean.form.LoginForm;
import com.joinway.mobile.bean.form.RegisterForm;
import com.joinway.mobile.bean.view.LoginView;
import com.joinway.utils.json.JsonConverter;

/**
 * controller只需要测试连通性即可
 * 
 * @author sc
 *
 */
public class MobileControllerTest extends ControllerTest {

	@Autowired MobileController controller;
	
	@Override
	protected Object getController() {
		return controller;
	}

	@Test public void testRegister() throws Exception {
	    RegisterForm form = new RegisterForm();
	    
	    form.setName("lee");
	    form.setCellPhone("12345678901");
	    form.setPassword("123456789");
	    
	    String output = "";
	    output = postRequest(form, "/register");
	    
	    LoginView view = JsonConverter.jsonToObject(output, new TypeReference<LoginView>(){});
	    
		out.println(view);
	}
	
	@Test public void testLogin() throws Exception {
	    LoginForm form = new LoginForm();
	    
	    form.setName("13998420000");
	    form.setPassword("123456");
	    
	    String output = "";
	    output = postRequest(form, "/login");
	    
	    LoginView view = JsonConverter.jsonToObject(output, new TypeReference<LoginView>(){});
	    
		out.println(view);
	}

	@Test public void testLogout() throws Exception {
//	    LogoutForm form = new LogoutForm();
//	    form.setName("lee");
	    
	    String output = getRequest("/logout");
	    
	    View view = JsonConverter.jsonToObject(output, new TypeReference<View>(){});
	    
		out.println(view);
	}

}
