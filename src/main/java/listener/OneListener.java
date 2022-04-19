package listener;

import Util.DButil;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class OneListener implements ServletContextListener {
    //在Tomcat启动时，预先创建20个Connection，在userDao.add方法执行时
    //将实现创建好conncetion交给add方法
    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        DButil util=new DButil();
        Map map=new HashMap();
        for(int i=1;i<=20;i++){
            Connection conn=util.getConn();
            System.out.println("在Http服务器启动时，创建Connection"+conn);
            map.put(conn,true);//true表示这个通道处于空闲状态，false通道正在被使用
        }
        //为了在Http服务器运行期间，一直可以使用20个Connection，将connection保存
        //到全局作用域对象中
        ServletContext application=servletContextEvent.getServletContext();
        application.setAttribute("key1",map);
    }//map被销毁
//在Http服务器关闭时刻,将全局作用域对象20个Connection销毁
    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
            ServletContext application=servletContextEvent.getServletContext();
            Map map=(Map) application.getAttribute("key1");
        Iterator it=map.keySet().iterator();
        while(it.hasNext()){
            Connection conn=(Connection) it.next();
            if(conn!=null){
                System.out.println("兄弟们，我"+conn+"走了！");
            }
        }
    }
}
