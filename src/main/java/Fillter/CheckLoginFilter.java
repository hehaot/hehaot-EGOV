package Fillter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class CheckLoginFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request=(HttpServletRequest) servletRequest;
        HttpServletResponse response=(HttpServletResponse) servletResponse;
        //获取访问的ServletPath
        String servletPath=request.getServletPath();
        HttpSession session=request.getSession(false);
        if (".jpg".equals(servletPath)||".gif".equals(servletPath)|| "/login.jsp".equals(servletPath) || "/login".equals(servletPath) || (session!=null && session.getAttribute("user")!=null)){
            filterChain.doFilter(request,response);
        }else{
            response.sendRedirect("/myWeb/");
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void destroy() {

    }
}
