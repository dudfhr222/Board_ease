package com.javalec.spring_mvc_board.command;

import com.javalec.spring_mvc_board.dao.BDao;
import com.javalec.spring_mvc_board.dto.BDto;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

public class BModifyCommand implements BCommand{
    @Override
    public void execute(Model model) {
        Map<String, Object> map = model.asMap();
        HttpServletRequest request = (HttpServletRequest) map.get("request");

        String bId = request.getParameter("bId"); //(BDto)int bId
        String bName = request.getParameter("bName");
        String bTitle = request.getParameter("bTitle");
        String bContent = request.getParameter("bContent");

        BDao dao = new BDao();
        BDto dto = dao.mofidy(bId, bName, bTitle, bContent);
        model.addAttribute("content_view",dto);
    }
}
