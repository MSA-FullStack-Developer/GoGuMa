package com.ggm.goguma.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ggm.goguma.dto.ReviewDTO;

public interface ReviewMapper {
	// 상품평 목록
	List<ReviewDTO> getReviewList(@Param("productID") long productID) throws Exception;

	// 상품평 작성 여부 확인
	long isExistReview(@Param("productID") long productID, @Param("memberID") long memberID) throws Exception;

	// 상품평 등록
	void insertReview(ReviewDTO reviewDTO);
	
	// 상품평 등록 자격 확인
	Integer isFinishRcpt(@Param("productID") long productID, @Param("memberID") long memberID) throws Exception;
	
	// 상품평 삭제
	int deleteReview(long reviewID) throws Exception;
}