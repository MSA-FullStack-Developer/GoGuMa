package com.ggm.goguma.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ggm.goguma.dto.ProductDTO;
import com.ggm.goguma.dto.ReviewDTO;

public interface ReviewMapper {
	// 상품평 목록
	List<ReviewDTO> getReviewList(@Param("productID") long productID) throws Exception;

	// 상품평 등록
	void insertReview(ReviewDTO reviewDTO);
	
	// 상품평 삭제
	int deleteReview(long reviewID) throws Exception;

	// 내가 작성한 상품평 목록
	List<ReviewDTO> getMyReviewList(long memberID) throws Exception;
	
	// 작성 가능한 상품평
	List<ProductDTO> getWriteableReview(long memberID) throws Exception;

	// 상품평 수정
    void updateReview(ReviewDTO reviewDTO) throws Exception;
}