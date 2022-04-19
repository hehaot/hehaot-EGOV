package ServiceImpl;

import Dao.AuthDao;
import DaoImpl.AuthDaoImpl;
import Service.AuthService;
import Util.DButil;
import bean.Auth;

import java.sql.Connection;
import java.util.Map;

public class AuthServiceImpl implements AuthService {

    private AuthDao authDao= new AuthDaoImpl();
    @Override
    public boolean saveAuth(Map<String, String> authMap) {
        Connection conn=null;
        int count=0;
        try {
            conn= DButil.getConn();
            DButil.beginTransaction(conn);
            count = authDao.insertAuth(authMap);
            DButil.commitTransaction(conn);
        } catch (Exception e) {
            DButil.rollbackTransaction(conn);
            e.printStackTrace();
        } finally {
            DButil.endTransaction(conn);
            DButil.close(conn,null,null);
        }
        return count==1;
    }

    @Override
    public Auth findByAuthno(String authno) {
        Connection conn=null;
        Auth auth=null;
        try {
            conn= DButil.getConn();
            DButil.beginTransaction(conn);
            auth = authDao.selectByAuthno(authno);
            DButil.commitTransaction(conn);
        } catch (Exception e) {
            DButil.rollbackTransaction(conn);
            e.printStackTrace();
        } finally {
            DButil.endTransaction(conn);
            DButil.close(conn,null,null);
        }
        return auth;
    }

    @Override
    public boolean feedback(String authno) {
        Connection conn=null;
        int count=0;
        try {
            conn= DButil.getConn();
            DButil.beginTransaction(conn);
            count = authDao.update(authno);
            DButil.commitTransaction(conn);
        } catch (Exception e) {
            DButil.rollbackTransaction(conn);
            e.printStackTrace();
        } finally {
            DButil.endTransaction(conn);
            DButil.close(conn,null,null);
        }
        return count==1;
    }
}
