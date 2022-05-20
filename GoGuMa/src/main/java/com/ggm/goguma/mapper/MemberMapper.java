package com.ggm.goguma.mapper;

import java.util.Optional;

import org.apache.ibatis.annotations.Param;

import com.ggm.goguma.dto.member.MemberDTO;

public interface MemberMapper {

	public Optional<MemberDTO> findMemberByNameAndPhone(@Param("name") String name, @Param("phone") String phone);
	
	public Optional<MemberDTO> findMemberByEmail(@Param("email") String email);
	
	public Optional<MemberDTO> findMemberByEmailAndPwd(@Param("email") String email, @Param("password") String password);
	
	public void createMember(MemberDTO member);
}
