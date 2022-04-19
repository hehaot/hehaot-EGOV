package com.example.demo3;

import Util.Const;
import Util.DButil;
import Util.DateUtil;
import Util.WebUtil;
import bean.Investor;
import entity.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class SaveInvServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
/*保存投资人信息
* */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("gbk");

        /*String invname = request.getParameter("invname");
        String cty = request.getParameter("cty");
        String orgcode = request.getParameter("orgcode");
        String contactman = request.getParameter("contactman");
        String contacttel = request.getParameter("contacttel");
        String email = request.getParameter("email");
        String remark = request.getParameter("remark");*/

        //创建对象
        Investor inv = new Investor();
        WebUtil.makeRequestToObject(request,inv);

        String usercode=((User)request.getSession().getAttribute("user")).getUsercode();
        String regdate= DateUtil.format(new Date(), Const.DATE_FORMAT_YMD);
        //连接数据库
        PreparedStatement ps=null;
        int count=0;
        String sql="insert into t_invest(invname,cty,orgcode,contactman,contacttel,email,remark,usercode,regdate) values(?,?,?,?,?,?,?,?,?)";
        ps=DButil.createStatement(sql,request);
        try {
            /*ps.setString(1,invname);
            ps.setString(2,cty);
            ps.setString(3,orgcode);
            ps.setString(4,contactman);
            ps.setString(5,contacttel);
            ps.setString(6,email);
            ps.setString(7,remark);
            ps.setString(8,usercode);
            ps.setString(9,regdate);*/
            ps.setString(1,inv.getInvname());
            ps.setString(2,inv.getCty());
            ps.setString(3,inv.getOrgcode());
            ps.setString(4,inv.getContactman());
            ps.setString(5,inv.getContacttel());
            ps.setString(6,inv.getEmail());
            ps.setString(7,inv.getRemark());

            ps.setString(8,usercode);
            ps.setString(9,regdate);
            count=ps.executeUpdate();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            DButil.close(ps,null);
        }
        if (count==1){
            response.sendRedirect("basicinfo/exoticOrgList.jsp");
        }
    }
}
