package com.joinway.common.bean.domain;

import java.util.Date;

import com.joinway.bean.domain.DomainEntity;

public class LoginUser extends DomainEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1L;

	protected int userId;
	
	protected String email;
	
	protected String userName;
	
	protected String password;
	
	protected String question;
	
	protected String answer;
	
	protected int sex;
	
	protected Date birthday;
	
	protected double userMoney;
	
	protected double frozenMoney;
	
	protected int payPoints;
	
	protected int rankPoints;
	
	protected int addressId;
	
	protected int regTime;
	
	protected int lastLogin;
	
	protected Date lastTime;
	
	protected String lastIp;
	
	protected int visitCount;
	
	protected int userRank;
	
	protected int isSpecial;
	
	protected String ecSalt;
	
	protected String salt;
	
	protected int parentId;
	
	protected int flag;
	
	protected String alias;
	
	protected String msn;
	
	protected String qq;
	
	protected String officePhone;
	
	protected String homePhone;
	
	protected String mobilePhone;
	
	protected int isValidated;
	
	protected double creditLine;
	
	protected String passwdQuestion;
	
	protected String passwdAnswer;
	
	protected String imId;
	
	protected String cellPhoneType;
	
	@Override
	public String getIdName() {
		return "USER_ID";
	}

	public int getUserId(){
		return userId;
	}
	
	public void setUserId(int userId){
		this.userId = userId;
	}
	
	public String getEmail(){
		return email;
	}
	
	public void setEmail(String email){
		this.email = email;
	}
	
	public String getUserName(){
		return userName;
	}
	
	public void setUserName(String userName){
		this.userName = userName;
	}
	
	public String getPassword(){
		return password;
	}
	
	public void setPassword(String password){
		this.password = password;
	}
	
	public String getQuestion(){
		return question;
	}
	
	public void setQuestion(String question){
		this.question = question;
	}
	
	public String getAnswer(){
		return answer;
	}
	
	public void setAnswer(String answer){
		this.answer = answer;
	}
	
	public int getSex(){
		return sex;
	}
	
	public void setSex(int sex){
		this.sex = sex;
	}
	
	public Date getBirthday(){
		return birthday;
	}
	
	public void setBirthday(Date birthday){
		this.birthday = birthday;
	}
	
	public double getUserMoney(){
		return userMoney;
	}
	
	public void setUserMoney(double userMoney){
		this.userMoney = userMoney;
	}
	
	public double getFrozenMoney(){
		return frozenMoney;
	}
	
	public void setFrozenMoney(double frozenMoney){
		this.frozenMoney = frozenMoney;
	}
	
	public int getPayPoints(){
		return payPoints;
	}
	
	public void setPayPoints(int payPoints){
		this.payPoints = payPoints;
	}
	
	public int getRankPoints(){
		return rankPoints;
	}
	
	public void setRankPoints(int rankPoints){
		this.rankPoints = rankPoints;
	}
	
	public int getAddressId(){
		return addressId;
	}
	
	public void setAddressId(int addressId){
		this.addressId = addressId;
	}
	
	public int getRegTime(){
		return regTime;
	}
	
	public void setRegTime(int regTime){
		this.regTime = regTime;
	}
	
	public int getLastLogin(){
		return lastLogin;
	}
	
	public void setLastLogin(int lastLogin){
		this.lastLogin = lastLogin;
	}
	
	public Date getLastTime(){
		return lastTime;
	}
	
	public void setLastTime(Date lastTime){
		this.lastTime = lastTime;
	}
	
	public String getLastIp(){
		return lastIp;
	}
	
	public void setLastIp(String lastIp){
		this.lastIp = lastIp;
	}
	
	public int getVisitCount(){
		return visitCount;
	}
	
	public void setVisitCount(int visitCount){
		this.visitCount = visitCount;
	}
	
	public int getUserRank(){
		return userRank;
	}
	
	public void setUserRank(int userRank){
		this.userRank = userRank;
	}
	
	public int getIsSpecial(){
		return isSpecial;
	}
	
	public void setIsSpecial(int isSpecial){
		this.isSpecial = isSpecial;
	}
	
	public String getEcSalt(){
		return ecSalt;
	}
	
	public void setEcSalt(String ecSalt){
		this.ecSalt = ecSalt;
	}
	
	public String getSalt(){
		return salt;
	}
	
	public void setSalt(String salt){
		this.salt = salt;
	}
	
	public int getParentId(){
		return parentId;
	}
	
	public void setParentId(int parentId){
		this.parentId = parentId;
	}
	
	public int getFlag(){
		return flag;
	}
	
	public void setFlag(int flag){
		this.flag = flag;
	}
	
	public String getAlias(){
		return alias;
	}
	
	public void setAlias(String alias){
		this.alias = alias;
	}
	
	public String getMsn(){
		return msn;
	}
	
	public void setMsn(String msn){
		this.msn = msn;
	}
	
	public String getQq(){
		return qq;
	}
	
	public void setQq(String qq){
		this.qq = qq;
	}
	
	public String getOfficePhone(){
		return officePhone;
	}
	
	public void setOfficePhone(String officePhone){
		this.officePhone = officePhone;
	}
	
	public String getHomePhone(){
		return homePhone;
	}
	
	public void setHomePhone(String homePhone){
		this.homePhone = homePhone;
	}
	
	public String getMobilePhone(){
		return mobilePhone;
	}
	
	public void setMobilePhone(String mobilePhone){
		this.mobilePhone = mobilePhone;
	}
	
	public int getIsValidated(){
		return isValidated;
	}
	
	public void setIsValidated(int isValidated){
		this.isValidated = isValidated;
	}
	
	public double getCreditLine(){
		return creditLine;
	}
	
	public void setCreditLine(double creditLine){
		this.creditLine = creditLine;
	}
	
	public String getPasswdQuestion(){
		return passwdQuestion;
	}
	
	public void setPasswdQuestion(String passwdQuestion){
		this.passwdQuestion = passwdQuestion;
	}
	
	public String getPasswdAnswer(){
		return passwdAnswer;
	}
	
	public void setPasswdAnswer(String passwdAnswer){
		this.passwdAnswer = passwdAnswer;
	}
	
	public String getImId(){
		return imId;
	}
	
	public void setImId(String imId){
		this.imId = imId;
	}
	
	public String getCellPhoneType(){
		return cellPhoneType;
	}
	
	public void setCellPhoneType(String cellPhoneType){
		this.cellPhoneType = cellPhoneType;
	}
	
}