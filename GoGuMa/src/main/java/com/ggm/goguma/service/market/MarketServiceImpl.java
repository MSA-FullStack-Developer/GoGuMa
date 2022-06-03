package com.ggm.goguma.service.market;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ggm.goguma.dto.CategoryDTO;
import com.ggm.goguma.dto.market.CreateMarketDTO;
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

	
	
}
