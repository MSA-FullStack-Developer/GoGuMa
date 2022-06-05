package com.ggm.goguma.dto.market;

import lombok.Data;

@Data
public class ArticleProudctDTO {

	private long productId; //현재 상품 아이디
	
	private long parentId;  //부모 상품 아이디
	
	private String productName;  //부모 상품 이름
	 
	private String optionName; //현재 상품 이름
	
	private int productPrice;
	
	private String prodImgUrl;
}
