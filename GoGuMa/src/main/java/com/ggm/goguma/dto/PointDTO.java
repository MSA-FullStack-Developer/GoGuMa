package com.ggm.goguma.dto;

import java.util.Date;

import lombok.Data;

@Data
public class PointDTO {
	private long pointEventId;
	private String pointType;
	private long pointValue;
	private long inquirable;
	private Date pointCreatedDate;
	private long receiptId;
	private long orderId;
}