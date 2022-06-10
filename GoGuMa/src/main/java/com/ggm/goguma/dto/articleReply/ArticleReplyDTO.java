package com.ggm.goguma.dto.articleReply;

import java.util.Date;
import java.util.List;

import com.ggm.goguma.dto.member.MemberDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ArticleReplyDTO {

	private long replyId;
	
	private long articleId;
	
	private long replyPId;
	
	private MemberDTO member;
	
	private String replyContent;
	
	private Date createdAt;
	
	private boolean deleted;
	
	List<ArticleReplyDTO> childReplies;
}
