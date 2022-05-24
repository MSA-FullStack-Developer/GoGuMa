package com.ggm.goguma.service.contract;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ggm.goguma.dto.member.ContractDTO;
import com.ggm.goguma.mapper.ContractMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ContractServiceImpl implements ContractService {
	
	private final ContractMapper contractMapper;

	@Override
	public List<ContractDTO> getAllContracts() {
		List<ContractDTO> contractList = this.contractMapper.findAll();
		
		return contractList;
	}

	@Override
	@Transactional
	public void createContractHistory(long memberId, long contractId) {
		this.contractMapper.createContractHistory(memberId, contractId);
	}
	
	
	

}
