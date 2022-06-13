package com.ggm.goguma.dto.market;

import com.ggm.goguma.dto.CategoryDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MarketDTO {
	
	private long marketId;
	
	private long memberId;
		
	private CategoryDTO category;
	
	private String marketName;
	
	private String marketDetail;
	
	private String marketThumbnail;
	
	private String marketBanner;

}