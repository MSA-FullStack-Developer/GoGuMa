package com.ggm.goguma.dto;

import java.util.Date;

import lombok.Data;

@Data
public class ProductDTO {
	private int productID;
	private int parentPID; // null 대신 0
	private int categoryID;
	private String productName;
	private long price;
	private String productDetail;
	private String company;
	private long stock;
	private Date productRegDate;
	
	private String prodimgurl;
}