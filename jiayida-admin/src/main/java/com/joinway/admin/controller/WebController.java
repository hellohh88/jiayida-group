package com.joinway.admin.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.joinway.web.audit.annotation.Audit;
import com.joinway.web.security.annotation.SecurityCheck;

@Controller
@RequestMapping("")
@Validated
public class WebController {

	private final static Logger log = LoggerFactory.getLogger(WebController.class);
	
	@RequestMapping(value="tabs/{table}")
	@Audit
	@SecurityCheck
	public ModelAndView tab(@PathVariable("table") String table) throws Exception {
		ModelAndView mv = new ModelAndView("tabs/" + table);
		return mv;
	}
	
	@RequestMapping("tabs/notice/history/mass")
	public ModelAndView page(@RequestParam("noticeId") String noticeId){
		ModelAndView mv = new ModelAndView("mass");
		
		mv.addObject("noticeId", noticeId);
		
		return mv;
	}

}

