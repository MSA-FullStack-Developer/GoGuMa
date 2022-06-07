package com.ggm.goguma.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class DefaultResponseDTO {

	private int status;
	
	private String message;
}
