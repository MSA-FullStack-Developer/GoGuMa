package com.ggm.goguma.service.memberCoupon;

import java.sql.SQLException;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.UncategorizedSQLException;
import org.springframework.stereotype.Service;

import com.ggm.goguma.constant.OracleError;
import com.ggm.goguma.dto.coupon.MemberCouponDTO;
import com.ggm.goguma.exception.CouponCreateException;
import com.ggm.goguma.mapper.MemberCouponMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;
import oracle.jdbc.OracleDatabaseException;

@Service
@RequiredArgsConstructor
@Log4j
public class MemberCouponServiceImpl implements MemberCouponService{
	
	private final MemberCouponMapper memberCouponMapper;
	
	@Override
	public void createMemberCoupon(MemberCouponDTO data) throws CouponCreateException, Exception {
		
		try {
			this.memberCouponMapper.createMemberCoupon(data);
		}catch(Exception e) {
		
			int errorCode;
			if(e instanceof UncategorizedSQLException) {
				
				errorCode = ((UncategorizedSQLException) e).getSQLException().getErrorCode();
				
				log.debug("[createMemberCoupon] UncategorizedSQLException code : "+ errorCode);
				
				if(errorCode == OracleError.MEMBER_ALREADY_GET_COUPON.getCode()) {
					throw new CouponCreateException(OracleError.MEMBER_ALREADY_GET_COUPON);
				} else if(errorCode == OracleError.COUPON_ALREADY_EXPIRE.getCode()) {
					throw new CouponCreateException(OracleError.COUPON_ALREADY_EXPIRE);
				} else {
					throw new Exception(e.getMessage());
				}
			} else if(e instanceof DataAccessException){
				
				errorCode = ((OracleDatabaseException)((DataAccessException) e).getRootCause()).getOracleErrorNumber();
				
				log.debug("[createMemberCoupon] SQLException code : "+ errorCode);
				
				if(errorCode == OracleError.NOT_FOUND_DATA.getCode()) {
					throw new CouponCreateException(OracleError.NOT_FOUND_DATA);
				} else {
					throw new Exception(e.getMessage());
				}
			} else {
				log.debug("[createMemberCoupon] Exception!");
				throw new Exception(e.getMessage());
			}
	
		}
		
	}

	
}
