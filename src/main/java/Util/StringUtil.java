package Util;

import java.util.ResourceBundle;

public class StringUtil {
    /*工具类的构造方法都是私有化的
    * */

    private StringUtil() {
    }

    private static ResourceBundle bundle=ResourceBundle.getBundle("Message");
    public static String getTextBycode(String code){
        return bundle.getString(code);
    }
    /*判断字符串是否为空
    * string 字符串
    * true表示不为空，false表示为空*/
    public static boolean isNotEmpty(String string){
        return string != null && string.trim().length() !=0;
    }
}
