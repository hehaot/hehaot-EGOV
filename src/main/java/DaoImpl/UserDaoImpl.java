package DaoImpl;

import Dao.UserDao;
import Util.DButil;
import entity.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDaoImpl implements UserDao {
    @Override
    public User selectByUsercode(String usercode) {
        Connection conn=null;
        PreparedStatement ps=null;
        ResultSet rs=null;
        User user=null;
        conn= DButil.getConn();
        //查询数据库验证用户代码是否存在
        try {
            String sql="select * from t_user where usercode=?";
            ps=conn.prepareStatement(sql);
            ps.setString(1,usercode);
            rs=ps.executeQuery();
            if (rs.next()){
                user =new User();
                user.setUsercode(usercode);
                user.setUsername(rs.getString("username"));
                user.setUsername(rs.getString("orgtype"));
                user.setUsername(rs.getString("userpswd"));
                user.setUsername(rs.getString("regdate"));
            }
        } catch (Exception throwables) {
            throwables.printStackTrace();
            throw  new RuntimeException("插入用户异常");
        } finally {
            DButil.close(null,ps,null);
        }
        return user;
    }

    @Override
    public int insert(User user) {
        Connection conn=null;
        PreparedStatement ps=null;
        int count =0;
         conn= DButil.getConn();
         //查询数据库验证用户代码是否存在
        try {
                String sql="insert into t_user(usercode,username,orgtype,userpswd,regdate) values(?,?,?,?,?)";
                ps=conn.prepareStatement(sql);

                ps.setString(1,user.getUsercode());
                ps.setString(2,user.getUsername());
                ps.setString(3,user.getOrgtype());
                ps.setString(4,user.getUserpswd());
                ps.setString(5,user.getRegdate());

                count = ps.executeUpdate();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
            throw  new RuntimeException("插入用户异常");
        } finally {
            DButil.close(null,ps,null);
        }
        return count;
    }
}
