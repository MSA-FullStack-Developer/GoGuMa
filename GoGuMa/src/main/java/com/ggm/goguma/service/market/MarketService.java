package com.ggm.goguma.service.market;


import java.util.List;

import com.ggm.goguma.dto.PaginationDTO;
import com.ggm.goguma.dto.articleReply.ArticleReplyDTO;
import com.ggm.goguma.dto.articleReply.CreateChildReplyDTO;
import com.ggm.goguma.dto.articleReply.CreateReplyDTO;
import com.ggm.goguma.dto.market.ArticleProudctDTO;
import com.ggm.goguma.dto.market.CreateArticleDTO;
import com.ggm.goguma.dto.market.CreateMarketDTO;
import com.ggm.goguma.dto.market.EditArticleDTO;
import com.ggm.goguma.dto.market.FollowMarketDTO;
import com.ggm.goguma.dto.market.MarketArticleDTO;
import com.ggm.goguma.dto.market.MarketDTO;
import com.ggm.goguma.dto.member.MemberDTO;
import com.ggm.goguma.exception.UploadFileFailException;

public interface MarketService {

	MarketDTO createMarket(CreateMarketDTO data) throws UploadFileFailException, Exception;
	
	MarketDTO getMarket(long marketId) throws Exception;
	
	boolean isMyMarket(long marketId, long memberId);
	
	boolean isMyArticle(long marketId, long memberId, long articleId);
	
	boolean isAlreadyFollowMarket(FollowMarketDTO followMarket);
	
	boolean createOrDeleteFollowMarket(FollowMarketDTO followMarket);
	
	List<ArticleProudctDTO> getArticleProducts(String keyword, long memberId);
	
	void createMarketArticle(CreateArticleDTO article) throws Exception;
	
	MarketArticleDTO getMarketArticle(long articleId);
	
	PaginationDTO<MarketArticleDTO> getMarketArticles(long marketId, long page);

	/* *
	 * 작성자 : 경민영
	 * 작성일 : 2022.06.08
	 * */
	List<MarketDTO> getFollowedMarket(long memberId) throws Exception;

	List<MarketDTO> getUnfollowedMarket(long memberId) throws Exception;

	List<MarketArticleDTO> getAllArticle() throws Exception;

	Integer getMyMarket(long memberId) throws Exception;
	
	void editMarketArticle(EditArticleDTO article) throws Exception;
	
	ArticleReplyDTO createArticleReply(CreateReplyDTO reply, MemberDTO member) throws Exception;
	
	ArticleReplyDTO createChildArticleReply(CreateChildReplyDTO reply, MemberDTO member) throws Exception;
	
	List<ArticleReplyDTO> getArticleReplies(long articleId);
	
}
