package com.ggm.goguma.dto;

import lombok.Data;

@Data
public class OrderDTO {
	private long orderId;
	private String name;
	private long price;
	private String image;
	private long count;
	private String status;
	private long receiptId;
}