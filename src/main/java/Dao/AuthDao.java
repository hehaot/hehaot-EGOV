package Dao;

import bean.Auth;

import java.util.Map;

public interface AuthDao {
    int insertAuth(Map<String,String> authMap);
    Auth selectByAuthno(String authno);

    int update(String authno);
}
