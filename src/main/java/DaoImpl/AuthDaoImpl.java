package DaoImpl;

import Dao.AuthDao;
import Util.DButil;
import bean.Auth;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

public class AuthDaoImpl implements AuthDao {
    @Override
    public int insertAuth(Map<String, String> authMap) {
        Connection conn=null;
        PreparedStatement ps=null;
        int count=0;

        conn= DButil.getConn();
        String sql="insert into t_auth(orgcode,remark,contactman,contacttel,filename,fileremark,usercode,feedback) values(?,?,?,?,?,?,?,'0')";
        try {
            ps=conn.prepareStatement(sql);
            ps.setString(1,authMap.get("orgcode"));
            ps.setString(2,authMap.get("remark"));
            ps.setString(3,authMap.get("contactman"));
            ps.setString(4,authMap.get("contacttel"));
            ps.setString(5,authMap.get("filename"));
            ps.setString(6,authMap.get("fileremark"));

            ps.setString(7,authMap.get("usercode"));

            count=ps.executeUpdate();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
            throw new RuntimeException("DAO:保存核准异常");
        } finally {
            DButil.close(null,ps,null);
        }
        return count;
    }

    @Override
    public Auth selectByAuthno(String authno) {
        Connection conn=null;
        PreparedStatement ps=null;
        ResultSet rs=null;
        Auth auth=null;

        conn= DButil.getConn();
        String sql="select e.regdate,a.contactman,a.contacttel,e.regcap,e.regcry from t_auth a join t_enterprise e on a.orgcode=e.orgcode where a.authno=?";
        try {
            ps=conn.prepareStatement(sql);
            ps.setString(1,authno);
            rs=ps.executeQuery();
            if (rs.next()){
                auth = new Auth();
                auth.setAuthno(authno);
                auth.setRegdate(rs.getString("regdate"));
                auth.setContactman(rs.getString("contactman"));
                auth.setContacttel(rs.getString("contacttel"));
                auth.setRegcap(rs.getString("regcap"));
                auth.setRegcry(rs.getString("regcry"));
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
            throw new RuntimeException("DAO:查看核准异常");
        } finally {
            DButil.close(null,ps,rs);
        }
        return auth;
    }

    @Override
    public int update(String authno) {
        Connection conn=null;
        PreparedStatement ps=null;
        int count=0;

        conn= DButil.getConn();
        String sql="update t_auth set feedback='1' where authno=?";
        try {
            ps=conn.prepareStatement(sql);
            ps.setString(1,authno);
            count=ps.executeUpdate();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
            throw new RuntimeException("DAO:反馈核准异常");
        } finally {
            DButil.close(null,ps,null);
        }
        return count;
    }
}
