package com.ggm.goguma.service.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ggm.goguma.dto.ImageAttachDTO;
import com.ggm.goguma.mapper.ImageAttachMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ImageAttachServiceImpl implements ImageAttachService {
	
	@Autowired
	ImageAttachMapper attachMapper;
	
	@Override
	public void attachInsert(ImageAttachDTO attachDTO) throws Exception {
		attachMapper.attachInsert(attachDTO);
	}

	@Override
	public void attachDelete(long reviewID) throws Exception {
		attachMapper.attachDelete(reviewID); 
	}

	@Override
	public List<ImageAttachDTO> attachListByReviewID(long reviewID) throws Exception {
		return attachMapper.attachListByReviewID(reviewID);
	}
	
}