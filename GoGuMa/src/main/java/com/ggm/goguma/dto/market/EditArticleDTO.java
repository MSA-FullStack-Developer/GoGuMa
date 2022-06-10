package com.ggm.goguma.dto.market;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class EditArticleDTO {

	private long marketId;
	
	private long articleId;
	
	private String articleTitle;
	
	private String articleContent;
	
	private MultipartFile thumbnail;
	
	private List<Long> productId;
}
