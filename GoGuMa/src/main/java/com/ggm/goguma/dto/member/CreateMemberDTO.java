package com.ggm.goguma.dto.member;

import java.util.List;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;

import lombok.Data;

@Data
public class CreateMemberDTO {
	
	@Email(message = "이메일 형식(example@example.com)이 필요합니다.")
	@NotEmpty(message = "이메일은 필수 입니다.")
	private String email;
	
	@NotEmpty(message = "이름은 필수 입니다.")
	private String name;
	
	@NotEmpty(message = "비밀번호는 필수 입니다.")
	private String password;
	
	@NotEmpty(message = "전화번호는 필수 입니다.")
	private String phone;
	
	private int age;
	
	private int[] agreements;
}
