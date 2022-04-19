package fe.servlet;

import Service.EnterpriseService;
import ServiceImpl.EnterpriseServiceImpl;
import bean.Enterprise;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class ViewEnServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
    private EnterpriseService enService=new EnterpriseServiceImpl();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orgcode=request.getParameter("orgcode");

        Enterprise en = enService.findByCode(orgcode);

        request.setAttribute("en",en);

        request.getRequestDispatcher("auth/openAccountAuthDetail.jsp").forward(request,response);
    }
}
