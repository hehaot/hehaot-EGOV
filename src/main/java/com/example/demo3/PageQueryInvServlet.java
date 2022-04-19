package com.example.demo3;

import Util.DButil;
import Util.StringUtil;
import bean.Investor;
import bean.Page;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLOutput;
import java.util.ArrayList;
import java.util.List;

public class PageQueryInvServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("gbk");
        //获取查询条件
        //注意：request.getParameter()这个方法什么时候返回null，什么时候返回空字符串
        request.setCharacterEncoding("gbk");
        String invregnum = request.getParameter("invregnum");
        String invname = request.getParameter("invname");
        String startdate = request.getParameter("startdate");
        String enddate = request.getParameter("enddate");
        //创建分页都对象
        Page<Investor> page = new Page<Investor>(request.getParameter("pageno"));
        //创建list集合，用来给sql语句的？赋值
        List<String> paramList = new ArrayList<String>();
        StringBuilder sql1 = new StringBuilder();
        StringBuilder totalsizeSql = new StringBuilder();
        if (StringUtil.isNotEmpty(invregnum)) {
            sql1.append(" and invregnum=?");
            totalsizeSql.append(" and invregnum=?");
            paramList.add(invregnum);
        }
        if (StringUtil.isNotEmpty(invname)) {
            sql1.append(" and invname like ?");
            totalsizeSql.append(" and invname like ?");
            paramList.add("%" + invname + "%");
        }
        if (StringUtil.isNotEmpty(startdate)) {
            sql1.append(" and t_invest.regdate>=?");
            totalsizeSql.append(" and t_invest.regdate>=?");
            paramList.add(startdate);
        }
        if (StringUtil.isNotEmpty(enddate)) {
            sql1.append(" and t_invest.regdate<=?");
            totalsizeSql.append(" and t_invest.regdate<=?");
            paramList.add(enddate);
        }
        //获取分页SQL语句
        String pageSql = page.getSql(sql1.toString());
        //连接数据库
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = DButil.createStatement(pageSql, request);
            //给？赋值（可能有？号，也可能没有）
            for (int i = 0; i < paramList.size(); i++) {
                ps.setString(i + 1, paramList.get(i));
            }
            //执行sql语句查询结果集
            rs = ps.executeQuery();

            //遍历结果集封装Investor对象
            while (rs.next()) {
                Investor inv = new Investor();
                inv.setInvregnum(rs.getString("invregnum"));
                inv.setInvname(rs.getString("invname"));
                inv.setRegdate(rs.getString("regdate"));
                inv.setCty(rs.getString("cty"));
                inv.setUsername(rs.getString("username"));
                //将投资人对象存储到List集合中
                page.getDataList().add(inv);
            }
            //编译sql语句
            String sql2 = page.getSql(totalsizeSql.toString(), "");
            ps = DButil.createStatement(sql2, request);
            for (int i = 0; i < paramList.size(); i++) {
                ps.setString(i + 1, paramList.get(i));
            }
            rs = ps.executeQuery();
            if (rs.next()) {
                page.setTotalsize(rs.getInt("totalsize"));
            }

            //关联总记录条数

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DButil.close(ps, rs);
        }

        //将分页对象存储到request范围中
        request.setAttribute("page", page);

        request.getRequestDispatcher(request.getParameter("forward")).forward(request,response);
       /* String goPage = request.getParameter("goPage");
        if ("1".equals(goPage)) {
            //转发
            request.getRequestDispatcher("basicinfo/exoticOrgList.jsp").forward(request, response);
        } else if ("2".equals(goPage)) {
            request.getRequestDispatcher("foreignExchange/orgcodeSelect.jsp").forward(request, response);
        }*/
    }
}
