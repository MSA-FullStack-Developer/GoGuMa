package com.ggm.goguma.service.market;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ggm.goguma.dto.CategoryDTO;
import com.ggm.goguma.dto.market.CreateMarketDTO;
import com.ggm.goguma.dto.market.FollowMarketDTO;
import com.ggm.goguma.dto.market.MarketDTO;
import com.ggm.goguma.exception.NotFoundMarketException;
import com.ggm.goguma.exception.UploadFileFailException;
import com.ggm.goguma.mapper.MarketMapper;
import com.ggm.goguma.service.FileService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MarketServiceImpl implements MarketService{
	
	private final MarketMapper marketMapper;
	
	@Autowired
	@Qualifier("DefaultFileSerivce")
	private FileService FileService;

	
	@Override
	public MarketDTO createMarket(CreateMarketDTO data) throws UploadFileFailException, Exception {
		
		MultipartFile[] multipartFiles = {data.getThumbnail(), data.getBanner()};
		
		List<String> savedFiles = this.FileService.uploadFile(multipartFiles);
		
		CategoryDTO category = new CategoryDTO();
		category.setCategoryID(data.getCategoryId());
		MarketDTO market = MarketDTO.builder()
				.memberId(data.getMemberId())
				.category(category)
				.marketName(data.getMarketName())
				.marketDetail(data.getMarketDetail())
				.marketThumbnail(savedFiles.get(0))
				.marketBanner(savedFiles.get(1))
				.build();
		
		this.marketMapper.insertMarket(market);
		
	
		return market;
	}


	@Override
	public MarketDTO getMarket(long marketId) throws Exception {
		
		return this.marketMapper.findMarketById(marketId).orElseThrow(NotFoundMarketException::new);
	
	}


	@Override
	public boolean isAlreadyFollowMarket(FollowMarketDTO followMarket) {
		int count = this.marketMapper.findFollwMarketCountByMarketIdAndMemberId(followMarket);
		
		return count > 0 ? true : false;
	}

	@Override
	public boolean createOrDeleteFollowMarket(FollowMarketDTO followMarket) {
		
		boolean isCreated = true;
		
		if(!isAlreadyFollowMarket(followMarket)) {
			this.marketMapper.insertFollowMarket(followMarket);
		} else {
			isCreated = false;
			this.marketMapper.deleteFollowMarket(followMarket);
		}
		return isCreated;
	}

	
	
	
}
