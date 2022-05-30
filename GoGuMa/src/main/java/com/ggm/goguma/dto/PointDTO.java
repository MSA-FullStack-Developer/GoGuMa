package com.ggm.goguma.dto;

import lombok.Data;

@Data
public class PointDTO {
	private long pointEventId;
	private String pointType;
	private long pointValue;
	private long receiptId;
}