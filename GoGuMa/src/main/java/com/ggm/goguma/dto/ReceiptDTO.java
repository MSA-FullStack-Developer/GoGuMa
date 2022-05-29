package com.ggm.goguma.dto;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ReceiptDTO {
	private long receiptId;
	private Date orderDate;
	private long memberId;
	private long addressId;
	private String requirement;
	List<OrderDTO> orderList;
}