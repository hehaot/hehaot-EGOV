package fe.servlet;

import Service.EnterpriseService;
import ServiceImpl.EnterpriseServiceImpl;
import Util.Const;
import Util.DButil;
import Util.DateUtil;
import Util.WebUtil;
import bean.EnInv;
import bean.Enterprise;
import entity.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class SaveEnServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
/*
* 保存企业信息
* */

    private EnterpriseService enService = new EnterpriseServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("GB18030");

        //企业信息
        Enterprise en=new Enterprise();
        WebUtil.makeRequestToObject(request,en);
        en.setUsercode(((User)request.getSession(false).getAttribute("user")).getUsercode());
        en.setRegdate(DateUtil.format(new Date(), Const.DATE_FORMAT_YMD));

        //企业投资人的关系信息
        String[] invregnums=request.getParameterValues("invregnum");
        String[] regcapItems=request.getParameterValues("regcapItem");
        String[] scales=request.getParameterValues("scale");

        //遍历数组封装EnInvList，存储到List集合中
        List<EnInv> enInvList=new ArrayList<EnInv>();
        for (int i=0;i<invregnums.length;i++){
            EnInv enInv = new EnInv();
            enInv.setInvregnum(invregnums[i]);
            enInv.setRegcap(regcapItems[i]);
            enInv.setScale(scales[i]);
            enInvList.add(enInv);
        }
        //调用Model
        boolean savaSccess = enService.save(en,enInvList);
        //调用View
        if (savaSccess){
            response.sendRedirect("foreignExchange/newInputOrg.jsp");
        }

        /*//连接数据库
        PreparedStatement ps=null;
        int count=0;
        String sql="insert  into t_enterprise(orgcode,regno,cnname,enname,contactman,contacttel,regcap,outregcap,regcry,usercode,regdate) values(?,?,?,?,?,?,?,?,?,?,?)";
        try {
            ps=DButil.createStatement(sql,request);
            ps.setString(1,en.getOrgcode());
            ps.setString(2,en.getRegno());
            ps.setString(3,en.getCnname());
            ps.setString(4,en.getEnname());
            ps.setString(5,en.getContactman());
            ps.setString(6,en.getContacttel());
            ps.setInt(7,Integer.parseInt(en.getRegcap()));
            ps.setInt(8,Integer.parseInt(en.getOutregcap()));
            ps.setString(9,en.getRegcry());
            ps.setString(10,en.getUsercode());
            ps.setString(11,en.getRegdate());
            count=ps.executeUpdate();

            sql="insert into t_en_inv(orgcode,invregnum,regcap,scale) values(?,?,?,?)";
            ps=DButil.createStatement(sql,request);
            for (int i=0;i<invregnums.length;i++){
                ps.setString(1,en.getOrgcode());
                ps.setString(2,invregnums[i]);
                ps.setInt(3,Integer.parseInt(regcapItems[i]));
                ps.setInt(4,Integer.parseInt(scales[i]));

                count+=ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DButil.close(ps,null,request);
        }
        if (count == 1 + invregnums.length){
            response.sendRedirect("foreignExchange/newInputOrg.jsp");
        }*/
    }
}
