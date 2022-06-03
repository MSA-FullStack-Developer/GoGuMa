package com.ggm.goguma.service.market;


import com.ggm.goguma.dto.market.CreateMarketDTO;
import com.ggm.goguma.dto.market.MarketDTO;
import com.ggm.goguma.exception.UploadFileFailException;

public interface MarketService {

	MarketDTO createMarket(CreateMarketDTO data) throws UploadFileFailException, Exception;
	
	
	MarketDTO getMarket(long marketId) throws Exception;
}
