package com.kh.circle.sign.repository;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.circle.sign.vo.SignFiles;
import com.kh.circle.sign.vo.SignReplyInsert;
import com.kh.circle.sign.vo.SignType;
import com.kh.circle.sign.vo.SignWriteInsert;

@Repository
public class SignDaoImpl implements SignDao {
		
	@Autowired
	private SqlSession sqlSession;

	//결재 등록
	@Override
	public void add(SignWriteInsert signWriteInsert) {
		
		//시퀀스 번호 생성 및 결재 등록
		String seqSign = sqlSession.selectOne("sign.seqSign");	
		signWriteInsert.setSeqSign(seqSign);
		sqlSession.insert("sign.signWriteInsert", signWriteInsert);
		
		//생성된 시퀀스 번호로 결재자 등록
		String jList = signWriteInsert.getJCodeList();
		String [] jListArray = jList.split("/");
		Map<String, Object> jmap = new HashMap<>();
		
			for(int i = 0; i < jListArray.length; i++) {
				
				//결재자 시퀀스 번호 생성
				String seqSignJoiner = sqlSession.selectOne("sign.seqSignJoiner");
				
				jmap.put("seqSignJoiner", seqSignJoiner);
				jmap.put("seqSign", seqSign);
				jmap.put("sign_join_emp_code", jListArray[i]);
				
				sqlSession.insert("sign.signWriteJoiner", jmap);
			}
			
		//생성된 시숸스 번호로 참조자 등록
		String wList = signWriteInsert.getWCodeList();
		
		if(wList.length() != 0) {
			String [] wListArray = wList.split("/");
			Map<String, Object> wmap = new HashMap<>();
			
				for(int i = 0; i <wListArray.length; i++) {
					
					//참조자 시퀀스 번호 생성
					String seqSignJoiner = sqlSession.selectOne("sign.seqSignJoiner");
					
					wmap.put("seqSignJoiner", seqSignJoiner);
					wmap.put("seqSign", seqSign);
					wmap.put("sign_join_emp_code", wListArray[i]);
					
					sqlSession.insert("sign.signWriteWatcher", wmap);
				}
		}
		
		sqlSession.insert("sign.signProcessAdd1", seqSign);
	}
	
	//결재 파일 등록
	private final String path = "d:/upload/kh52/resources/files/sign";
	
	@Override
	public void add(String files_oname, long files_size, String files_type, String files_cname, String files_route) {
		
		//시퀀스 번호 생성 및 파일 등록
		String seqSignFiles = sqlSession.selectOne("sign.seqSignFiles");	
		
		//결재 시퀀스 조회 및 등록
		
		String seqSignFilesCurrval = sqlSession.selectOne("sign.seqSignFilesCurrval");
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("seqSignFiles", seqSignFiles);
		map.put("seqSignFilesCurrval", seqSignFilesCurrval);
		map.put("files_oname", files_oname);
		map.put("files_size", files_size);
		map.put("files_type", files_type);
		map.put("files_cname", files_cname);
		map.put("files_route", files_route);
		
		sqlSession.insert("sign.signFiles", map);
	}

	//결재 첨부 파일 정보 찾기
	@Override
	public SignFiles find(String fileCode) {
		return sqlSession.selectOne("sign.signFileOne", fileCode);
	}

	//결재 첨부 파일 로드
	@Override
	public byte[] load(String files_cname) throws IOException {
		File target = new File(path, String.valueOf(files_cname));
		byte[] data = FileUtils.readFileToByteArray(target);
		
		return data;
	}

	//결재 댓글 등록
	@Override
	public void add(SignReplyInsert signReplyInsert) {
		
		//시퀀스 번호 생성 및 파일 등록
		String seqReply = sqlSession.selectOne("sign.seqSignReply");
		
		//결재 댓글 등록
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("seqSignReply", seqReply);
		map.put("sign_code", signReplyInsert.getSign_code());
		map.put("sign_reply_content", signReplyInsert.getSign_reply_content());
		map.put("emp_info_emp_code", signReplyInsert.getSign_reply_emp_code());
		
		sqlSession.insert("sign.signReplyInsert", map);
		
	}

	//결재 서명 파일 등록
	@Override
	public void add(String files_oname, long files_size, String files_type, String files_cname, String files_route,
			String iempCode) {
		
		//시퀀스 번호 생성 및 파일 등록
		String seqSignFiles = sqlSession.selectOne("sign.seqSignFiles");	
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("seqSignFiles", seqSignFiles);
		map.put("files_oname", files_oname);
		map.put("files_size", files_size);
		map.put("files_type", files_type);
		map.put("files_cname", files_cname);
		map.put("files_route", files_route);
		map.put("iempCode", iempCode);
		
		sqlSession.insert("sign.signFilesSignatureInsert", map);
	}
	
	//결재 서명 이미지 파일 경로
	private final String path2 = "d:/upload/kh52/resources/files/sign/signature/image";

	//결재 서명 기본 파일 경로
	private final String path3 = "d:/upload/kh52/resources/files/sign/signature/default";
	
	//결재 서명 파일 다운
	@Override
	public byte[] loadFile(String files_cname) throws IOException {
		File target = new File(path2, String.valueOf(files_cname));
		byte[] data = FileUtils.readFileToByteArray(target);
		return data;
	}

	//결재 동의 댓글 등록
	@Override
	public void addAgree(String empCode, String signCode, String fileCode) {
		
		//시퀀스 번호 생성 및 파일 등록
		String seqReply = sqlSession.selectOne("sign.seqSignReply");
		
		//결재 댓글 등록
		Map<String, Object> map = new HashMap<>();
		
		map.put("seqSignReply", seqReply);
		map.put("sign_code", signCode);
		map.put("sign_reply_content", fileCode);
		map.put("emp_info_emp_code", empCode);
		
		sqlSession.insert("sign.signResultInsert", map);
		
	}

	//결재 서명 파일 삭제 업데이트
	@Override
	public void update(String fileCode) {
		sqlSession.update("sign.sfsDelete", fileCode);
	}

	//결재 댓글 삭제
	@Override
	public void add(String replyCode) {
		sqlSession.delete("sign.signReplyDelete", replyCode);
		
	}

	//결재 타입 추가
	@Override
	public void add(SignType signType) {
		
		String seqSignType = sqlSession.selectOne("sign.seqSignType");
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("seqSignType", seqSignType);
		map.put("sign_type_code", signType.getSign_type_code());
		map.put("sign_type_name", signType.getSign_type_name());
		map.put("sign_type_content", signType.getSign_type_content());

		sqlSession.insert("sign.signTypeInsert", map);
		
	}

	//결재 타입 삭제
	@Override
	public void addDeleteSignType(String typeCode) {
		sqlSession.delete("sign.signTypeDelete", typeCode);
		
	}

}
