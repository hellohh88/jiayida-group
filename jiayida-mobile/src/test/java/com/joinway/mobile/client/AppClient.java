package com.joinway.mobile.client;

import com.joinway.mobile.bean.form.LoginForm;
import com.joinway.mobile.bean.form.LogoutForm;
import com.joinway.mobile.bean.form.PasswordForm;
import com.joinway.mobile.bean.form.RegisterForm;
import com.joinway.net.http.HttpClientAdaptor;

public class AppClient {

	static final HttpClientAdaptor client = new HttpClientAdaptor();
	
	static final String BASE_URL = "http://localhost:8080/spring-mobile";
//	static final String BASE_URL = "http://115.28.198.131:8000/spring-mobile";
	
	/**
	 * @param args
	 */
	public static void main(String[] args) throws Exception {
//		login();
//		register();
		changePassword();
//		logout();
//		Object o = null;
//		Object oo = (Object)o;
//		out.println(oo);
	}

	static void register() throws Exception {
		RegisterForm form = new RegisterForm();
		form.setCellPhone("13998429427");
		form.setName("lee1232");
		form.setPassword("123456");
//		form.setPassword("654321");
//		form.setUserName("lee1234");
		
		client.post(BASE_URL + "/register", form);
//		client.post(BASE_URL + "/register", new PostParameterBuilder().add("name", "lee").add("password", "123").list());
	}

	static void login() throws Exception {
		LoginForm form = new LoginForm();
//		form.setName("lee1235");
//		form.setPassword("123456");
//		form.setMobileType("A");
//		form.setImId("123");
		
		form.setName("lee1232");
		form.setPassword("654321");
		form.setMobileType("A");
		form.setImId("123");

		client.post(BASE_URL + "/login", form);
	}

	static void logout() throws Exception {
		LogoutForm form = new LogoutForm();
		form.setUserId(3);
		client.post(BASE_URL + "/logout", form);
	}

	static void changePassword() throws Exception {
		PasswordForm form = new PasswordForm();
		form.setName("lee1232");
		form.setOldPassword("654321");
		form.setNewPassword("123456");
		client.post(BASE_URL + "/password", form);
	}

}
