package com.ggm.goguma.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ggm.goguma.dto.member.ContractDTO;

public interface ContractMapper {
	
	List<ContractDTO> findAll();
	
	void createContractHistory(@Param("memberId") int memberId, @Param("contractId") int contractId);
}
