package com.ggm.goguma.dto;

import java.util.Date;

import lombok.Data;

@Data
public class ServiceClientDTO {
	long qnaID;
	long memberID;
	long categoryID;
	String categoryName;
	String qnaTitle;
	String qnaContent;
	Date createdAt;
	long answerStatus;
	long receiptID;
	String phone;
	String email;
}