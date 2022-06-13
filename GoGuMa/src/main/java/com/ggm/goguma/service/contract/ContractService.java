package com.ggm.goguma.service.contract;

import java.util.List;

import com.ggm.goguma.dto.member.ContractDTO;

public interface ContractService {

	List<ContractDTO> getAllContracts();
	
	void createContractHistory(long memberId, long contractId);
}
