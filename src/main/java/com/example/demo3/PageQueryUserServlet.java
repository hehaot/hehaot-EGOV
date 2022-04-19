package com.example.demo3;

import Util.DButil;
import bean.Page;
import entity.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class PageQueryUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Page<User> page=new Page<User>(request.getParameter("pageno"));
        //业务SQL语句
        String sql="select usercode,username,orgtype from t_user order by regdate desc";
        //分页SQL语句
        ResultSet rs=null;
        String pageSql=page.getSql("t_user","usercode,username,orgtype","order by regdate desc");
        PreparedStatement ps=DButil.createStatement(pageSql,request);
        try {
            rs=ps.executeQuery();
            while (rs.next()){
                User user=new User();
                user.setUsercode(rs.getString("usercode"));
                user.setUsername(rs.getString("username"));
                user.setOrgtype(rs.getString("orgtype"));
                page.getDataList().add(user);
            }
            //查询总记录条数
            sql="select count(*) as totalsize from t_user";
            ps=DButil.createStatement(sql,request);
            rs=ps.executeQuery();
            while (rs.next()){
                page.setTotalsize(rs.getInt("totalsize"));
            }

        } catch (Exception throwables) {
            throwables.printStackTrace();
        } finally {
            DButil.close(ps,rs);
        }
        request.setAttribute("page",page);
        //转发
        request.getRequestDispatcher("system/user.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
