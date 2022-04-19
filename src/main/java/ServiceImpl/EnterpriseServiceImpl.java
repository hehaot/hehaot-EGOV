package ServiceImpl;

import Dao.EnterpriseDao;
import DaoImpl.EnterpriseDaoImpl;
import Service.EnterpriseService;
import Util.DButil;
import bean.EnInv;
import bean.Enterprise;
import bean.Page;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

public class EnterpriseServiceImpl implements EnterpriseService {

    private EnterpriseDao enDao= new EnterpriseDaoImpl();


    @Override
    public boolean save(Enterprise en, List<EnInv> enInvList) {
        Connection conn=null;
        int count=0;
        conn = DButil.getConn();
        try {
            DButil.beginTransaction(conn);
            count =enDao.insert(en,enInvList);

            DButil.commitTransaction(conn);
        } catch (Exception e) {
            DButil.rollbackTransaction(conn);
            e.printStackTrace();
        } finally {
            DButil.endTransaction(conn);
            DButil.close(conn,null,null);
        }

        return count==1+enInvList.size();
    }

    /*
    * */

    @Override
    public Page<Enterprise> pageQuery(Map<String,String> conditionMap) {
        Connection conn=null;
        conn = DButil.getConn();
        Page<Enterprise> page=null;
        try {
            DButil.beginTransaction(conn);
            page= enDao.pageQuery(conditionMap);
            DButil.commitTransaction(conn);
        } catch (Exception e) {
            DButil.rollbackTransaction(conn);
            e.printStackTrace();
        } finally {
            DButil.endTransaction(conn);
            DButil.close(conn,null,null);
        }
        return page;
    }
    /*
    * */

    @Override
    public Enterprise findByCode(String orgcode) {
        Connection conn=null;
        Enterprise en=null;
        conn = DButil.getConn();
        try {
            DButil.beginTransaction(conn);
            en =enDao.selectByCode(orgcode);

            DButil.commitTransaction(conn);
        } catch (Exception e) {
            DButil.rollbackTransaction(conn);
            e.printStackTrace();
        } finally {
            DButil.endTransaction(conn);
            DButil.close(conn,null,null);
        }
        return en;
    }
}
