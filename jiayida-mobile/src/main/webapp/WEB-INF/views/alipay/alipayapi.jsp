<%
/* *
 *功能：手机网页支付接入页
 *版本：3.3
 *日期：2012-08-14
 *说明：
 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 *该代码仅供学习和研究支付宝接口使用，只是提供一个参考。

 *************************注意*****************
 *如果您在接口集成过程中遇到问题，可以按照下面的途径来解决
 *1、商户服务中心（https://b.alipay.com/support/helperApply.htm?action=consultationApply），提交申请集成协助，我们会有专业的技术工程师主动联系您协助解决
 *2、商户帮助中心（http://help.alipay.com/support/232511-16307/0-16307.htm?sh=Y&info_type=9）
 *3、支付宝论坛（http://club.alipay.com/read-htm-tid-8681712.html）
 *如果不想使用扩展功能请把扩展功能参数赋空值。
 **********************************************
 */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.joinway.mobile.alipay.config.*"%>
<%@ page import="com.joinway.mobile.alipay.util.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.net.URLDecoder"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>支付宝手机网页支付</title>
	</head>
	<%
		//支付宝网关地址
		String ALIPAY_GATEWAY_NEW = "http://wappaygw.alipay.com/service/rest.htm?";

		////////////////////////////////////调用授权接口alipay.wap.trade.create.direct获取授权码token//////////////////////////////////////
		
		//返回格式
		String format = "xml";
		//必填，不需要修改
		
		//返回格式
		String v = "2.0";
		//必填，不需要修改
		
		//请求号
		String req_id = UtilDate.getOrderNum();
		//必填，须保证每次请求都是唯一
		
		//req_data详细信息
		
		//服务器异步通知页面路径
		//String notify_url = "http://www.xxx.com/WS_WAP_PAYWAP-JAVA-UTF-8/notify_url.jsp";
		// test
		//String notify_url = "http://test.xiaozhang.net.cn/alipay/notify_url.jsp";
		// 正式环境
		//String notify_url = "http://ws.xiaozhang.net.cn/alipay/notify_url.jsp";
		
		//localhost
		String notify_url = "http://192.168.1.109:8080/jiayida-mobile/alipay/notify_url.jsp";
		//需http://格式的完整路径，不能加?id=123这类自定义参数

		//页面跳转同步通知页面路径
		// test
		//String call_back_url = "http://test.xiaozhang.net.cn/alipay/call_back_url.jsp";
		// 正式环境
		//String call_back_url = "http://ws.xiaozhang.net.cn/alipay/call_back_url.jsp";
		// localhost
		String call_back_url = "http://192.168.1.109:8080/jiayida-mobile/alipay/call_back_url.jsp";
		//需http://格式的完整路径，不能加?id=123这类自定义参数，不能写成http://localhost/

		//操作中断返回地址
		// test
		//String merchant_url = "http://test.xiaozhang.net.cn/alipay/index.jsp";
		// 正式环境
		//String merchant_url = "http://ws.xiaozhang.net.cn/alipay/index.jsp";
		// localhost
		String merchant_url = "http://192.168.1.109:8080/jiayida-mobile/alipay/index.jsp";
		//用户付款中途退出返回商户的地址。需http://格式的完整路径，不允许加?id=123这类自定义参数

		//卖家支付宝帐户
		String seller_email = AlipayConfig.seller_id;//new String(request.getParameter("WIDseller_email").getBytes("ISO-8859-1"),"UTF-8");
		//必填

		//商户订单号
		//String out_trade_no = new String(request.getParameter("WIDout_trade_no").getBytes("ISO-8859-1"),"UTF-8");
		String out_trade_no = (String)request.getAttribute("WIDout_trade_no");
		//商户网站订单系统中唯一订单号，必填

		//订单名称
		//String subject = new String(request.getParameter("WIDsubject").getBytes("ISO-8859-1"),"UTF-8");
		String subject = (String)request.getAttribute("WIDsubject");
		//必填

		//付款金额
		//String total_fee = new String(request.getParameter("WIDtotal_fee").getBytes("ISO-8859-1"),"UTF-8");
		String total_fee = (String)request.getAttribute("WIDtotal_fee");
		//必填
		
		//请求业务参数详细
		String req_dataToken = "<direct_trade_create_req><notify_url>" + notify_url + "</notify_url><call_back_url>" + call_back_url + "</call_back_url><seller_account_name>" + seller_email + "</seller_account_name><out_trade_no>" + out_trade_no + "</out_trade_no><subject>" + subject + "</subject><total_fee>" + total_fee + "</total_fee><merchant_url>" + merchant_url + "</merchant_url></direct_trade_create_req>";
		//String req_dataToken = "<direct_trade_create_req><subject>彩票</subject><out_trade_no>1282889603601</out_trade_no><total_fee>10.01</total_fee><seller_account_name>1852886290@qq.com</seller_account_name><call_back_url>http://www.yoursite.com/waptest0504/servlet/CallBack</call_back_url><notify_url>http://www.yoursite.com/waptest0504/servlet/NotifyReceiver</notify_url><out_user>123456789</out_user><merchant_url>http://www.yoursite.com</merchant_url><pay_expire>3600</pay_expire><agent_id>11397568a1</agent_id></direct_trade_create_req>";
		//必填
		
		//////////////////////////////////////////////////////////////////////////////////
		
		//把请求参数打包成数组
		Map<String, String> sParaTempToken = new HashMap<String, String>();
		sParaTempToken.put("service", "alipay.wap.trade.create.direct");
		sParaTempToken.put("partner", AlipayConfig.partner);
		sParaTempToken.put("_input_charset", AlipayConfig.input_charset);
		sParaTempToken.put("sec_id", AlipayConfig.sign_type);
		System.out.println(AlipayConfig.sign_type);
		sParaTempToken.put("format", format);
		sParaTempToken.put("v", v);
		sParaTempToken.put("req_id", req_id);
		sParaTempToken.put("req_data", req_dataToken);
		System.out.println(req_dataToken);
		//建立请求
		String sHtmlTextToken = AlipaySubmit.buildRequest(ALIPAY_GATEWAY_NEW,"", "",sParaTempToken);
		//URLDECODE返回的信息
		sHtmlTextToken = URLDecoder.decode(sHtmlTextToken,AlipayConfig.input_charset);
		System.out.println("sHtmlTextToken:"+sHtmlTextToken);
		//获取token
		String request_token = AlipaySubmit.getRequestToken(sHtmlTextToken);
		System.out.println(request_token);
		
		////////////////////////////////////根据授权码token调用交易接口alipay.wap.auth.authAndExecute//////////////////////////////////////
		
		//业务详细
		String req_data = "<auth_and_execute_req><request_token>" + request_token + "</request_token></auth_and_execute_req>";
		System.out.println(req_data);
		//必填
		
		//把请求参数打包成数组
		Map<String, String> sParaTemp = new HashMap<String, String>();
		sParaTemp.put("service", "alipay.wap.auth.authAndExecute");
		sParaTemp.put("partner", AlipayConfig.partner);
		sParaTemp.put("_input_charset", AlipayConfig.input_charset);
		sParaTemp.put("sec_id", AlipayConfig.sign_type);
		sParaTemp.put("format", format);
		sParaTemp.put("v", v);
		sParaTemp.put("req_data", req_data);
		
		//建立请求
		String sHtmlText = AlipaySubmit.buildRequest(ALIPAY_GATEWAY_NEW, sParaTemp, "get", "确认");
		out.println(sHtmlText);
	%>
	<body>
	</body>
</html>
