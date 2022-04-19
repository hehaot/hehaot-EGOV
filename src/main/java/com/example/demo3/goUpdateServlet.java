package com.example.demo3;

import Util.DButil;
import entity.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class goUpdateServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //
        String usercode=request.getParameter("usercode");
        String sql="select username,userpswd,orgtype from t_user where usercode=?";
        ResultSet rs=null;
        User user=null;
        PreparedStatement ps= DButil.createStatement(sql,request);
        try {
            ps.setString(1,usercode);
            rs=ps.executeQuery();
            while (rs.next()){
                user=new User();
                user.setUsercode(usercode);
                user.setUsername(rs.getString("username"));
                user.setUserpswd(rs.getString("userpswd"));
                user.setOrgtype(rs.getString("orgtype"));
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            DButil.close(ps,rs);
        }
        request.setAttribute("user",user);
        request.getRequestDispatcher("/system/userUpdate.jsp").forward(request,response);
    }
}
