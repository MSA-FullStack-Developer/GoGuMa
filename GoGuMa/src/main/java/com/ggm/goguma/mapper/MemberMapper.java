package com.ggm.goguma.mapper;

import java.util.Optional;

import org.apache.ibatis.annotations.Param;

import com.ggm.goguma.dto.member.MemberDTO;

public interface MemberMapper {

	Optional<MemberDTO> findMemberByNameAndPhone(@Param("name") String name, @Param("phone") String phone);
	
	Optional<MemberDTO> findMemberByEmail(@Param("email") String email);
	
	Optional<MemberDTO> findMemberByEmailAndPwd(@Param("email") String email, @Param("password") String password);
	
	void createMember(MemberDTO member);
	
	void updateMemberPwd(MemberDTO meber);
	
}
