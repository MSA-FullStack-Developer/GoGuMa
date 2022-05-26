package com.ggm.goguma.dto;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ProductDTO {
	private long productID;
	private long parentPID;
	private long categoryID;
	private String productName;
	private long productPrice;
	private String productDetail;
	private String company;
	private long stock;
	private Date productRegDate;
	
	private String prodimgurl;
	private List<ProductDTO> option;
	
	private String keyword; // 상품 검색 키워드
}