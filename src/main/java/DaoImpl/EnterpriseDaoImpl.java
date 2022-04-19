package DaoImpl;

import Dao.EnterpriseDao;
import Util.DButil;
import Util.StringUtil;
import bean.EnInv;
import bean.Enterprise;
import bean.Page;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class EnterpriseDaoImpl implements EnterpriseDao {
    @Override
    public int insert(Enterprise en, List<EnInv> enInvList) {
        //连接数据库
        PreparedStatement ps=null;
        int count=0;
        String sql="insert  into t_enterprise(orgcode,regno,cnname,enname,contactman,contacttel,regcap,outregcap,regcry,usercode,regdate) values(?,?,?,?,?,?,?,?,?,?,?)";
        try {
            ps= DButil.createStatement(sql);
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
            ps=DButil.createStatement(sql);
            for (EnInv enInv:enInvList){
                ps.setString(1,en.getOrgcode());
                ps.setString(2,enInv.getInvregnum());
                ps.setInt(3,Integer.parseInt(enInv.getRegcap()));
                ps.setInt(4,Integer.parseInt(enInv.getScale()));

                count+=ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("保存企业失败");
        } finally {
            DButil.close(null,ps,null);
        }
        return count;
    }

    @Override
    public Page<Enterprise> pageQuery(Map<String, String> conditionMap) {
        Page<Enterprise> page=new Page<Enterprise>(conditionMap.get("pageno"));
        StringBuilder sql=new StringBuilder(" ");
        StringBuilder totalsizeSql=new StringBuilder(" ");
        List<String> paramList = new ArrayList<>();
        if (StringUtil.isNotEmpty(conditionMap.get("orgcode"))){
            sql.append(" and t_enterprise.orgcode=? ");
            totalsizeSql.append(" and t_enterprise.orgcode=? ");
            paramList.add(conditionMap.get("orgcode"));
        }
        if (StringUtil.isNotEmpty(conditionMap.get("cnname"))){
            sql.append(" and t_enterprise.cnname like ? ");
            totalsizeSql.append(" and t_enterprise.cnname like ? ");
            paramList.add("%"+conditionMap.get("cnname")+"%");
        }
        if (StringUtil.isNotEmpty(conditionMap.get("startdate"))){
            sql.append(" and t_enterprise.regdate >= ? ");
            totalsizeSql.append(" and t_enterprise.regdate >= ? ");
            paramList.add(conditionMap.get("startdate"));
        }
        if (StringUtil.isNotEmpty(conditionMap.get("enddate"))){
            sql.append(" and t_enterprise.regdate <= ? ");
            totalsizeSql.append(" and t_enterprise.regdate <= ? ");
            paramList.add(conditionMap.get("enddate"));
        }
        String pageSql= page.getSql(" Order By t_enterprise.regdate desc ,t_enterprise.cnname ",
                " t_enterprise.orgcode,t_enterprise.cnname,t_enterprise.regdate,t_user.username,t_enterprise.regcap,t_enterprise.outregcap ",
                "t_enterprise",
                "t_user",
                "t_enterprise.usercode = t_user.usercode",
                sql.toString());

        Connection conn=null;
        PreparedStatement ps=null;
        ResultSet rs=null;

        try {
           conn=DButil.getConn();
           ps= conn.prepareStatement(pageSql);
           for (int i=0;i<paramList.size();i++){
                ps.setString(i+1,paramList.get(i));
           }
           rs=ps.executeQuery();
           while (rs.next()){
               Enterprise en=new Enterprise();
               en.setOrgcode(rs.getString("orgcode"));
               en.setCnname(rs.getString("cnname"));
               en.setRegdate(rs.getString("regdate"));
               en.setUsername(rs.getString("username"));
               en.setRegcap(rs.getString("regcap"));
               en.setOutregcap(rs.getString("outregcap"));

               page.getDataList().add(en);
           }

           ps= conn.prepareStatement(page.getSql(" Order By t_enterprise.regdate desc ,t_enterprise.cnname ",
                   " t_enterprise.orgcode,t_enterprise.cnname,t_enterprise.regdate,t_user.username ",
                   "t_enterprise",
                   "t_user",
                   "t_enterprise.usercode = t_user.usercode",
                   totalsizeSql.toString(),
                   "count(*) as totalsize"));
            for (int i=0;i<paramList.size();i++){
                ps.setString(i+1,paramList.get(i));
            }
            rs=ps.executeQuery();
            if (rs.next()){
                page.setTotalsize(rs.getInt("totalsize"));
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("分页查询寻企业信息失败");
        } finally {
            DButil.close(null,ps,rs);
        }
        return page;
    }

    @Override
    public Enterprise selectByCode(String orgcode) {

        Connection conn=null;
        PreparedStatement ps=null;
        ResultSet rs=null;

        Enterprise en=null;

        String sql="select cnname,regcry,regcap from t_enterprise where orgcode=?";

        try {
            conn=DButil.getConn();
            ps= conn.prepareStatement(sql);
            ps.setString(1,orgcode);
            rs=ps.executeQuery();
            if (rs.next()){
                en=new Enterprise();
                en.setOrgcode(orgcode);
                en.setCnname(rs.getString("cnname"));
                en.setRegcry(rs.getString("regcry"));
                en.setRegcap(rs.getString("regcap"));
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("查询企业信息失败");
        } finally {
            DButil.close(null,ps,rs);
        }
        return en;
    }
}
