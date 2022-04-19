package Service;

import bean.Auth;

import java.util.Map;

public interface AuthService {

    boolean saveAuth(Map<String,String> authMap);

    Auth findByAuthno(String authno);

    boolean feedback(String authno);
}
