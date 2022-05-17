package com.javalec.spring_mvc_board.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.javalec.spring_mvc_board.command.BCommand;
import com.javalec.spring_mvc_board.command.BListCommand;
import com.javalec.spring_mvc_board.command.BWriteCommand;

@Controller
public class BController {
	BCommand command;
	
	@RequestMapping("/list")
	public String list(Model model) {
		System.out.println("@@@### list()");
		//BListCommand »£√‚
		command = new BListCommand();
		command.execute(model);
		
		return "list";
	}
	
	@RequestMapping("/write_view")
	public String write_view() {
		System.out.println("@@@### write_view()");
		
		return "write_view";
	}
	
	@RequestMapping("/write")
	public String write(HttpServletRequest request, Model model) {
		System.out.println("@@@### write()");
		
		model.addAttribute("request", request);
		command = new BWriteCommand();
		command.execute(model);
		
		return "redirect:list";
	}
}
