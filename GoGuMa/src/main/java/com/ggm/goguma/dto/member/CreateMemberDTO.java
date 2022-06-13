package com.ggm.goguma.dto.member;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;

import org.springframework.web.multipart.MultipartFile;

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
	
	private MultipartFile profile;
	
	private String gender;
	
	private String birthDate;
	
	private String nickName;
	
	private int[] agreements;
}
