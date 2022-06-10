package com.ggm.goguma.dto.member;

import java.util.Date;

import com.ggm.goguma.constant.Role;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MemberDTO {
	private long id;
	private String email;
	private String password;
	private String profileImage;
	private String nickName;
	private String name;
	private String gender;
	private int age;
	private String birthDate;
	private String phone;
	private MemberGradeDTO grade;
	private Date joinDate;
	private Role role;
	private boolean disabled;
}