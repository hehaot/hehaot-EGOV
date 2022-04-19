package com.example.demo3;

import Util.DButil;
import bean.Investor;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ViewInvServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String invregnum=request.getParameter("invregnum");

//        String ip= request.getRemoteAddr();
//        System.out.println(ip);
        PreparedStatement ps=null;
        ResultSet rs=null;
        Investor investor=null;
        String sql="select * from t_invest where invregnum=?";
        ps=DButil.createStatement(sql,request);
        try {
            ps.setString(1,invregnum);
            rs= ps.executeQuery();
            if (rs.next()){
                investor=new Investor();
                investor.setUsername(rs.getString("invname"));
                investor.setCty(rs.getString("cty"));
                investor.setOrgcode(rs.getString("orgcode"));
                investor.setContactman(rs.getString("contactman"));
                investor.setContacttel(rs.getString("contacttel"));
                investor.setEmail(rs.getString("email"));
                investor.setRemark(rs.getString("remark"));
                investor.setUsercode(rs.getString("usercode"));
                investor.setRegdate(rs.getString("regdate"));
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            DButil.close(ps,rs);
        }
        request.setAttribute("inv",investor);
        request.getRequestDispatcher("/basicinfo/exoticOrgView.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
