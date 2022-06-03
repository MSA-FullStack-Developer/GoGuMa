package com.ggm.goguma.dto;

import java.util.Date;

import lombok.Data;

@Data
public class PointDTO {
	private long pointEventId;
	private long memberId;
    private long receiptId;
    private long orderId;
    private String pointType;
    private long pointValue;
    private Date pointCreatedDate;
    private long inquirable;
}