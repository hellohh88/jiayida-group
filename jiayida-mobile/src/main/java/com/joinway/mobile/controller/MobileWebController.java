package com.joinway.mobile.controller;

import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("page")
@Validated
public class MobileWebController {

	@RequestMapping("{page}")
	public ModelAndView page(@PathVariable("page") String page){
		return new ModelAndView(page);
	}
}
