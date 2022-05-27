package com.ggm.goguma.service.product;

import java.util.List;

import com.ggm.goguma.dto.ReviewDTO;

public interface ReviewService {
	// 상품평 목록
	List<ReviewDTO> getReviewList(long productID) throws Exception;
}
