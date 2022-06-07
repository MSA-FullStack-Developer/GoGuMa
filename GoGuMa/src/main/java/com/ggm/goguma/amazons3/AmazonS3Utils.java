package com.ggm.goguma.amazons3;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.ListIterator;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.AmazonServiceException;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.DeleteObjectRequest;
import com.amazonaws.services.s3.model.ListObjectsV2Request;
import com.amazonaws.services.s3.model.ListObjectsV2Result;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.services.s3.model.S3ObjectSummary;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AmazonS3Utils {

	@Value("${cloud.aws.s3.bucket}")
    private String bucket;

    @Value("${cloud.aws.region}")
    private String region;

    @Value("${cloud.aws.credentials.accessKey}")
    private String accessKey;

    @Value("${cloud.aws.credentials.secretKey}")
    private String secretKey;
    
    @Value("${cloud.aws.key}")
    private String key;

    private final AmazonS3 s3;

	// 버킷에 등록된 모든 폴더 불러오기
    public List<String> listFolder(String folder){

        ListObjectsV2Request listObjectsV2Request = new ListObjectsV2Request().withBucketName(this.bucket).withPrefix(folder);
        ListObjectsV2Result listObjectsV2Result = s3.listObjectsV2(listObjectsV2Request);

        ListIterator<S3ObjectSummary> listIterator = listObjectsV2Result.getObjectSummaries().listIterator();
        List<String> list = new ArrayList<>();

        while (listIterator.hasNext()){
            S3ObjectSummary object = listIterator.next();
            list.add(object.getKey());
        }
        
        return list;
    }

	// 파일 업로드
    public String[] uploadFile(String folderName, MultipartFile multipartFile) throws IOException {
        File uploadFile = convert(multipartFile)
                .orElseThrow(()->new IllegalArgumentException("MultipartFile 형식을 File로 전환하는 데에 실패하였습니다."));
        return upload(uploadFile, folderName);
    }

	// 파일 삭제
    public void deleteFile(String imageName){
        try {
        	String targetFile = key + imageName;
	      	s3.deleteObject(this.bucket, targetFile);
	      	System.out.println("삭제할 파일 이미지 : " + targetFile);
      	} catch (AmazonServiceException e) {
	      	System.err.println(e.getErrorMessage());
        }
    }

	// 폴더 삭제 (폴더안의 모든 파일 삭제)
    public void removeFolder(String folderName){
        ListObjectsV2Request listObjectsV2Request = new ListObjectsV2Request().withBucketName(this.bucket).withPrefix(folderName+"/");
        ListObjectsV2Result listObjectsV2Result = s3.listObjectsV2(listObjectsV2Request);
        ListIterator<S3ObjectSummary> listIterator = listObjectsV2Result.getObjectSummaries().listIterator();

        while (listIterator.hasNext()){
            S3ObjectSummary objectSummary = listIterator.next();
            DeleteObjectRequest request = new DeleteObjectRequest(this.bucket,objectSummary.getKey());
            s3.deleteObject(request);
            System.out.println("Deleted " + objectSummary.getKey());
        }
    }

    // 파일 업로드 이미지 이름과 URL을 반환
    private String[] upload(File uploadFile, String folderName){
        String fileName = folderName + "/" + uploadFile.getName();
        String uploadImageUrl = putS3(uploadFile, fileName);
        
        String[] uploadResult = { uploadFile.getName(), uploadImageUrl };
        System.out.println("reviewimagename : " + uploadFile.getName());
        System.out.println("reviewimagepath : " + uploadImageUrl);
        
        removeNewFile(uploadFile);
        return uploadResult;
    }

	// S3에 업로드 
    private String putS3(File uploadFile, String fileName){
        s3.putObject(new PutObjectRequest(this.bucket, fileName, uploadFile).withCannedAcl(CannedAccessControlList.PublicRead));
        return s3.getUrl(bucket, fileName).toString();
    }

	// 임시로 생성된 new file을 삭제
    private void removeNewFile(File targetFile){
        if (targetFile.delete()) {
            System.out.println("File deleted.");
        } else {
            System.out.println("File doesn't deleted.");
        }
    }

	// multipartFile을 File타입으로 변환 (변환된 파일을 가지고 업로드해주기)
    private Optional<File> convert(MultipartFile file) throws IOException {
    	File convertFile = new File(System.currentTimeMillis() + StringUtils.cleanPath(file.getOriginalFilename()));
        if (convertFile.createNewFile()) {
            try (FileOutputStream fos = new FileOutputStream(convertFile)) {
                fos.write(file.getBytes());
            }
            return Optional.of(convertFile);
        }
        return Optional.empty();
    }

}