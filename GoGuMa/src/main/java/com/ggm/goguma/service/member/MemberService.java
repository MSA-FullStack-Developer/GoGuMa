package com.ggm.goguma.service.member;

import com.ggm.goguma.dto.member.CreateMemberDTO;
import com.ggm.goguma.dto.member.MemberDTO;
import com.ggm.goguma.exception.CreateMemberFailException;
import com.ggm.goguma.exception.NotFoundMemberExcption;

public interface MemberService {
	
	/**
	 * 아임포트 API를 이용하여 유저 정보 가져오는 서비스
	 * */
	MemberDTO getMemberInfoFromIamport(String impUid);
	
	MemberDTO getMember(String name, String phone) throws NotFoundMemberExcption;
	
	MemberDTO getMember(String email) throws NotFoundMemberExcption;
	
	void createMember(CreateMemberDTO member) throws CreateMemberFailException;
	
	void updateMemberPassword(MemberDTO member);
}
