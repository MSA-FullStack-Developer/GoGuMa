package com.ggm.goguma.dto.market;

import lombok.Data;

@Data
public class ArticleImageDTO {

	private long imageId;
	
	private long articleId;
	
	private String imageName;
	
	private String imagePath;
	
	private boolean isThumbnail;
}
