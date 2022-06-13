package com.ggm.goguma.dto;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ReviewDTO {
	private long reviewID;
	private String name;
	private String nickName;
	private Date createDate;
	private long productPID;
	private long productID;
	private long parentID;
	private String productName;
	private String content;
	private long memberID;
	private String prodThumbNail;

	// 상품평 후기 이미지
	private List<ImageAttachDTO> attachList;
	
	// 마이페이지 상품평
	private long categoryID;
	private String optionName;
}