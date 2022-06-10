package com.ggm.goguma.dto.articleReply;

import lombok.Data;

@Data
public class UpdateChildReplyDTO {

	private long articleId;
	
	private long replyId;
	
	private String replyContent;
}
