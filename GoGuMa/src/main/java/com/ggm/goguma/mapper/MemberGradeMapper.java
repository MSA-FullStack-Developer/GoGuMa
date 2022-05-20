package com.ggm.goguma.mapper;

import java.util.Optional;

import org.apache.ibatis.annotations.Param;

import com.ggm.goguma.dto.member.MemberGradeDTO;

public interface MemberGradeMapper {

	public Optional<MemberGradeDTO> findById(@Param("id") int id);
}
