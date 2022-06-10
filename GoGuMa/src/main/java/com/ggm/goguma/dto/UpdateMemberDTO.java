package com.ggm.goguma.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class UpdateMemberDTO {
	private long memberId;
	private MultipartFile profileImage;
	private String nickName;
	private String gender;
	private String birthDate;
	private String userPassword;
}