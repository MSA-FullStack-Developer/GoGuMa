package com.ggm.goguma.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ggm.goguma.dto.ServiceClientDTO;
import com.ggm.goguma.dto.serviceClient.ServiceCategoryDTO;

public interface ServiceClientMapper {

	List<ServiceCategoryDTO> getSCategory() throws Exception;

	/* *
	 * 작성자 : 경민영
	 * 작성일 : 2022.06.12
	 * */
	// 내 상담내역 조회
	List<ServiceClientDTO> getQnaList(@Param("startNum") long startNum, @Param("endNum") long endNum, @Param("memberID") long memberID) throws Exception;

	// 내 상담내역 개수
	long getQnaCount(long memberID) throws Exception;
}