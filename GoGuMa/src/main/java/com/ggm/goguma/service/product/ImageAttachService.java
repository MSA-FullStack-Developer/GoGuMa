package com.ggm.goguma.service.product;

import java.util.List;

import com.ggm.goguma.dto.ImageAttachDTO;

public interface ImageAttachService {
	public void attachInsert(ImageAttachDTO attachDTO) throws Exception;
	
	public void attachDelete(long reviewID) throws Exception;

	public List<ImageAttachDTO> attachListByReviewID(long reviewID) throws Exception;
}