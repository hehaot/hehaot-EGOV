package com.example.demo3;

import Util.DButil;
import entity.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String orgtype = request.getParameter("orgtype");
        String usercode = request.getParameter("usercode");
        String userpswd = request.getParameter("userpswd");

        PreparedStatement ps=null;
        ResultSet rs=null;
        boolean loginSuccess=false;
        //数据库查询是先查询where后最后一个条件的，所以把区分度最高的条件放在最后。
        /*针对mysql，其条件执行顺序是 从左往右，自上而下
        针对SQL server、orcale，其条件执行顺序是从右往左，自下而上
        */
        String sql="select username from t_user where userpswd=? and orgtype=? and usercode=?";
        ps= DButil.createStatement(sql,request);
        try {
            ps.setString(1,userpswd);
            ps.setString(2,orgtype);
            ps.setString(3,usercode);
            rs=ps.executeQuery();
            if (rs.next()){
                User user =new User();
                user.setUsercode(usercode);
                user.setUsername(rs.getString("username"));
                user.setOrgtype(orgtype);
                HttpSession session = request.getSession();
                session.setAttribute("user",user);
                //登陆成功
                loginSuccess = true ;
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            DButil.close(ps,rs);
        }
        if (loginSuccess){
            response.sendRedirect("main.html");
        }else{
            String errorMsg="身份认证失败，请重新登录";
            request.setAttribute("errorMsg",errorMsg);
            request.getRequestDispatcher("/").forward(request,response);
        }
    }
}
