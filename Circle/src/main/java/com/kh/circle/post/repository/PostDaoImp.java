package com.kh.circle.post.repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.Model;

import com.kh.circle.post.entity.Post;
import com.kh.circle.post.service.PostService;

@Repository
public class PostDaoImp implements PostDao {

	@Autowired
	private SqlSession sqlSession;

	int noOfRecords;

	@Override
	public List<Post> postTest2(Post post) {
		// TODO Auto-generated method stub

		System.out.println("dao 2 : " + post);
		return sqlSession.selectList("postTypeList2", post);
	}


		/*
		 * 페이징처리
		 * 
		 * @Override public int getNoOfRecords() {
		 * 
		 * 
		 * 
		 * return noOfRecords; }
		 * 
		 * @Override public List<Post> getPostList(int offset, int recordsPerPage) {
		 * 
		 * List<Post> postList = new ArrayList<Post>();
		 * 
		 * HashMap<String, Object> params = new HashMap<String, Object>();
		 * 
		 * params.put("offset", offset); params.put("noOfRecords", noOfRecords);
		 * 
		 * try { postList = sqlSession.selectList("postDao.selectPost", params);
		 * this.noOfRecords = sqlSession.selectOne("postDao.postCount");
		 * 
		 * } finally { sqlSession.close(); }
		 * 
		 * return postList; }
		 * 
		 * @Override public PostDao getInstance() { // TODO Auto-generated method stub
		 * return null; }
		 * 
		 */


	@Override
	public List<Post> postTest(Post post, String type) {

		
		System.out.println("post dao" + post);
		System.out.println("post type" + type);
		
		
		List<Post> list = sqlSession.selectList("postTypeList", post);
		
		return list;
	}
}