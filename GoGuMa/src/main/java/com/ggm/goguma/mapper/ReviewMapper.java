package com.ggm.goguma.mapper;

import java.util.List;

import com.ggm.goguma.dto.ReviewDTO;

public interface ReviewMapper {
	// 상품평 목록
	List<ReviewDTO> getReviewList(long productID) throws Exception;
}
