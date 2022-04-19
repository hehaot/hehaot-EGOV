package com.example.demo3;

import Util.DButil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/*
 * 删除用户信息
 * */
public class DeleteUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取所有需要删除的用户代码
        String usercodes[] = request.getParameterValues("usercode");
        //开启事务

        boolean deleteSuccess=true;
        String sql = "delete from t_user where usercode = ?";
        PreparedStatement ps = DButil.createStatement(sql, request);
        try {
            for (String usercode:usercodes) {
                ps.setString(1, usercode);
                //count+=ps.executeUpdate();
                //大包
                ps.addBatch();
            }
            //发送
            ps.executeBatch();
            //提交事务

        } catch (Exception throwables) {
            throwables.printStackTrace();
            //回滚事务

            deleteSuccess=false;
        } finally {
            //结束事务

            DButil.close(ps,null);
        }
        if (deleteSuccess){
            response.sendRedirect("/myWeb/PageQueryUser");
        }
    }
}
