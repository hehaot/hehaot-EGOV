package com.example.demo3;

import Util.DButil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class updateUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("GB18030");
        String usercode =request.getParameter("usercode");
        String username =request.getParameter("username");
        String userpswd =request.getParameter("userpswd");
        String orgtype =request.getParameter("orgtype");
        PreparedStatement ps=null;
        int count=0;
        String sql="update t_user set username=?,userpswd=?,orgtype=? where usercode=?";
        ps= DButil.createStatement(sql,request);
        try {
            ps.setString(1,username);
            ps.setString(2,userpswd);
            ps.setString(3,orgtype);
            ps.setString(4,usercode);
            count=ps.executeUpdate();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            DButil.close(ps,null);
        }
        if (count==1){
            response.sendRedirect("/myWeb/PageQueryUser?pageno="+request.getParameter("pageno"));
        }
    }
}
