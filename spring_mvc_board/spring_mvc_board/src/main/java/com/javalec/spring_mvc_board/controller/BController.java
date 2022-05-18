package com.javalec.spring_mvc_board.controller;

import javax.servlet.http.HttpServletRequest;

import com.javalec.spring_mvc_board.command.*;
import com.javalec.spring_mvc_board.dao.BDao;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class BController {
	BCommand command = new BContentCommand();
	
	@RequestMapping("/list")
	public String list(Model model) {
		System.out.println("@@@### list()");
		command = new BListCommand();
		command.execute(model);

		//BListCommand에서 model이 list에 값을 넣음
		//return "list" -> list view 호출
		return "list"; 
	}
	
	//list.jsp에서 write_view라는 요청이 들어옴
	@RequestMapping("/write_view")
	public String write_view() {
		System.out.println("@@@### write_view()");
		
		//write_view.jsp 호출
		return "write_view"; 
	}

	//write_view의 form에서 action : write
	//request : write_view에서 넘어온 값이 저장됨
	@RequestMapping("/write")
	public String write(HttpServletRequest request, Model model) {
		System.out.println("@@@### write()");
		
		model.addAttribute("request", request);
		command = new BWriteCommand();
		command.execute(model);
		
		return "redirect:list";
	}
	
	//list.jsp에서 제목을 누를 때 content_view 이동
	@RequestMapping("content_view")
	public String content_view(HttpServletRequest request, Model model){
		System.out.println("@@@### content_view()");

		//<a href="content_view?bId=${dto.bId}">${dto.bTitle}</a>
		//bId값 -> request
		model.addAttribute("request", request);
		command = new BContentCommand();
		command.execute(model); //model.addAttribute("content_view",dto)
		return "content_view"; //view 호출만 함
	}

//	@RequestMapping("modify")
	@RequestMapping(value = "/modify", method={RequestMethod.POST})
	public String modify(HttpServletRequest req ,Model model){
		System.out.println("@@@### modify()");

		//"request" -> bId, bName, bTitle, bContent 가져옴
		model.addAttribute("request",req);
		//command : interface = new BModifyCommand(); : 업 캐스팅
		//구현체인 BModifyCommand()의 execute가 실행됨
		command = new BModifyCommand();
		command.execute(model);
		return "redirect:list";
	}
//	@RequestMapping("delete")
	@RequestMapping(value = "/delete")
	public String delete(HttpServletRequest request, Model model){
		System.out.println("@@@### delete()");
		
		//form action이 아니라 QueryString으로 넘어옴
		model.addAttribute("del",request);
		command = new BDeleteCommand();
		command.execute(model);
		return "redirect:list";
	}

}