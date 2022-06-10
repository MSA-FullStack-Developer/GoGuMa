package com.ggm.goguma.service.market;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.ggm.goguma.amazons3.AmazonS3Utils;
import com.ggm.goguma.dto.CategoryDTO;
import com.ggm.goguma.dto.PaginationDTO;
import com.ggm.goguma.dto.articleReply.ArticleReplyDTO;
import com.ggm.goguma.dto.articleReply.CreateChildReplyDTO;
import com.ggm.goguma.dto.articleReply.CreateReplyDTO;
import com.ggm.goguma.dto.market.ArticleImageDTO;
import com.ggm.goguma.dto.market.ArticleProudctDTO;
import com.ggm.goguma.dto.market.CreateArticleDTO;
import com.ggm.goguma.dto.market.CreateMarketDTO;
import com.ggm.goguma.dto.market.EditArticleDTO;
import com.ggm.goguma.dto.market.FollowMarketDTO;
import com.ggm.goguma.dto.market.MarketArticleDTO;
import com.ggm.goguma.dto.market.MarketDTO;
import com.ggm.goguma.dto.member.MemberDTO;
import com.ggm.goguma.exception.NotFoundMarketArticleException;
import com.ggm.goguma.exception.NotFoundMarketException;
import com.ggm.goguma.exception.UploadFileFailException;
import com.ggm.goguma.mapper.ArticleReplyMapper;
import com.ggm.goguma.mapper.MarketMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
public class MarketServiceImpl implements MarketService {

	private final MarketMapper marketMapper;

	private final AmazonS3Utils amazonService;
	
	private final ArticleReplyMapper articleReplyMapper;

	private final long PAGESIZE = 8;
	private final long BLOCKSIZE = 10;

	@Override
	public MarketDTO createMarket(CreateMarketDTO data) throws UploadFileFailException, Exception {

		MultipartFile[] multipartFiles = { data.getThumbnail(), data.getBanner() };

		String[] savedThumbnail = this.amazonService.uploadFile("upload", multipartFiles[0]);

		String[] savedBanner = this.amazonService.uploadFile("upload", multipartFiles[1]);

		CategoryDTO category = new CategoryDTO();
		category.setCategoryID(data.getCategoryId());
		MarketDTO market = MarketDTO.builder().memberId(data.getMemberId()).category(category)
				.marketName(data.getMarketName()).marketDetail(data.getMarketDetail())
				.marketThumbnail(savedThumbnail[1]).marketBanner(savedBanner[1]).build();

		this.marketMapper.insertMarket(market);
		
		return market;
	}

	@Override
	public MarketDTO getMarket(long marketId) throws Exception {
		return this.marketMapper.findMarketById(marketId).orElseThrow(NotFoundMarketException::new);
	}

	@Override
	public boolean isAlreadyFollowMarket(FollowMarketDTO followMarket) {
		int count = this.marketMapper.findFollwMarketCountByMarketIdAndMemberId(followMarket);

		return count > 0 ? true : false;
	}

	@Override
	public boolean createOrDeleteFollowMarket(FollowMarketDTO followMarket) {

		boolean isCreated = true;

		if (!isAlreadyFollowMarket(followMarket)) {
			this.marketMapper.insertFollowMarket(followMarket);
		} else {
			isCreated = false;
			this.marketMapper.deleteFollowMarket(followMarket);
		}
		return isCreated;
	}

	@Override
	public List<ArticleProudctDTO> getArticleProducts(String keyword, long memberId) {
		return this.marketMapper.findOrderProduct(keyword, memberId);
	}

	@Override
	public boolean isMyMarket(long marketId, long memberId) {

		log.info("[isMyMarket] marketId, memberId :" + marketId + ", " + memberId);

		List<Long> findMarketIds = this.marketMapper.findMarketIdsByMemberId(memberId);

		log.info("[isMyMarket] findMarketIds : " + findMarketIds);
		// 생성한 마켓이 없는 경우
		if (findMarketIds.size() == 0) {
			log.info("[isMyMarket] 생성한 마켓 없음");

			return false;
		} else {

			if (!findMarketIds.contains(marketId)) { // 작성하려는 마켓 게시글과 해당 사용자가 생성한 마켓 아이디가 다를 경우
				log.info("[isMyMarket] 마켓 소유가 아님");
				return false;
			}
		}
		return true;
	}

	@Override
	public boolean isMyArticle(long marketId, long memberId, long articleId) {

		if (!this.isMyMarket(marketId, memberId)) {
			return false;
		}

		List<Long> findArticleIds = this.marketMapper.findArticleIdsByMarketId(marketId);

		if (findArticleIds.size() == 0) {
			log.info("[isMyArticle] 생성한 게시글 없음");
			return false;
		} else {
			if (!findArticleIds.contains(articleId)) {
				log.info("[isMyArticle] 게시글 소유자가 아님");
				return false;
			}
		}

		return true;
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public void createMarketArticle(CreateArticleDTO article) throws Exception {
		// 0. 썸네일 저장
		String[] uploadThumbnail = this.amazonService.uploadFile("upload", article.getThumbnail());

		// 1.imageName 추출
		List<ArticleImageDTO> images = this.extractImage(article.getArticleContent());

		ArticleImageDTO thumbnail = new ArticleImageDTO();
		thumbnail.setImageName(uploadThumbnail[0]);
		thumbnail.setImagePath(uploadThumbnail[1]);
		thumbnail.setThumbnail(true);
		images.add(thumbnail);

		// 2. article 생성
		MarketArticleDTO marketArticle = new MarketArticleDTO();
		marketArticle.setArticleTitle(article.getArticleTitle());
		marketArticle.setArticleContent(article.getArticleContent());

		MarketDTO market = new MarketDTO();
		market.setMarketId(article.getMarketId());
		marketArticle.setMarket(market);

		this.marketMapper.insertMarketArticle(marketArticle);

		long articleId = marketArticle.getArticleId();
		// 3. article 상품 생성
		for (long productId : article.getProductId()) {
			this.marketMapper.insertArticleProduct(articleId, productId);
		}

		// 4. article 이미지 생성
		for (ArticleImageDTO image : images) {
			image.setArticleId(articleId);
			this.marketMapper.insertArticleImage(image);
		}

	}

	private List<ArticleImageDTO> extractImage(String html) throws URISyntaxException {
		List<ArticleImageDTO> articleImages = new ArrayList<>();
		Document doc = Jsoup.parse(html);

		Elements elements = doc.select("img");

		for (Element element : elements) {
			String imgUrlSrc = element.attr("src");

			String path = new URI(imgUrlSrc).getPath();
			String imageName = path.substring(path.lastIndexOf("/") + 1);
			log.info(imageName);
			ArticleImageDTO image = new ArticleImageDTO();

			image.setImageName(imageName);
			image.setImagePath(imgUrlSrc);
			articleImages.add(image);
		}

		return articleImages;
	}

	@Override
	public MarketArticleDTO getMarketArticle(long articleId) {
		return this.marketMapper.findMarketArticleById(articleId).orElseThrow(NotFoundMarketArticleException::new);
	}

	@Override
	public PaginationDTO<MarketArticleDTO> getMarketArticles(long marketId, long page) {

		long offset = (page - 1) * this.PAGESIZE;

		List<MarketArticleDTO> articles = this.marketMapper.findMarketArticles(marketId, offset, this.PAGESIZE);

		long totalCount = this.marketMapper.countMarketArticles(marketId);
		
		log.info("[getMarketArticles] totalCount : " + totalCount);

		long pageCount = (long) Math.ceil((double)totalCount / this.PAGESIZE);

		log.info("[getMarketArticles] pageCount : " + pageCount);
	
		long startPage = offset / this.BLOCKSIZE * this.BLOCKSIZE + 1;
		if (startPage < 0)
			startPage = 1;

		long endPage = startPage + this.BLOCKSIZE - 1;
		if (endPage > pageCount)
			endPage = pageCount;

		PaginationDTO<MarketArticleDTO> paginationDTO = new PaginationDTO<>();

		paginationDTO.setTotalCount(totalCount);
		paginationDTO.setPageCount(pageCount);
		paginationDTO.setPageSize(this.PAGESIZE);
		paginationDTO.setBlockSize(this.BLOCKSIZE);
		paginationDTO.setStartPage(startPage);
		paginationDTO.setEndPage(endPage);
		paginationDTO.setData(articles);
		paginationDTO.setCurrentPage(page);

		return paginationDTO;
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public void editMarketArticle(EditArticleDTO article) throws Exception {

		// 0.imageName 추출
		List<ArticleImageDTO> images = this.extractImage(article.getArticleContent());

		// 1. 썸네일 저장
		ArticleImageDTO thumbnail = null;
		

		if (!article.getThumbnail().isEmpty()) {
			String[] uploadThumbnail = this.amazonService.uploadFile("upload", article.getThumbnail());
			thumbnail = new ArticleImageDTO();
			thumbnail.setImageName(uploadThumbnail[0]);
			thumbnail.setImagePath(uploadThumbnail[1]);
			thumbnail.setThumbnail(true);
			images.add(thumbnail);
		}
		
		MarketArticleDTO marketArticle = new MarketArticleDTO();
		marketArticle.setArticleId(article.getArticleId());
		marketArticle.setArticleTitle(article.getArticleTitle());
		marketArticle.setArticleContent(article.getArticleContent());

		MarketDTO market = new MarketDTO();
		market.setMarketId(article.getMarketId());
		marketArticle.setMarket(market);

		// 2. article 수정
		this.marketMapper.updateMarketArticle(marketArticle);

		long articleId = marketArticle.getArticleId();

		// 3. article 관련 상품 모두 삭제
		this.marketMapper.deleteAllArticleProduct(articleId);

		// 4. article 관련 이미지 모두 삭제
		if (thumbnail != null) {
			this.marketMapper.deleteAllArticleAimage(articleId, 1);
		}
		this.marketMapper.deleteAllArticleAimage(articleId, 0);

		// 5. article 상품 생성
		for (long productId : article.getProductId()) {
			this.marketMapper.insertArticleProduct(articleId, productId);
		}

		// 6. article 이미지 생성
		for (ArticleImageDTO image : images) {
			image.setArticleId(articleId);
			this.marketMapper.insertArticleImage(image);
		}

	}

	@Transactional
	@Override
	public ArticleReplyDTO createArticleReply(CreateReplyDTO reply, MemberDTO member) throws Exception {
		
		ArticleReplyDTO savedReply = ArticleReplyDTO.builder()
				.articleId(reply.getArticleId())
				.member(member)
				.replyContent(reply.getReplyContent())
				.build();

		this.articleReplyMapper.insertArticleReply(savedReply);
		
		return savedReply;
	}

	@Transactional
	@Override
	public ArticleReplyDTO createChildArticleReply(CreateChildReplyDTO reply, MemberDTO member) throws Exception {
		
		ArticleReplyDTO savedChildReply = ArticleReplyDTO.builder()
				.articleId(reply.getArticleId())
				.replyPId(reply.getReplyId())
				.member(member)
				.replyContent(reply.getReplyContent())
				.build();
		
		this.articleReplyMapper.insertChildArticleReply(savedChildReply);
		
		return savedChildReply;
	}

	@Override
	public List<ArticleReplyDTO> getArticleReplies(long articleId) {
		return this.articleReplyMapper.findRepliesByArticleId(articleId);
	}
	
	@Override
	public List<MarketDTO> getFollowedMarket(long memberId) throws Exception {
		return this.marketMapper.getFollowedMarket(memberId);
	}

	@Override
	public List<MarketDTO> getUnfollowedMarket(long memberId) throws Exception {
		return this.marketMapper.getUnfollowedMarket(memberId);
	}

	@Override
	public List<MarketArticleDTO> getAllArticle() throws Exception {
		return this.marketMapper.getAllArticle();
	}

	@Override
	public Integer getMyMarket(long memberId) throws Exception {
		return this.marketMapper.getMyMarket(memberId);
	}
}