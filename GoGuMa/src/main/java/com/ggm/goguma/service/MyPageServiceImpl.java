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
	public List<DeliveryAddressDTO> getAddressList(long memberid) throws Exception {
		return mapper.getAddressList(memberid);
	}

	@Override
	public DeliveryAddressDTO getDefaultAddress(long memberid) throws Exception {
		return mapper.getDefaultAddress(memberid);
	}

	@Override
	public void addAddress(DeliveryAddressDTO dto) throws Exception {
		if(dto.getIsDefault()==1) mapper.cancelDefault(dto.getMemberId()); // 기본 배송지가 설정돼있으면 제거
		mapper.addAddress(dto);
	}

	@Override
	public void updateAddress(DeliveryAddressDTO dto) throws Exception {
		if(dto.getIsDefault()==1) mapper.cancelDefault(dto.getMemberId()); // 기본 배송지가 설정돼있으면 제거
		mapper.updateAddress(dto);
	}
	
	@Override
	public void deleteAddress(long memberId, long addressId) throws Exception {
		mapper.deleteAddress(memberId, addressId);
	}
	
	@Override
	public void setDefault(long memberId, long addressId) throws Exception {
		mapper.cancelDefault(memberId);
		mapper.setDefault(memberId, addressId);
	}

	@Override
	public void cancelDefault(long memberId) throws Exception {
		mapper.cancelDefault(memberId);
	}

	@Override
	public int getMemberPoint(long memberId) throws Exception {
		return mapper.getMemberPoint(memberId);
	}
}
