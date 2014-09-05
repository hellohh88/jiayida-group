package com.joinway.mobile.client;

import java.util.ArrayList;
import java.util.List;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;

public class PostParameterBuilder {

	List<NameValuePair> params = new ArrayList<>();
	
	public PostParameterBuilder add(String name, String value){
		params.add(new BasicNameValuePair(name, value));
		return this;
	}
	
	public List<NameValuePair> list(){
		return params;
	}

}
