package com.example.demo3;

import Service.UserService;
import ServiceImpl.UserServiceImpl;
import Util.Const;
import Util.DButil;
import Util.DateUtil;
import Util.WebUtil;
import entity.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class InsertUserServlet extends HttpServlet {

    private UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("GB18030");

        //数据的输入
        User user=new User();
        WebUtil.makeRequestToObject(request,user);
        user.setRegdate(DateUtil.format(new Date(),Const.DATE_FORMAT_ALL));
        //调用Model
        int retValue=userService.save(user);
        //调用View
        if (retValue == -1){
            String errorMsg="用户代码已经存在，请重新填写。";
            request.setAttribute("errorMsg",errorMsg);
            request.getRequestDispatcher("system/userAdd.jsp").forward(request,response);
        }else if (retValue == 1){
            response.sendRedirect("/myWeb/PageQueryUser");
        }
        /*//获取用户信息
        String usercode  = request.getParameter("usercode");
        String username  = request.getParameter("username");
        String orgtype   = request.getParameter("orgtype");
        String userpswd  = request.getParameter("userpswd");
        int count=0;
        //调用DateUtil
        PreparedStatement ps=null;
        ResultSet rs=null;
        boolean hasUser =false;
        String regdate= DateUtil.format(new Date(), Const.DATE_FORMAT_ALL);
        try {
            //查询数据库验证用户代码是否存在
            String sql="select * from t_user where usercode=?";
            ps=DButil.createStatement(sql,request);
            ps.setString(1,usercode);
            rs=ps.executeQuery();
            hasUser=rs.next();
            if (!hasUser){
                sql="insert into t_user(usercode,username,orgtype,userpswd,regdate) values(?,?,?,?,?)";
                ps=DButil.createStatement(sql,request);

                ps.setString(1,usercode);
                ps.setString(2,username);
                ps.setString(3,orgtype);
                ps.setString(4,userpswd);
                ps.setString(5,regdate);
                count=ps.executeUpdate();
            }

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            DButil.close(ps,rs);
        }
        if (hasUser){
            String errorMsg="用户代码已经存在，请重新填写。";
            request.setAttribute("errorMsg",errorMsg);
            request.getRequestDispatcher("system/userAdd.jsp").forward(request,response);
        }else{
            //保存成功重定向
            if (count==1){
                System.out.println("成功");
                response.sendRedirect("/myWeb/PageQueryUser");
            }
        }*/

    }
}
