package com.ggm.goguma.dto;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ReceiptDTO {
	private long receiptId;
	private String recipient;
	private String rcptContact;
	private String rcptAddress;
	private String rcptNickname;
	private String requirement;
	private long originalPrice;
	private long membershipDiscount;
	private long couponDiscount;
	private long usagePoint;
	private long totalPrice;
	private Date orderDate;
	private String impUid;
	private long memberId;
	List<OrderDTO> orderList;
}