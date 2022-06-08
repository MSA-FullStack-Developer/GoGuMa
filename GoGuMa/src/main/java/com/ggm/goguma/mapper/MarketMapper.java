package com.ggm.goguma.mapper;

import java.util.List;
import java.util.Optional;

import org.apache.ibatis.annotations.Param;

import com.ggm.goguma.dto.market.ArticleImageDTO;
import com.ggm.goguma.dto.market.ArticleProudctDTO;
import com.ggm.goguma.dto.market.FollowMarketDTO;
import com.ggm.goguma.dto.market.MarketArticleDTO;
import com.ggm.goguma.dto.market.MarketDTO;

public interface MarketMapper {
	
	void insertMarket(MarketDTO market) throws Exception;

	Optional<MarketDTO> findMarketById(@Param("id") long marketId) throws Exception;
	
	List<Long> findMarketIdsByMemberId(@Param("id") long memberId);
	
	List<Long> findArticleIdsByMarketId(@Param("id") long marketId);
	
	int findFollwMarketCountByMarketIdAndMemberId(FollowMarketDTO followMarket);
	
	void insertFollowMarket(FollowMarketDTO followMarket);
	
	void deleteFollowMarket(FollowMarketDTO followMarket);

	List<ArticleProudctDTO> findOrderProduct(@Param("keyword") String keyword, @Param("id") long memberId);
	
	void insertMarketArticle(MarketArticleDTO article);
	
	void insertArticleProduct(@Param("articleId") long articleId, @Param("productId") long productId);
	
	void insertArticleImage(ArticleImageDTO articleImage);
	
	void updateMarketArticle(MarketArticleDTO article);
	
	void deleteAllArticleProduct(@Param("articleId") long articleId);
	
	void deleteAllArticleAimage(@Param("articleId") long articleId, @Param("isthumbnail") long isthumbnail);
	
	
	Optional<MarketArticleDTO> findMarketArticleById(@Param("articleId") long articleId);
	
	ArticleImageDTO findThumbnailImageById(@Param("articleId") long articleId);
	
	List<ArticleProudctDTO> findArticleProductsById(@Param("articleId") long articleId);
	
	List<MarketArticleDTO> findMarketArticles(@Param("marketId") long marketId, @Param("offset") long offset, @Param("limit") long limit);
	
	int countMarketArticles(@Param("marketId") long marketId);
}
