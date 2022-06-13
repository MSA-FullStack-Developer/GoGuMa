package com.ggm.goguma.dto.member;

import java.util.Date;

import com.ggm.goguma.constant.Role;

import lombok.Data;

@Data
public class ResignMemberDTO {

	private Long id;
	
	private String email;
	
	private String password;
	
	private String name;
	
	private String gender;
	
	private int age;
	
	private String phone;
	
	private MemberGradeDTO grade;
	
	private Role role;

	private Date joinDate;
	
	private Date resignDate;
}
