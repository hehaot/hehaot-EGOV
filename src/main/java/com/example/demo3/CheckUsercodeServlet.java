package com.example.demo3;

import Util.DButil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.awt.image.DataBuffer;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/*
*使用ajax校验用户代码是否可用
*  */
public class CheckUsercodeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String usercode=request.getParameter("usercode");
        ResultSet rs=null;
        boolean hasUser=false;
        String sql="select * from t_user where usercode=?";
        PreparedStatement ps=DButil.createStatement(sql,request);
        try {
            ps.setString(1,usercode);
            rs=ps.executeQuery();
            hasUser=rs.next();


        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            DButil.close(ps,rs);
        }
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out=response.getWriter();
        if (hasUser){
            out.print("<font color='red'>用户代码已经存在</font>");
        }else{
            out.print("<font color='green'>用户代码可以使用</font>");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
