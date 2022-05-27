package com.ggm.goguma.service.product;

import java.util.List;

import com.ggm.goguma.dto.ReviewDTO;

public interface ReviewService {
	// 상품평 목록
	List<ReviewDTO> getReviewList(long productID) throws Exception;

	long isExistReview(long memberID, long productID) throws Exception;

	// 상품평 작성
	void insertReview(long productID, long memberID, String content) throws Exception;
}