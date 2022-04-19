package Dao;

import entity.User;

public interface UserDao {

    /*根据用户代码查询用户信息*/
    User selectByUsercode(String usercide);

    /*保存用户信息一条*/
    int insert(User user);
}
