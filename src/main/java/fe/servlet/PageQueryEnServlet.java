package fe.servlet;

import Service.EnterpriseService;
import ServiceImpl.EnterpriseServiceImpl;
import bean.Enterprise;
import bean.Page;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class PageQueryEnServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
/*
* 分页查询企业信息
* */
    private EnterpriseService enService=new EnterpriseServiceImpl();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("GB18030");
        //接收数据
        String orgcode = request.getParameter("orgcode");
        String cnname = request.getParameter("cnname");
        String startdate = request.getParameter("startdate");
        String enddate = request.getParameter("enddate");
        String pageno = request.getParameter("pageno");
        //封装DTO对象
        Map<String,String> conditionMap = new HashMap<String,String>();
        conditionMap.put("orgcode",orgcode);
        conditionMap.put("cnname",cnname);
        conditionMap.put("startdate",startdate);
        conditionMap.put("enddate",enddate);
        conditionMap.put("pageno",pageno);
        //调用model
        Page<Enterprise> page=enService.pageQuery(conditionMap);
        request.setAttribute("page",page);
        //调用View
        request.getRequestDispatcher("auth/orgcodeSelect.jsp").forward(request,response);
    }
}
