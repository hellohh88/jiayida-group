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

	@RequestMapping("alipay/index")
	public ModelAndView alipayIndex(){
		ModelAndView mv = new ModelAndView("alipay/index");
		return mv;
	}
	
	@RequestMapping("alipay/alipayapi")
	public ModelAndView alipay(@RequestParam("uId") String uId,
			@RequestParam("origin_str") String originStr){
		ModelAndView mv = new ModelAndView("alipay/alipayapi");

		// 购买类型
		//String type_str = (String)request.getParameter("type");

		// 产品ID 可以查询出价格 如 优惠课程ID
		//String pId = (String)request.getParameter("pId");
		
		//user ID
		String userinfo_id = uId;//(String)request.getParameter("uId");
		
		//数量
		//String quantity_str = (String)request.getParameter("quantity_str");

		//总款
		String origin_str = originStr;//(String)request.getParameter("origin_str");
		
		// 业务生成订单
		// @ TODO
		// 商户订单号
		String WIDout_trade_no = "1111111111111";
		
		// 订单名称
		String WIDsubject = "苏氏牛奶草莓";
		// 付款金额
		String WIDtotal_fee = "0.01";
		mv.addObject("WIDout_trade_no", WIDout_trade_no);
		mv.addObject("WIDsubject", WIDsubject);
		mv.addObject("WIDtotal_fee", WIDtotal_fee);
		
		return mv;
	}
}
