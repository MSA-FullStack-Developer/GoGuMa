package com.ggm.goguma.dto.market;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class CreateMarketDTO {


	private long memberId;

	private long categoryId;

	private String marketName;

	private String marketDetail;

	private MultipartFile thumbnail;

	private MultipartFile banner;
}
