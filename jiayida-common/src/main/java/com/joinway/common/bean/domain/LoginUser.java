package com.joinway.common.bean.domain;

import java.math.BigDecimal;
import java.util.Date;

import com.joinway.bean.domain.DomainEntity;
import com.joinway.bean.domain.annotation.DomainField;
import com.joinway.bean.domain.converter.TinyintConverter;

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
	
	@DomainField(converter=TinyintConverter.class)
	protected boolean sex = true;
	
	protected Date birthday;
	
	protected BigDecimal userMoney;
	
	protected BigDecimal frozenMoney;
	
	protected long payPoints;
	
	protected long rankPoints;
	
	protected int addressId;
	
	protected long regTime;
	
	protected long lastLogin;
	
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
	
	protected BigDecimal creditLine;
	
	protected String passwdQuestion;
	
	protected String passwdAnswer;
	
	protected String imId;
	
	protected String cellPhoneType;
	
	@Override
	public String getIdColumnName() {
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
	
	public boolean getSex(){
		return sex;
	}
	
	public void setSex(boolean sex){
		this.sex = sex;
	}
	
	public Date getBirthday(){
		return birthday;
	}
	
	public void setBirthday(Date birthday){
		this.birthday = birthday;
	}
	
	public long getPayPoints(){
		return payPoints;
	}
	
	public void setPayPoints(long payPoints){
		this.payPoints = payPoints;
	}
	
	public long getRankPoints(){
		return rankPoints;
	}
	
	public void setRankPoints(long rankPoints){
		this.rankPoints = rankPoints;
	}
	
	public int getAddressId(){
		return addressId;
	}
	
	public void setAddressId(int addressId){
		this.addressId = addressId;
	}
	
	public long getRegTime(){
		return regTime;
	}
	
	public void setRegTime(int regTime){
		this.regTime = regTime;
	}
	
	public long getLastLogin(){
		return lastLogin;
	}
	
	public void setLastLogin(long lastLogin){
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

	public BigDecimal getUserMoney() {
		return userMoney;
	}

	public void setUserMoney(BigDecimal userMoney) {
		this.userMoney = userMoney;
	}

	public BigDecimal getFrozenMoney() {
		return frozenMoney;
	}

	public void setFrozenMoney(BigDecimal frozenMoney) {
		this.frozenMoney = frozenMoney;
	}

	public BigDecimal getCreditLine() {
		return creditLine;
	}

	public void setCreditLine(BigDecimal creditLine) {
		this.creditLine = creditLine;
	}
	
}