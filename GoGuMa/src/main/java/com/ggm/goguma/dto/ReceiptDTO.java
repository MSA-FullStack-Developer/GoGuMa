package com.ggm.goguma.dto;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ReceiptDTO {
	private long receiptId;
	private Date orderDate;
	private long memberId;
	List<OrderDTO> orderList;
}