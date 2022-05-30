package com.ggm.goguma.service.memberCoupon;

import com.ggm.goguma.dto.coupon.MemberCouponDTO;
import com.ggm.goguma.exception.CouponCreateException;

public interface MemberCouponService {

	void createMemberCoupon(MemberCouponDTO data) throws CouponCreateException, Exception;
}
