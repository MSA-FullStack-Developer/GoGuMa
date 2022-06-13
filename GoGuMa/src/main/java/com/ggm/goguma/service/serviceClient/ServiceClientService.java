package com.ggm.goguma.service.serviceClient;

import java.util.List;

import com.ggm.goguma.dto.ServiceClientDTO;
import com.ggm.goguma.dto.serviceClient.ServiceCategoryDTO;

public interface ServiceClientService {

	List<ServiceCategoryDTO> getSCategory() throws Exception;

	/* *
	 * 작성자 : 경민영
	 * 작성일 : 2022.06.12
	 * */
	// 내 상담내역 조회
	List<ServiceClientDTO> getQnaList(long pg, long memberID) throws Exception;

	// 내 상담내역 개수
	long getQnaCount(long id) throws Exception;

	void insertQna(ServiceClientDTO serviceClientDTO) throws Exception;

}