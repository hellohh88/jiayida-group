package com.joinway.mobile.client;

import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;

import com.joinway.mobile.bean.form.LoginForm;
import com.joinway.net.http.HttpClientAdaptor;

public class SSOTestClient {

	static final String BASE_URL = "http://localhost:7080/jiayida-mobile";
	
	static final HttpClientAdaptor client1 = new HttpClientAdaptor();
	
	static final HttpClientAdaptor client2 = new HttpClientAdaptor();
	
	public static void main(String[] args) throws Exception {
		test1();
	}
	
	static void test1() throws Exception {
		LoginForm form = new LoginForm();
		form.setName("test");
		form.setPassword("123456");
		form.setImId("aaa");
		
		String output = client1.post(BASE_URL + "/login", form);
		JSONObject json = new JSONObject(output);
		
		System.out.println(output);
		System.out.println("token=" + json.get("token"));

//		form.setPassword("654321");
		output = client2.post(BASE_URL + "/login", form);
		System.out.println(output);
		
		Map<String, String> headers = new HashMap<>();
		headers.put("com.joinway.sso.token", json.get("token").toString());
		
		Map<String, String> query = new HashMap<>();
		query.put("userId", "1");
		
		output = client1.get(BASE_URL + "/user", query, headers);
		
		System.out.println(output);
	}
}
