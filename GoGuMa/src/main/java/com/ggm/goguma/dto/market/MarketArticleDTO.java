package com.ggm.goguma.dto.market;

import java.util.List;

import lombok.Data;

@Data
public class MarketArticleDTO {

	private long articleId;
	
	private long marketId;
	
	private String articleTitle;
	
	private String articleContent;
	
	private ArticleImageDTO thumbnail;
	
	private List<ArticleProudctDTO> products;
}
