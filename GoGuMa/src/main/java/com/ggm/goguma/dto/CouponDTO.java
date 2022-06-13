package com.ggm.goguma.dto;

import java.util.Date;

import lombok.Data;

@Data
public class CouponDTO {
	private long couponId;
	private String couponName;
	private long benefit;
	private long restriction;
	private Date createdDate;
	private Date expirationDate;
	private long used;
}