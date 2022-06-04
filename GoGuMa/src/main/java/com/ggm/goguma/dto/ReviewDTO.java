package com.ggm.goguma.dto;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ReviewDTO {
	private long reviewID;
	private String name; // 회원 이름
	private Date createDate;
	private long productPID;
	private long productID;
	private long parentID;
	private String productName;
	private String content;
	private long memberID;
	
	private String prodimgurl;
	private String thumbnailUrl;
	private Date updateDate;

	private List<ImageAttachDTO> attachList;
}