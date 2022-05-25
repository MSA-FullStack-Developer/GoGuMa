package com.ggm.goguma.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ggm.goguma.dto.DeliveryAddressDTO;
import com.ggm.goguma.mapper.MyPageMapper;

@Service
public class MyPageServiceImpl implements MyPageService {
	@Autowired
	private MyPageMapper mapper;
	
	@Override
	public List<DeliveryAddressDTO> getAddressList(int memberid) throws Exception {
		return mapper.getAddressList(memberid);
	}

	@Override
	public DeliveryAddressDTO getDefaultAddress(int memberid) throws Exception {
		return mapper.getDefaultAddress(memberid);
	}
	
	@Override
	public void setDefault(int memberId, int addressId) throws Exception {
		mapper.cancelDefault(memberId);
		mapper.setDefault(memberId, addressId);
	}

	@Override
	public void cancelDefault(int memberId) throws Exception {
		mapper.cancelDefault(memberId);
	}
	
	@Override
	public void deleteAddress(int memberId, int addressId) throws Exception {
		mapper.deleteAddress(memberId, addressId);
	}
}
