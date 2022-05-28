package com.ggm.goguma.service;

import java.util.List;

import com.ggm.goguma.dto.DeliveryAddressDTO;
import com.ggm.goguma.dto.OrderDTO;
import com.ggm.goguma.dto.ReceiptDTO;

public interface MyPageService {
	List<ReceiptDTO> getReceiptHistory(long memberId) throws Exception;
	
	List<ReceiptDTO> getReceiptList(long memberId) throws Exception;
	
	List<OrderDTO> getOrderList(long receiptId) throws Exception;
	
	void updateOrderStatus(long orderId, String status) throws Exception;

	List<DeliveryAddressDTO> getAddressList(long memberId) throws Exception;

	DeliveryAddressDTO getDefaultAddress(long memberId) throws Exception;

	void addAddress(DeliveryAddressDTO dto) throws Exception;
	
	void updateAddress(DeliveryAddressDTO dto) throws Exception;
	
	void deleteAddress(long memberId, long addressId) throws Exception;
	
	void setDefault(long memberId, long addressId) throws Exception;

	void cancelDefault(long memberId) throws Exception;
}