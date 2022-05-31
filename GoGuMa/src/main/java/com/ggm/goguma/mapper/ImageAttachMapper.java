package com.ggm.goguma.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ggm.goguma.dto.ImageAttachDTO;

public interface ImageAttachMapper {
	public void attachInsert(ImageAttachDTO attachDTO);
	
	public void attachDelete(String imageUUID);

	public List<ImageAttachDTO> attachListByReviewID(@Param("reviewID") long reviewID);
	
	public void deleteAll(long reviewID);
}