package com.ggm.goguma.mapper;

import java.util.Optional;

import org.apache.ibatis.annotations.Param;

import com.ggm.goguma.dto.market.FollowMarketDTO;
import com.ggm.goguma.dto.market.MarketDTO;

public interface MarketMapper {
	
	void insertMarket(MarketDTO market) throws Exception;

	Optional<MarketDTO> findMarketById(@Param("id") long marketId) throws Exception;
	
	
	int findFollwMarketCountByMarketIdAndMemberId(FollowMarketDTO followMarket);
	
	void insertFollowMarket(FollowMarketDTO followMarket);
	
	void deleteFollowMarket(FollowMarketDTO followMarket);
}
