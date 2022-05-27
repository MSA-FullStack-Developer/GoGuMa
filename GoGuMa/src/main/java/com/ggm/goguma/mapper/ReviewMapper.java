package com.ggm.goguma.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ggm.goguma.dto.ReviewDTO;

public interface ReviewMapper {
	// 상품평 목록
	List<ReviewDTO> getReviewList(long productID) throws Exception;

	long isExistReview(long memberID, long productID) throws Exception;

	void insertReview(@Param("productID") long productID, @Param("memberID") long memberID, @Param("content") String content);
}
