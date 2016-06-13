package com.neowave.screening.model;

import java.beans.Transient;
import java.util.Date;

public class Drug {
	private Integer id;
	private String name;  // 药品名称
	private String code;  // 批准文号
	private String form;  // 剂型
	private String spec;  // 规格
	private String manufacturer; // 药厂
	private String category; // 药品类别
	private Date approved; // 批准日期
	private String otc ;// OTC,RX标识
	private String usage ; // 用法用量
	
	private String dosage; // 剂量单位	
	private String icon; // 剂型图标
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getForm() {
		return form;
	}
	public void setForm(String form) {
		this.form = form;
	}
	public String getSpec() {
		return spec;
	}
	public void setSpec(String spec) {
		this.spec = spec;
	}
	public String getManufacturer() {
		return manufacturer;
	}
	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public Date getApproved() {
		return approved;
	}
	public void setApproved(Date approved) {
		this.approved = approved;
	}
	public String getOtc() {
		return otc;
	}
	public void setOtc(String otc) {
		this.otc = otc;
	}
	public String getUsage() {
		return usage;
	}
	public void setUsage(String usage) {
		this.usage = usage;
	}
	public String getDosage() {
		return dosage;
	}
	public void setDosage(String dosage) {
		this.dosage = dosage;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
}
