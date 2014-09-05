package com.joinway.mobile.client;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.apache.http.Consts;

public class GetParameterBuilder {

	String query = "";
	
	public GetParameterBuilder add(String name, String value) throws UnsupportedEncodingException {
		query = query + name + "=" + URLEncoder.encode(value, Consts.UTF_8.toString()) + "&"; 
		return this;
	}
	
	public String query(){
		if (query.length() > 0) {
			query = query.substring(0, query.length() - 1);
			query = "?" + query;
		}
		
		return query;
	}
}
