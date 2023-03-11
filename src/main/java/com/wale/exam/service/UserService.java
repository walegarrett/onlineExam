package com.wale.exam.service;

import com.wale.exam.bean.User;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author WaleGarrett
 * @Date 2020/8/6 21:29
 */
@Service
public interface UserService {
    User login(String userName, String passWord);

    User getUserByname(String username);

    void addUser(User user);

    User findUserByUserId(int userid);

    List<User> findUserPage(String keyword, int before, int after);

    int findUserCount(String keyword);

    List<User> findAllUser();

    void updateUser(User user);

    void deleteUser(Integer userId);

    int findAllUserCount();

    List<Integer> findDateList();

    void changeHeadPic(int uid, String filename);

    User findUserByUserNameAndPassword(String username, String password);

    List<User> searchUserByKeyword(String field, String keyword);

    void deleteBatch(List<Integer> del_ids);
}
