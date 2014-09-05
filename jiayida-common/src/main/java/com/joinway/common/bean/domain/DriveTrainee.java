package com.joinway.common.bean.domain;

import java.util.Date;

import com.joinway.bean.domain.DomainEntity;
import com.joinway.bean.domain.annotation.DomainField;
import com.joinway.bean.domain.type.CaseFormat;

public class DriveTrainee extends DomainEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1622195219006896158L;

	/**
	 * 姓名
	 */
	String name;
	
	/**
	 * 性别
	 */
	@DomainField(CaseFormat.Upper)
	String gender;
	
	Date birthday;
	
	String nationality;

	/**
	 * 固话
	 */
	String phone;
	
	String cellPhone;

	String idCardType;
	
	String idCard;
	
	String idCardAddress;
	
	String company;
	
	/**
	 * 邮寄地址
	 */
	String postAddress;
	
	/**
	 * 联系地址
	 */
	String address;
	
	/**
	 * 暂住证明
	 */
	String tempCardId;
	
	/**
	 * 邮政编码
	 */
	String postCode;
	
//	int age;
	
	/**
	 * 指定教练
	 */
	String coach;
	
	/**
	 * 推荐人
	 */
	String introducer;
	
	/**
	 * 学习类型
	 */
	@DomainField(CaseFormat.Upper)
	String trainType;
	
	/**
	 * 班级信息
	 */
	String trainClass;
	
	/**
	 * 学员来源
	 */
	String source;
	
	/**
	 * 原有车型
	 */
	String origCarType;
	
	String comment;

	/**
	 * 车辆类型
	 */
	String carType;

	/**
	 * 所属区域
	 */
	String zone;
	
	/**
	 * 学习车型
	 */
	String testCarType;
	
	Date registerDate;
	/**
	 * 处理状态
	 */
	int dealStatus;
	/**
	 * 考试状态
	 */
	int examStatus;
	
	public String getCellPhone() {
		return cellPhone;
	}

	public void setCellPhone(String cellPhone) {
		this.cellPhone = cellPhone;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getZone() {
		return zone;
	}

	public void setZone(String zone) {
		this.zone = zone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	public String getCoach() {
		return coach;
	}

	public void setCoach(String teacher) {
		this.coach = teacher;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getNationality() {
		return nationality;
	}

	public void setNationality(String nationality) {
		this.nationality = nationality;
	}

	public String getIdCardType() {
		return idCardType;
	}

	public void setIdCardType(String idCardType) {
		this.idCardType = idCardType;
	}

	public String getIdCardAddress() {
		return idCardAddress;
	}

	public void setIdCardAddress(String idCardAddress) {
		this.idCardAddress = idCardAddress;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getPostAddress() {
		return postAddress;
	}

	public void setPostAddress(String postAddress) {
		this.postAddress = postAddress;
	}

	public String getIntroducer() {
		return introducer;
	}

	public void setIntroducer(String introducer) {
		this.introducer = introducer;
	}

	public String getTrainType() {
		return trainType;
	}

	public void setTrainType(String trainType) {
		this.trainType = trainType;
	}

	public String getTrainClass() {
		return trainClass;
	}

	public void setTrainClass(String trainClass) {
		this.trainClass = trainClass;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}


	public String getPostCode() {
		return postCode;
	}

	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	public String getOrigCarType() {
		return origCarType;
	}

	public void setOrigCarType(String origCarType) {
		this.origCarType = origCarType;
	}

	public String getCarType() {
		return carType;
	}

	public void setCarType(String carType) {
		this.carType = carType;
	}

	public String getTestCarType() {
		return testCarType;
	}

	public void setTestCarType(String testCarType) {
		this.testCarType = testCarType;
	}

	public Date getRegisterDate() {
		return registerDate;
	}

	public void setRegisterDate(Date registerDate) {
		this.registerDate = registerDate;
	}

	public String getTempCardId() {
		return tempCardId;
	}

	public void setTempCardId(String tempCardId) {
		this.tempCardId = tempCardId;
	}

	public int getDealStatus() {
		return dealStatus;
	}

	public void setDealStatus(int dealStatus) {
		this.dealStatus = dealStatus;
	}

	public int getExamStatus() {
		return examStatus;
	}

	public void setExamStatus(int examStatus) {
		this.examStatus = examStatus;
	}
}
