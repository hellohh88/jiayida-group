package com.joinway.mobile.push;

import java.util.HashMap;
import java.util.Map;

import org.junit.Test;

import com.joinway.appx.service.VelocityProcessor;

public class VelocityTest {

	VelocityProcessor processor = new VelocityProcessor();
	
	@Test public void test1() throws Exception{
		String s = "你好";
		
		System.out.println(new String(s.getBytes(), "UTF-8"));
		System.out.println(new String(s.getBytes(), "GBK"));
		
		Map<String, Object> model = new HashMap<>();
		model.put("html", s);
		
//		processor.process("notice.jsp", model, "notice2.jsp");
	}
}
