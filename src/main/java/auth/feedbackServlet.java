package auth;

import Service.AuthService;
import ServiceImpl.AuthServiceImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class feedbackServlet extends HttpServlet {
    private AuthService authService = new AuthServiceImpl();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String authno=request.getParameter("authno");
        boolean ok=authService.feedback(authno);
        if (ok){
            response.sendRedirect("authresponse/authResponseList.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
