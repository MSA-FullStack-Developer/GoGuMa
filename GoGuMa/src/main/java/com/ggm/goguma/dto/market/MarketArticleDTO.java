package com.ggm.goguma.dto.market;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MarketArticleDTO{

	private long articleId;
	
	private MarketDTO market;
	
	private String articleTitle;
	
	private String articleContent;
	
	private Date regDate;
	
	private ArticleImageDTO thumbnail;
	
	private List<ArticleProudctDTO> products;
	
}