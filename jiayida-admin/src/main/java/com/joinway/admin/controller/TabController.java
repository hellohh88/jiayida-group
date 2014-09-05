package com.joinway.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("tabs")
@Validated
public class TabController {

	@RequestMapping("notice/history/mass")
	public ModelAndView page(@RequestParam("noticeId") String noticeId){
		ModelAndView mv = new ModelAndView("mass");
		
		mv.addObject("noticeId", noticeId);
		
		return mv;
	}
}
