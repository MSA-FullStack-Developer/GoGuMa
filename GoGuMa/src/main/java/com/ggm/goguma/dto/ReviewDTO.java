package com.ggm.goguma.dto;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewDTO {
	private String name;
	private Date createDate;
	private long productPID;
	private long productID;
	private long parentID;
	private String productName;
	private String content;
	
	private String prodimgurl;
	private String thumbnailUrl;
	private Date updateDate;
}