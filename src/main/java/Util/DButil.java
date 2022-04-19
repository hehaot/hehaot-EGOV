package Util;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.sql.*;
import java.util.Iterator;
import java.util.Map;

public class DButil {
    static Connection conn = null;
    static PreparedStatement ps = null;
    /*
     * 放在ThreadLocal中的数据都是线程安全的，一个线程一个链接对象
     * */
    private static ThreadLocal<Connection> threadLocal = new ThreadLocal<Connection>();

    //--------------------------通过全局作用域对象得到Connection------------------------------
    public static Connection getConn(HttpServletRequest request) {



            //1、通过请求对象，得到全局作用域对象
            ServletContext application = request.getServletContext();
            //2、从全局作用域对象中得到map
            Map map = (Map) application.getAttribute("key1");
            //3、从map得到一个处于空闲状态Connection
            Iterator it = map.keySet().iterator();
            while (it.hasNext()) {
                conn = (Connection) it.next();
                boolean flag = (boolean) map.get(conn);
                if (flag == true) {
                    try {
                        conn = getconnection();
                    } catch (SQLException throwables) {
                        throwables.printStackTrace();
                    }
                    map.put(conn, false);

                    break;
                }
            }
        return conn;
    }

    public static PreparedStatement createStatement(String sql, HttpServletRequest request) {
        try {
            ps = getConn(request).prepareStatement(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ps;
    }

    //--------------------------通过全局作用域对象得到Connection------------------------------
    static {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static Connection getconnection() throws SQLException {
        return DriverManager.getConnection("jdbc:sqlserver://127.0.0.1:1433;DatabaseName=EGOV", "sa", "333");
    }

    public static Connection getConn() {

        Connection conn = threadLocal.get();
        if (conn == null) {

            try {
                conn = getconnection();
            } catch (SQLException e) {
                e.printStackTrace();
            }

            threadLocal.set(conn);
        }
        return conn;
    }

    public static PreparedStatement createStatement(String sql) {
        try {
            conn = getconnection();
            ps = conn.prepareStatement(sql);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ps;
    }

    //重载
    public static void close(Statement ps, ResultSet rs, HttpServletRequest request) {
        if (rs != null) {
            try {
                rs.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (ps != null) {
            try {
                ps.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        ServletContext application = request.getServletContext();
        Map map = (Map) application.getAttribute("key1");


        map.put(conn, true);

    }

    public static void close(Statement ps, ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (ps != null) {
            try {
                ps.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }
//MVC版
    public static void close(Connection conn,Statement ps, ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (ps != null) {
            try {
                ps.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
            try {
                //解除绑定
                threadLocal.remove();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }

    //开启事务
    public static void beginTransaction(Connection conn) throws Exception {
        if (conn != null) {
            conn.setAutoCommit(false);
        }
    }

    //提交事务
    public static void commitTransaction(Connection conn) throws Exception {
        if (conn != null) {
            conn.commit();
        }
    }

    //回滚事务
    public static void rollbackTransaction(Connection conn) {
        if (conn != null) {
            try {
                conn.rollback();
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }

    //关闭事务
    public static void endTransaction(Connection conn) {
        if (conn != null) {
            try {
                conn.setAutoCommit(true);
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }
}
