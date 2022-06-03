package com.ggm.goguma.dto.market;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class MarketDTO {
	
	private long marketId;
	
	private long memberId;
	
	private long categoryId;
	
	private String marketName;
	
	private String marketDetail;
	
	private String marketThumbnail;
	
	private String marketBanner;

}
