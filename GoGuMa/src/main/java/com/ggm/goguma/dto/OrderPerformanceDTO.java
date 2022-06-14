package com.ggm.goguma.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderPerformanceDTO {
	private long memberId;
	private int orderCount;
	private int orderAmount;
}