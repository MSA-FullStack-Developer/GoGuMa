package com.ggm.goguma.dto.articleReply;

import lombok.Data;

@Data
public class CreateReplyDTO {

	private long articleId;
	
	private String replyContent;
}
