package com.joinway.mobile.alipay.util;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import com.joinway.mobile.alipay.config.AlipayConfig;

/* *
 *类名：UtilDate
 *功能：自定义订单类
 *详细：工具类，可以用作获取系统日期、订单编号等
 *版本：3.3
 *日期：2012-08-17
 *说明：
 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 *该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
 */
public class UtilDate {
	
    /** 年月日时分秒(无下划线) yyyyMMddHHmmss */
    public static final String dtLong                  = "yyyyMMddHHmmss";
    
    /** 完整时间 yyyy-MM-dd HH:mm:ss */
    public static final String simple                  = "yyyy-MM-dd HH:mm:ss";
    
    /** 年月日(无下划线) yyyyMMdd */
    public static final String dtShort                 = "yyyyMMdd";
	
    
    /**
     * 返回系统当前时间(精确到毫秒),作为一个唯一的订单编号
     * @return
     *      以yyyyMMddHHmmss为格式的当前系统时间
     */
	public  static String getOrderNum(){
		Date date=new Date();
		DateFormat df=new SimpleDateFormat(dtLong);
		return df.format(date);
	}
	/**获取消费商的唯一订单号
	 * @return 返回yyyyMMddHHmmss-三个随机数
	 */
	public static String getOutTradeNo(){
		Date date=new Date();
		DateFormat df=new SimpleDateFormat(dtLong);
		return new StringBuffer(df.format(date)).append("-").append(getThree()).toString();
	}
	
	/**待签参数
	 * @param out_trade_no
	 * @param subject
	 * @param total_fee
	 * @param body
	 * @return
	 */
	public static Map<String,String> createMap(String subject,String total_fee,String body,String out_trade_no){
		Map<String,String> map=new HashMap<String, String>();
		map.put("service", AlipayConfig.service);
		map.put("partner", AlipayConfig.partner);
		map.put("_input_charset", AlipayConfig._input_charset);
		String notify_url=null;
		try {
			notify_url=URLEncoder.encode(AlipayConfig.notify_url, "utf-8").replace("*","*").replace("~", "~").replace("+"," ");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		map.put("notify_url", notify_url);
		map.put("payment_type", AlipayConfig.payment_type);
		map.put("seller_id", AlipayConfig.partner);
		//以下是非固定参数，输入参数必须不为空
		map.put("out_trade_no", out_trade_no);
		map.put("subject", subject);
		map.put("total_fee", total_fee);
		map.put("body", body);
		return AlipayCore.paraFilter(map);
	}
	/**全部参数map
	 * @param map	待签名参数
	 * @param sign	签名
	 * @return
	 */
	public Map<String,String> addSignMap(Map<String,String> map,String sign){
		map.put("sign_type", AlipayConfig.sign_type);
		map.put("sign", sign);
		return AlipayCore.paraFilter(map);
	}
	
	/**
	 * 获取系统当前日期(精确到毫秒)，格式：yyyy-MM-dd HH:mm:ss
	 * @return
	 */
	public  static String getDateFormatter(){
		Date date=new Date();
		DateFormat df=new SimpleDateFormat(simple);
		return df.format(date);
	}
	
	/**
	 * 获取系统当期年月日(精确到天)，格式：yyyyMMdd
	 * @return
	 */
	public static String getDate(){
		Date date=new Date();
		DateFormat df=new SimpleDateFormat(dtShort);
		return df.format(date);
	}
	
	/**
	 * 产生随机的三位数
	 * @return
	 */
	public static String getThree(){
		Random rad=new Random();
		return rad.nextInt(1000)+"";
	}
	
}
