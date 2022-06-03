package com.ggm.goguma.mapper;

import org.apache.ibatis.annotations.Param;

import com.ggm.goguma.dto.market.MarketDTO;

public interface MarketMapper {
	
	void insertMarket(MarketDTO market) throws Exception;

	void findMarketById(@Param("marketId") long marketId) throws Exception;
}
