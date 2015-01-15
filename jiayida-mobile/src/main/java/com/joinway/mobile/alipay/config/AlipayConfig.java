package com.joinway.mobile.alipay.config;


/* *
 *类名：AlipayConfig
 *功能：基础配置类
 *详细：设置帐户有关信息及返回路径
 *版本：3.3
 *日期：2012-08-10
 *说明：
 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 *该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
	
 *提示：如何获取安全校验码和合作身份者ID
 *1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
 *2.点击“商家服务”(https://b.alipay.com/order/myOrder.htm)
 *3.点击“查询合作者身份(PID)”、“查询安全校验码(Key)”

 *安全校验码查看时，输入支付密码后，页面呈灰色的现象，怎么办？
 *解决方法：
 *1、检查浏览器配置，不让浏览器做弹框屏蔽设置
 *2、更换浏览器或电脑，重新登录查询。
 */

public class AlipayConfig {
	//↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
	
	//卖家支付宝账号
	public static String seller_id="18909855898";
	
	// 合作身份者ID，以2088开头由16位纯数字组成的字符串
	public static String partner = "2088102920468761";
	
	// 商户的私钥
	//public static String private_key = "MIICXgIBAAKBgQCzplk2eqJD4gvho+DwqmlWsacPeTmnX/wOm8BW62+NVi7IXup7eJ12Vi0e8+zkP76N6MD1pKtz/mWVp1RYJRMF29IP0LAibcL7Fha1fTmPFNa/EEHQPdK+yD9DLPgj101RWaZt8Cen5FYBEPa1DR3d9QNYPFxc3KumCTiiIz43bwIDAQABAoGBAJjEUoTjT+0N4jCknPnKz/zq4TdlTMOp+buqcqr3VksICIxXOmp4rN4edgwmPUHzeuVOEhhRSYM/x761JiI2lK8twi6oIK8J6SJVzpuaG0sFuwa3N8V9xQvDP9Lt6YDvY/IZi3+f5kGsUOb2viPCKQju4oy9I93HToN03gCUz5xBAkEA74diZEpCbJMfx5dsDiWC3wT4Hn5DlkfeNxcIM85aBFIj4l2whTnpZB3cZUF2mkpUU5WaMuwas9wJTf79q1LLcQJBAMAA3a6fOZ0HHqTl5p9vdGWjaq08Eop7JqUv4eeyS9+U9rQkRU7Akqg6CgLhOs8d5xB1MeEMi8n/jBr+mWKPAN8CQAdWxpT8EXzyJQ8gfJcSXygmJtQIWlnIae6WLhIoSGnJen/9DuOGGriOkaooj1G65UqKUucshMTuAPr6zRrqtoECQQCmGtmtrVBRegxXyhD3k5uWJocucY70wM/RDpiYMtaTCbNYaxyOoej+op9wmFuhPRReV5UcRhdVXMBfxiz6aA7vAkEA7hF1v7zdmQZPUqujcknuMk/ZNYprAAENaNi8PSE3Z5qVHI7IYmRkTjLIUjA5qmxusXld3ZLYNzedid3ocLWF8Q==";
	public static String private_key = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCzplk2eqJD4gvho+DwqmlWsacPeTmnX/wOm8BW62+NVi7IXup7eJ12Vi0e8+zkP76N6MD1pKtz/mWVp1RYJRMF29IP0LAibcL7Fha1fTmPFNa/EEHQPdK+yD9DLPgj101RWaZt8Cen5FYBEPa1DR3d9QNYPFxc3KumCTiiIz43bwIDAQAB";
	
	// 支付宝的公钥，无需修改该值
//	public static String ali_public_key  = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCzplk2eqJD4gvho+DwqmlWsacPeTmnX/wOm8BW62+NVi7IXup7eJ12Vi0e8+zkP76N6MD1pKtz/mWVp1RYJRMF29IP0LAibcL7Fha1fTmPFNa/EEHQPdK+yD9DLPgj101RWaZt8Cen5FYBEPa1DR3d9QNYPFxc3KumCTiiIz43bwIDAQAB";
	public static String ali_public_key  = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB";

	// 返回值
	public static String notify_url  = new StringBuffer("http://test.xiaozhang.net.cn/").append("servlet/NotifyAction").toString();
	//↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
	
	// 交易安全检验码，由数字和字母组成的32位字符串
	// 如果签名方式设置为“MD5”时，请设置该参数
	public static String key = "39i1jj6zmdn6ahxkka0p7zvfxfzayv9p";

	//接口名称
	public static String service="mobile.securitypay.pay";

	// 调试用，创建TXT日志文件夹路径
	public static String log_path = "D:\\";

	// 字符编码格式 目前支持 gbk 或 utf-8
	public static String input_charset = "utf-8";
	public static String _input_charset="utf-8";
	
	// 签名方式 不需修改
	public static String sign_type = "MD5";
	
	//支付类型
	public static String payment_type="1";
	
}
