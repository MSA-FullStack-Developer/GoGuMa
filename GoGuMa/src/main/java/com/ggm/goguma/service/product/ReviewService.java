package com.ggm.goguma.service.product;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ggm.goguma.dto.ReviewDTO;

public interface ReviewService {
	// 상품평 목록
	List<ReviewDTO> getReviewList(long productID) throws Exception;

	// 상품평 작성 여부 확인
	long isExistReview(long memberID, long productID) throws Exception;

	// 상품평 작성
	void insertReview(long productID, long memberID, String content) throws Exception;
	
	// 상품평 등록 자격 확인
	Integer isFinishRcpt(long productID, long memberID) throws Exception;
	
	// 상품평 삭제
	void deleteReview(@Param("reviewID") long reviewID) throws Exception;
}