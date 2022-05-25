package com.ggm.goguma.service;

import java.util.List;

import com.ggm.goguma.dto.DeliveryAddressDTO;

public interface MyPageService {
	List<DeliveryAddressDTO> getAddressList(int memberid) throws Exception;

	DeliveryAddressDTO getDefaultAddress(int memberid) throws Exception;

	void deleteAddress(int memberId, int addressId) throws Exception;
	
	void setDefault(int memberId, int addressId) throws Exception;

	void cancelDefault(int memberId) throws Exception;
}
