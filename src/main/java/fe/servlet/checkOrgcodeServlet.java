package fe.servlet;

import Util.DButil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class checkOrgcodeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orgcode = request.getParameter("orgcode");
        PreparedStatement ps=null;
        ResultSet rs=null;
        boolean hasEn = false;
        String sql="select * from t_enterprise where orgcode=?";
        ps= DButil.createStatement(sql,request);
        try {
            ps.setString(1,orgcode);
            rs=ps.executeQuery();
            hasEn=rs.next();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            DButil.close(ps,rs);
        }
        if (hasEn){
            request.setAttribute("errorMsg","该组织机构代码已经存在，请重新填写");
            request.getRequestDispatcher("foreignExchange/newInputOrg.jsp").forward(request,response);
        }else{
            request.getRequestDispatcher("foreignExchange/inputOrgInfo.jsp").forward(request,response);
        }
    }
}
