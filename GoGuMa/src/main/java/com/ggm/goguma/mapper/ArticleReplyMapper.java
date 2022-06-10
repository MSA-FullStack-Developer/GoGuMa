package com.ggm.goguma.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ggm.goguma.dto.articleReply.ArticleReplyDTO;


public interface ArticleReplyMapper {

	void insertArticleReply(ArticleReplyDTO reply);
	
	void insertChildArticleReply(ArticleReplyDTO reply);
	
	List<ArticleReplyDTO> findRepliesByArticleId(@Param("articleId") long articleId);
	
	List<ArticleReplyDTO> findChildRepliesByReplypId(@Param("replyId") long replyId);
}
