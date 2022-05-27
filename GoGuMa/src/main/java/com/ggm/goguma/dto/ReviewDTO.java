package com.ggm.goguma.dto;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewDTO {
	private String userName;
	private Date createDate;
	private long productPID;
	private long productID;
	private String content;
	
	private String prodimgurl;
	private String thumbnailUrl;
	private Date updateDate;
}
