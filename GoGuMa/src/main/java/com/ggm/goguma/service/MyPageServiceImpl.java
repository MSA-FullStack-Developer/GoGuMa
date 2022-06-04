package com.ggm.goguma.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ggm.goguma.dto.DeliveryAddressDTO;
import com.ggm.goguma.dto.OrderDTO;
import com.ggm.goguma.dto.PointDTO;
import com.ggm.goguma.dto.ReceiptDTO;
import com.ggm.goguma.mapper.MyPageMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MyPageServiceImpl implements MyPageService {
	@Autowired
	private MyPageMapper mapper;

	@Override
	@Transactional
	public List<ReceiptDTO> getReceiptHistory(long memberId) throws Exception {
		List<ReceiptDTO> receiptList = getReceiptList(memberId);
		for(ReceiptDTO receipt : receiptList) {
			try {
				List<OrderDTO> orderList = getOrderList(receipt.getReceiptId());
				receipt.setOrderList(orderList);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return receiptList;
	}
	
	@Override
	public List<ReceiptDTO> getReceiptList(long memberId) throws Exception {
		return mapper.getReceiptList(memberId);
	}

	@Override
	public List<OrderDTO> getOrderList(long receiptId) throws Exception {
		return mapper.getOrderList(receiptId);
	}

	@Override
	public int getEarnablePoint(long receiptId) throws Exception {
		List<Integer> list = mapper.getPointValue(receiptId);
		int sum = 0;
		for(int item : list)
			sum += item;
		return sum;
	}

	@Override
	public List<PointDTO> getPointHistory(long memberId, String type) throws Exception {
		if(type.equals("all")) return mapper.getPointHistory(memberId);
		return mapper.getSpecificPointHistory(memberId, type);
	}
	
	@Override
	@Transactional
	public ReceiptDTO getReceiptDetail(long receiptId) throws Exception {
		ReceiptDTO dto = mapper.getReceiptDetail(receiptId);
		dto.setOrderList(mapper.getOrderList(receiptId));
		return dto;
	}

	@Override
	@Transactional
	public void updateOrderStatus(long orderId, String status) throws Exception {
		mapper.updateOrderStatus(orderId, status);
		if(status.equals("F")) mapper.makeInquirable(orderId);
	}
	
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
	@Transactional
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