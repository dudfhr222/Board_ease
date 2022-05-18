package com.javalec.spring_mvc_board.command;

import com.javalec.spring_mvc_board.dao.BDao;
import com.javalec.spring_mvc_board.dto.BDto;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

public class BContentCommand implements BCommand{
    @Override
    public void execute(Model model) {
        Map<String, Object> map = model.asMap();
        // BController에서 request를 받아옴 ("bId",${dto.bId})
        // request => ("bId",bId)
        HttpServletRequest request = (HttpServletRequest) map.get("request");
        String bId = request.getParameter("bId");

        BDao dao = new BDao();
        BDto dto = dao.contentView(bId); //해당 아이디의 글 정보 가져옴
        model.addAttribute("content_view",dto); //key)"content_view" : content_view.jsp에서 사용
    }
}
