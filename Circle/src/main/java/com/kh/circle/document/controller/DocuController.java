package com.kh.circle.document.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kh.circle.document.service.DocuService;
import com.kh.circle.document.vo.DocuFiles;
import com.kh.circle.document.vo.DocuList;
import com.kh.circle.document.vo.DocuReply;
import com.kh.circle.document.vo.DocuSelectOne;
import com.kh.circle.document.vo.DocuWriteInsert;
import com.kh.circle.login.entity.EmpInfo;
import com.kh.circle.sign.vo.PageInfo;
import com.kh.circle.sign.vo.SignList;

@Controller
@RequestMapping("/docu")
public class DocuController {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private DocuService docuService;
	
//	Create Document
	@GetMapping("/docuWrite")
	public String docuWrite() {
		
		return "document/docuWrite";
	}
	
	
//	Create Document
	@PostMapping("/docuWrite")
	public String docuWriteInsert(@ModelAttribute DocuWriteInsert docuWriteInsert) throws IllegalStateException, IOException{
		
		docuService.insert(docuWriteInsert);
		
		return "redirect:docuList";
		
	}
	
	
//	Create docuFiles
	@PostMapping("/docuFiles")
	public String upload(MultipartHttpServletRequest multipartRequest) {
		
		Iterator<String> itr = multipartRequest.getFileNames();
		
		 String filePath = "d:/resources/files/document";
	       
	       while (itr.hasNext()) { 
	           MultipartFile multipartFile = multipartRequest.getFile(itr.next());   
	    
	           String files_oname = multipartFile.getOriginalFilename();
	           
	           String extension = files_oname.substring(files_oname.lastIndexOf("."), files_oname.length());
	           
	           long files_size = multipartFile.getSize();
	           
	           String files_type = multipartFile.getContentType();
	           
	           String files_cname = UUID.randomUUID().toString() + extension;
	           
	           String files_route = filePath + "/" + files_cname;
	    
	           try {
	        	   multipartFile.transferTo(new File(files_route));

	        	   docuService.insertFile(files_oname, files_size, files_type, files_cname, files_route);
	        	   
	           } catch (Exception e) {
	               e.printStackTrace();
	           }
	      }
	       return "success";
	}
	
	
//	Result docuList
	@GetMapping("/docuList")
	public String docuList(Model model, HttpSession session) {
		
		if(null != session.getAttribute("empInfo")) {
			
			String empCode = ((EmpInfo)session.getAttribute("empInfo")).getEmp_info_emp_no();
			
			List<DocuList> list1 = sqlSession.selectList("docu.docuListPrivate", empCode);
			
			model.addAttribute("list1", list1);
			
			List<DocuList> list2 = sqlSession.selectList("docu.docuListPublic", empCode);

			model.addAttribute("list2", list2);
			
		}
		
		return "document/docuList";
	}
	
	
//	Result docuSelectOne
	@GetMapping("/docuSelectOne")
	public String docuSelectOne(@RequestParam String docuCode, Model model) {

		DocuSelectOne docuSelectOne = sqlSession.selectOne("docu.docuSelectOne", docuCode);
		
		model.addAttribute("docuSelectOne", docuSelectOne);
		
		List<DocuFiles> list1 = sqlSession.selectList("docu.docuFileList", docuCode);
		model.addAttribute("list1", list1);
		
		List<DocuReply> list2 = sqlSession.selectList("docu.docuReply", docuCode);
		model.addAttribute("list2", list2);
		
		return "document/docuSelectOne";
	}

	
//	Result docuAllPersonal
	@GetMapping("/docuAllPersonal")
	public String docuAllPersonal(@RequestParam(required = false) String currentPages, HttpSession session, Model model) {
		
		if(null != session.getAttribute("empInfo")) {
			String empCode = ((EmpInfo)session.getAttribute("empInfo")).getEmp_info_emp_no();
			int currentPage;
			int limit;
			int maxPage;
			int startPage;
			int endPage;
			
			currentPage = 1;
			
			if(currentPages != null) {
				currentPage = Integer.parseInt(currentPages);
			}
			
			limit = 9;
			
			int listCount = sqlSession.selectOne("docu.docuAllPersonalCount", empCode);
			
			maxPage = (int)((double) listCount / limit + 0.9);
			
			startPage = (((int)((double) currentPage / limit + 0.9)) - 1) * 10 + 1;
			
			endPage = startPage + 10 - 1;
			
			if(maxPage < endPage) {
				endPage = maxPage;
			}
			
			PageInfo pi = new PageInfo(currentPage, listCount, limit, maxPage, startPage, endPage);
			
			int startRow = (pi.getCurrentPage() -1) * pi.getLimit() + 1;
			int endRow = startRow + pi.getLimit() -1;
			
			Map<String, Object> map = new HashMap<>();
			
			map.put("startRow", startRow);
			map.put("endRow", endRow);
			map.put("empCode", empCode);
			
			List<SignList> list = sqlSession.selectList("docu.docuAllPersonal", map);
			model.addAttribute("list", list);
			model.addAttribute("pi", pi);
		}	
		
		return "document/docuAllPersonal";
	}
	


//	Result docuAllPublic
	@GetMapping("/docuAllPublic")
	public String docuAllPublic(@RequestParam(required = false) String currentPages, HttpSession session, Model model) {
		
		if(null != session.getAttribute("empInfo")) {
			String empCode = ((EmpInfo)session.getAttribute("empInfo")).getEmp_info_emp_no();
			int currentPage;
			int limit;
			int maxPage;
			int startPage;
			int endPage;
			
			currentPage = 1;
			
			if(currentPages != null) {
				currentPage = Integer.parseInt(currentPages);
			}
			
			limit = 9;
			
			int listCount = sqlSession.selectOne("docu.docuAllPublicCount", empCode);
			
			maxPage = (int)((double) listCount / limit + 0.9);
			
			startPage = (((int)((double) currentPage / limit + 0.9)) - 1) * 10 + 1;
			
			endPage = startPage + 10 - 1;
			
			if(maxPage < endPage) {
				endPage = maxPage;
			}
			
			PageInfo pi = new PageInfo(currentPage, listCount, limit, maxPage, startPage, endPage);
			
			int startRow = (pi.getCurrentPage() -1) * pi.getLimit() + 1;
			int endRow = startRow + pi.getLimit() -1;
			
			Map<String, Object> map = new HashMap<>();
			
			map.put("startRow", startRow);
			map.put("endRow", endRow);
			map.put("empCode", empCode);
			
			List<SignList> list = sqlSession.selectList("docu.docuAllPublic", map);
			model.addAttribute("list", list);
			model.addAttribute("pi", pi);
		}	
		
		return "document/docuAllPublic";
	}	
	
//	Update docuUpdate
	@GetMapping("/docuUpdate")
	public String docuUpdate(@RequestParam String docuCode, HttpSession session, Model model) {
		String empCode = ((EmpInfo)session.getAttribute("empInfo")).getEmp_info_emp_no();
		
		DocuSelectOne docuSelectOne = sqlSession.selectOne("docu.docuSelectOne", docuCode);
		model.addAttribute("docuSelectOne", docuSelectOne);

		List<DocuFiles> list1 = sqlSession.selectList("docu.docuFileList", docuCode);
		model.addAttribute("list1", list1);
		
		return "document/docuUpdate";
	}
	
	
	
	
//	Update docuUpdate
	@PostMapping("/docuUpdate")
	public String docuUpdate(@ModelAttribute DocuSelectOne docuSelectOne) {
		
		sqlSession.update("docu.docuUpdate", docuSelectOne);
		
		return "redirect:docuList";
	}
	

//	Delete document
	@PostMapping("/docuDelete")
	public String docudelete(@RequestParam String docuCode) {
		
		sqlSession.update("docu.docuDelete", docuCode);
	
	return "redirect:docuList";
	
	}
	
}
