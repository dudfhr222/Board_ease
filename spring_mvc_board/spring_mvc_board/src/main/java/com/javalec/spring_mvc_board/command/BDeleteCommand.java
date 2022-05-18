package com.javalec.spring_mvc_board.command;

import com.javalec.spring_mvc_board.dao.BDao;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

public class BDeleteCommand implements BCommand{
    @Override
    public void execute(Model model) {
        Map<String, Object> map = model.asMap();
        HttpServletRequest request = (HttpServletRequest) map.get("del");
        //content_view에서 넘어온 값
        String bId = request.getParameter("bId");

        BDao dao = new BDao();
        dao.delete(bId);
    }
}