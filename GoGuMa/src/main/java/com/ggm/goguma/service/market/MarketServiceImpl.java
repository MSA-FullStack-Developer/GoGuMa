package com.ggm.goguma.service.market;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ggm.goguma.dto.market.CreateMarketDTO;
import com.ggm.goguma.dto.market.MarketDTO;
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
		
		MarketDTO market = MarketDTO.builder()
				.memberId(data.getMemberId())
				.categoryId(data.getCategoryId())
				.marketName(data.getMarketName())
				.marketDetail(data.getMarketDetail())
				.marketThumbnail(savedFiles.get(0))
				.marketBanner(savedFiles.get(1))
				.build();
		
		this.marketMapper.insertMarket(market);
		
	
		return market;
	}

	
}
