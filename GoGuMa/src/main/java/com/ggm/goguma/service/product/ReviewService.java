package com.ggm.goguma.service.product;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ggm.goguma.dto.ProductDTO;
import com.ggm.goguma.dto.ReviewDTO;

public interface ReviewService {
	// 상품평 목록
	List<ReviewDTO> getReviewList(long productID) throws Exception;

	// 상품평 작성 여부 확인
	long isExistReview(long memberID, long productID) throws Exception;

	// 상품평 작성
	void insertReview(ReviewDTO reviewDTO) throws Exception;
	
	// 상품평 등록 자격 확인
	Integer isFinishRcpt(long productID, long memberID) throws Exception;
	
	// 상품평 삭제
	void deleteReview(@Param("reviewID") long reviewID) throws Exception;

	// 내가 작성한 상품평 목록
	List<ReviewDTO> getMyReviewList(long memberID) throws Exception;

	// 작성 가능한 상품평
	List<ProductDTO> getWriteableReview(long memberID) throws Exception;
}