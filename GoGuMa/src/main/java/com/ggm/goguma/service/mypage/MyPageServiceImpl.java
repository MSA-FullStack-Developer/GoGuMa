package com.ggm.goguma.service.mypage;

import java.util.List;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ggm.goguma.amazons3.AmazonS3Utils;
import com.ggm.goguma.dto.CouponDTO;
import com.ggm.goguma.dto.DeliveryAddressDTO;
import com.ggm.goguma.dto.OrderDTO;
import com.ggm.goguma.dto.PointDTO;
import com.ggm.goguma.dto.ReceiptDTO;
import com.ggm.goguma.dto.UpdateMemberDTO;
import com.ggm.goguma.dto.member.MemberDTO;
import com.ggm.goguma.mapper.MyPageMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MyPageServiceImpl implements MyPageService {
//	@Value("${contentPerPage}")
	private int contentPerPage = 10;
	
//	@Value("${receiptPerPage}")
	private int receiptPerPage = 5;
	
	private final MyPageMapper mapper;
	
	private final AmazonS3Utils amazonService;
	
	private final BCryptPasswordEncoder passwordEncoder;

	@Override
	@Transactional
	public List<ReceiptDTO> getReceiptHistory(long memberId, long page) throws Exception {
		long startNum = (page-1) * receiptPerPage + 1;
		long endNum = page * receiptPerPage;
		List<ReceiptDTO> receiptList = getReceiptList(memberId, startNum, endNum);
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
	public List<ReceiptDTO> getReceiptList(long memberId, long startNum, long endNum) throws Exception {
		return mapper.getReceiptList(memberId, startNum, endNum);
	}

	@Override
	public List<OrderDTO> getOrderList(long receiptId) throws Exception {
		return mapper.getOrderList(receiptId);
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
	public int getMemberPoint(long memberId) throws Exception {
		return mapper.getMemberPoint(memberId);
	}
	
	@Override
	public int getEstimatedPoint(long receiptId) throws Exception {
		return mapper.getEstimatedPoint(receiptId);
	}
	
	@Override
	public long getReceiptCount(long membeId) throws Exception {
		return mapper.getReceiptCount(membeId);
	}
	
	@Override
	public long getCouponCount(long memberId, String type) throws Exception {
		if(type.equals("available")) return mapper.getAvailableCouponCount(memberId);
		return mapper.getUnavailableCouponCount(memberId);
	}

	@Override
	public long getPointHistoryCount(long memberId, String type, String startDate, String endDate) throws Exception {
		if(startDate==null || endDate==null) {
			if(type.equals("all")) return mapper.getPointHistoryCount(memberId);
			return mapper.getSpecificPointHistoryCount(memberId, type);
		}
		else {
			if(type.equals("all")) return mapper.getPointHistoryCountByPeriod(memberId, startDate, endDate);
			return mapper.getSpecificPointHistoryCountByPeriod(memberId, type, startDate, endDate);
		}
	}
	
	@Override
	public List<PointDTO> getPointHistory(long memberId, String type, long page, String startDate, String endDate) throws Exception {
		long startNum = (page-1) * contentPerPage + 1;
		long endNum = page * contentPerPage;
		if(startDate==null || endDate==null) {
			if(type.equals("all")) return mapper.getPointHistory(memberId, startNum, endNum);
			return mapper.getSpecificPointHistory(memberId, type, startNum, endNum);
		}
		else {
			if(type.equals("all")) return mapper.getPointHistoryByPeriod(memberId, startDate, endDate, startNum, endNum);
			return mapper.getSpecificPointHistoryByPeriod(memberId, type, startDate, endDate, startNum, endNum);
		}
	}

	@Override
	public List<CouponDTO> getCouponHistory(long memberId, String type, long page) throws Exception {
		long startNum = (page-1) * contentPerPage + 1;
		long endNum = page * contentPerPage;
		if(type.equals("available")) return mapper.getAvailableCoupon(memberId, startNum, endNum);
		return mapper.getUnavailableCoupon(memberId, startNum, endNum);
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
	@Transactional
	public void addAddress(DeliveryAddressDTO dto) throws Exception {
		if(dto.getIsDefault()==1) mapper.cancelDefault(dto.getMemberId()); // 기본 배송지가 설정돼있으면 제거
		mapper.addAddress(dto);
	}

	@Override
	@Transactional
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
	public boolean confirmPassword(String userPassword, String comparePassword) throws Exception {
		return passwordEncoder.matches(userPassword, comparePassword);
	}

	@Override
	public boolean changePassword(String curPassword, String newPassword, MemberDTO dto) throws Exception {
		if(!confirmPassword(curPassword, dto.getPassword())) return false;
		mapper.changePassword(dto.getId(), passwordEncoder.encode(newPassword));
		return true;
	}

	@Override
	public boolean changeInfo(UpdateMemberDTO updateDTO, MemberDTO memberDTO) throws Exception {
		if(!confirmPassword(updateDTO.getUserPassword(), memberDTO.getPassword())) return false;
		// 프로필 사진을 변경하지 않은 경우(null인 경우)
		if(updateDTO.getProfileImage()==null) {
			mapper.changeInfo(memberDTO.getId(), memberDTO.getProfileImage(), updateDTO.getNickName(), updateDTO.getBirthDate(), updateDTO.getGender());
		} else {
			String[] result = this.amazonService.uploadFile("profile", updateDTO.getProfileImage());
			mapper.changeInfo(memberDTO.getId(), result[1], updateDTO.getNickName(), updateDTO.getBirthDate(), updateDTO.getGender());
		}
		return true;
	}

	@Override
	@Transactional
	public boolean resignMember(String resignDetail, String userPassword, MemberDTO dto) throws Exception {
		if(!confirmPassword(userPassword, dto.getPassword())) return false;
		mapper.insertResignMember(dto, resignDetail);
		mapper.disableMember(dto.getId());
		return true;
	}

	//고객 센터에서 불러올 주문내역
	@Override
	public List<ReceiptDTO> getReceiptHistoryPages(long memberId, int pages) throws Exception {
		int startPages = 0;
		if(pages == 1) {
			startPages = 0;
		}else {
			startPages = ((pages-1) * 10) + 1;
		}
		
		List<ReceiptDTO> receiptList = mapper.getReceiptHistoryPages(memberId, startPages);
		
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
	@Transactional
	public void updateAllOrderStatus(long receiptId, String status) throws Exception {
		mapper.updateAllOrderStatus(receiptId, status);
		if(status.equals("F")) mapper.makeAllInquirable(receiptId);
		//구매 취소한경우 사용 포인트 돌력주기
		if(status.equals("C")) mapper.refundAllPoint(receiptId);
	}
}