package Util;

import bean.Investor;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Enumeration;
import java.util.Locale;

/*Web工具类
 * */
public class WebUtil {
    /*
     *要想使用以下工具方法有前提：
     *       --javabean的属性类型需要是String类型
     *       --必须保证javabean的属性名和网页表单中的input标签的name属性值相同
     *
     * 将request对象中存储的表单数据设置到javabean对象中
     * request 含有表单数据的请求对象
     * obj javabean对象
     * */
    public static void makeRequestToObject(HttpServletRequest request, Object obj) {
        //用反射完成servelt中获取表单的数据

        //获取整个Javabean类的字节码
        Class c = obj.getClass();

        //获取表单中所有input标签name属性的值（等同于已经获取了javabean中所有的属性名）
        Enumeration<String> fieldNames = request.getParameterNames();

        while (fieldNames.hasMoreElements()) {

            //获取属性名
            String fieldName = fieldNames.nextElement();

            //获取方法名
            String methodName = "set" + fieldName.toUpperCase().charAt(0) + fieldName.substring(1);

            try {
                //获取要调用的方法
                Method setMethod = c.getDeclaredMethod(methodName, String.class);

                //调用set方法
                setMethod.invoke(obj, request.getParameter(fieldName));
            } catch (Exception e) {
                //e.printStackTrace();
            }
        }
    }
}
