package com.ggm.goguma.service.product;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ggm.goguma.dto.ReviewDTO;
import com.ggm.goguma.mapper.ReviewMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ReviewServiceImpl implements ReviewService {
	
	@Autowired
	private ReviewMapper reviewMapper;
	
	@Override
	public List<ReviewDTO> getReviewList(long productID) throws Exception {
		return reviewMapper.getReviewList(productID);
	}
	
	@Override
	public long isExistReview(long productID, long memberID) throws Exception {
		return reviewMapper.isExistReview(productID, memberID);
	}

	@Override
	public void insertReview(long productID, long memberID, String content) throws Exception {
		reviewMapper.insertReview(productID, memberID, content);
	}

	@Override
	public Integer isFinishRcpt(long productID, long memberID) throws Exception {
		return reviewMapper.isFinishRcpt(productID, memberID);
	}

	@Override
	public void deleteReview(long reviewID) throws Exception {
		reviewMapper.deleteReview(reviewID);
	}

}