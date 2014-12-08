package com.joinway.mobile.controller;

import java.util.Arrays;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.joinway.mobile.bean.view.DemoItem;

@Controller
@RequestMapping("page")
@Validated
public class MobileWebController {

	@RequestMapping("demo")
	public ModelAndView page(@RequestParam("name") String name){
		ModelAndView mv = new ModelAndView("demo");
		
		List<DemoItem> items = Arrays.asList(new DemoItem[]{new DemoItem("iPhone", 6999), new DemoItem("XiaoMi", 1999.99)});
		mv.addObject("items", items);
		mv.addObject("name", name);
		
		return mv;
	}
}
