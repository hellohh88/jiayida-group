package com.joinway.admin;

import static java.lang.System.out;
import static org.springframework.test.web.server.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.server.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.server.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.server.setup.MockMvcBuilders.standaloneSetup;

import java.util.List;

import org.apache.http.NameValuePair;
import org.springframework.http.MediaType;
import org.springframework.test.web.server.request.DefaultRequestBuilder;
import org.springframework.util.CollectionUtils;

import com.joinway.bean.form.Form;
import com.joinway.utils.json.JsonConverter;

public abstract class ControllerTest extends BaseTest {

	protected abstract Object getController();
	
	protected String postRequest(Form form, String url) throws Exception {
		String input = JsonConverter.objectToJson(form);
		out.println("input -> " + input);
		
	    String output = standaloneSetup(getController())
				.build()
				.perform(
						post(url).body(input.getBytes("UTF-8"))
								.contentType(MediaType.APPLICATION_JSON)
								.accept(MediaType.APPLICATION_JSON)
//								.headers(ClientHelper.getHeaders())
				).andReturn().getResponse().getContentAsString();
	    
	    out.println("output -> " + output);
	    
	    return output;
	}
	
	protected String postRequest(String url, List<NameValuePair> params) throws Exception {
		DefaultRequestBuilder builder = post(url);
		if(!CollectionUtils.isEmpty(params)){
			for(NameValuePair nvp : params){
				builder.param(nvp.getName(), nvp.getValue());
			}
		}
		
	    String output = standaloneSetup(getController())
				.build().perform(
						builder.contentType(MediaType.APPLICATION_FORM_URLENCODED)
								.accept(MediaType.APPLICATION_JSON)
				).andExpect(status().isOk()).andReturn().getResponse().getContentAsString();
	    
	    out.println(output);
	    
	    return output;
	}
	
	protected String getRequest(String url) throws Exception {
		return getRequest(url, "");
	}

	protected String getRequest(String url, String query) throws Exception {
		String output = standaloneSetup(getController())
				.build().perform(
						get(url + query).accept(MediaType.APPLICATION_JSON)
//								.headers(ClientHelper.getHeaders())
				).andExpect(status().isOk()).andReturn().getResponse().getContentAsString();
		
		out.println(output);
		
		return output;
	}
}
