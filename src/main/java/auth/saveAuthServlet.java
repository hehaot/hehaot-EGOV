package auth;

import Service.AuthService;
import ServiceImpl.AuthServiceImpl;
import entity.User;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class saveAuthServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    private AuthService authService = new AuthServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Map<String, String> authMap = new HashMap<String, String>();
        authMap.put("usercode", ((User) (request.getSession(false).getAttribute("user"))).getUsercode());
        //创建硬盘文件条目工厂对象
        DiskFileItemFactory factory = new DiskFileItemFactory();
        //设置服务器“一次”可以接收的最大数据量（如果文件过大，服务器会分多次接收该文件）
        factory.setSizeThreshold(4 * 1024);
        //设置文件的临时存储路径
        String tmpPath = "E:/tempFile";
        factory.setRepository(new File((tmpPath)));
        //创建核心对象
        ServletFileUpload upload = new ServletFileUpload(factory);
        //设置可以接收的最大文件
        upload.setSizeMax(1024 * 1024 * 1024);//1GB
        boolean upfileOk=true;//默认成功了
        String path=null;
        try {
            //核心对象解析请求对象，将请求对象封装成一个一个的FileItem对象，然后将其存储到List集合中
            List<FileItem> fileItems = upload.parseRequest(request);
            String orgcode=null;
            //遍历集合 每次遍历拿出一个普通的表单元素
            for (FileItem fileItem : fileItems) {
                if (fileItem.isFormField()) {
                    String name=fileItem.getFieldName();
                    String value=fileItem.getString("GB18030");
                    authMap.put(name,value);
                    if ("orgcode".equals(name)){
                        orgcode = value;
                    }
                } else {
                    //原文件名
                    String oldFileName=fileItem.getName();
                    //拼接新文件名
                    String newFileName=orgcode+oldFileName.substring((oldFileName.lastIndexOf(".")));

                    authMap.put("filename",newFileName);

                    //获取路径
                    path="E:/upFile/"+newFileName;
                    fileItem.write(new File(path));
                }
            }
        } catch (Exception e) {
            upfileOk=false;//出现异常失败
            e.printStackTrace();
        }
        if (upfileOk){
            boolean saveOk=authService.saveAuth(authMap);
            if (saveOk){
                //保存成功
                response.sendRedirect("auth/inputOrg.jsp");
            }else{
                //保存失败
                File f=new File(path);
                f.delete();
            }
        }
    }
}
