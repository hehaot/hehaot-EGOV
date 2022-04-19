package ServiceImpl;

import Dao.UserDao;
import DaoImpl.UserDaoImpl;
import Service.UserService;
import Util.DButil;
import entity.User;

import java.sql.Connection;

public class UserServiceImpl implements UserService {

    private UserDao userDao= new UserDaoImpl();
    @Override
    public int save(User user) {
        Connection conn=null;
        conn = DButil.getConn();
        int count=0;
        try {
            DButil.beginTransaction(conn);
            User u  = userDao.selectByUsercode(user.getUsercode());
            if(u!=null){
                return -1;
            }
            count = userDao.insert(user);
            DButil.commitTransaction(conn);
        } catch (Exception e) {
            DButil.rollbackTransaction(conn);
            e.printStackTrace();
        } finally {
            DButil.endTransaction(conn);
            DButil.close(conn,null,null);
        }
        return count;
    }

}
