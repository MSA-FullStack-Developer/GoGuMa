package com.ggm.goguma.dto;

import lombok.Data;

@Data
public class FileDTO {

	private byte[] stream;
	
	private String contentType;
}
