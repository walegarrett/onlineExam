package com.wale.exam.service.impl;

import com.wale.exam.bean.User;
import com.wale.exam.bean.UserExample;
import com.wale.exam.dao.UserMapper;
import com.wale.exam.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * @Author WaleGarrett
 * @Date 2020/8/6 21:28
 */
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    UserMapper userMapper;

    @Override
    public User login(String username, String pwd) {
        User user=new User();
        UserExample userExample = new UserExample();
        userExample.or();
        userExample.or().andUserNameEqualTo(username).andPasswordEqualTo(pwd);
        List<User> result=userMapper.selectByExample(userExample);
        if (result.size()>0)
            user=result.get(0);
        else
            user=null;
        return user;
    }

    @Override
    public User getUserByname(String username) {
        User user=new User();
        UserExample userExample = new UserExample();
        userExample.or();
        userExample.or().andUserNameEqualTo(username);
        List<User> result=userMapper.selectByExample(userExample);
        if (result.size()>0)
            user=result.get(0);
        else
            user=null;
        return user;
    }

    @Override
    public void addUser(User user) {
        userMapper.insertSelective(user);
    }

    @Override
    public User findUserByUserId(int userid) {

        return userMapper.selectByPrimaryKey(userid);
    }


    @Override
    public List<User> findUserPage(String keyword, int before, int after) {
        UserExample userExample=new UserExample();
        UserExample.Criteria criteria=userExample.createCriteria();
        criteria.andIdIsNotNull();
        criteria.andRoleNotEqualTo(3);//除了管理员
        if(keyword!=null){
            criteria.andUserNameLike("%"+keyword+"%");
        }
        return userMapper.selectByExamplePage(userExample,before,after);
    }

    @Override
    public int findUserCount(String keyword) {
        UserExample userExample=new UserExample();
        UserExample.Criteria criteria=userExample.createCriteria();
        criteria.andIdIsNotNull();
        criteria.andRoleNotEqualTo(3);//除了管理员
        if(keyword!=null){
            criteria.andUserNameLike("%"+keyword+"%");
        }
        List<User>list=userMapper.selectByExample(userExample);
        return list.size();
    }

    @Override
    public List<User> findAllUser() {
        UserExample userExample=new UserExample();
        UserExample.Criteria criteria=userExample.createCriteria();
        criteria.andIdIsNotNull();
        userExample.setOrderByClause("create_time desc");
        return userMapper.selectByExample(userExample);
    }

    @Override
    public void updateUser(User user) {
        userMapper.updateByPrimaryKeySelective(user);
    }

    @Override
    public void deleteUser(Integer userId) {
        userMapper.deleteByPrimaryKey(userId);
    }

    @Override
    public int findAllUserCount() {
        UserExample userExample=new UserExample();
        UserExample.Criteria criteria=userExample.createCriteria();
        criteria.andIdIsNotNull();
        List<User>list=userMapper.selectByExample(userExample);
        if(list==null)
            return 0;
        return list.size();
    }

    @Override
    public List<Integer> findDateList() {
        UserExample userExample=new UserExample();
        UserExample.Criteria criteria=userExample.createCriteria();
        criteria.andIdIsNotNull();
        List<User>list=userMapper.selectByExample(userExample);
        int []num={0,0,0,0,0,0,0};
        for(User user:list){
            Date time=user.getCreateTime();
            Calendar cal = Calendar.getInstance();
            cal.setTime(time);
            int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
            if (w < 0)
                w = 0;
            num[w]++;
        }
        List<Integer> integerList=new ArrayList<>();
        for(int i=0;i<num.length;i++){
            integerList.add(num[i]);
        }
        return integerList;
    }

    @Override
    public void changeHeadPic(int uid, String filename) {
        UserExample userExample=new UserExample();
        userExample.or();
        userExample.or().andIdEqualTo(uid);
        User user=new User();
        user.setId(uid);
        user.setImagePath("/onlineExam/statics/images/upload/"+filename);
        userMapper.updateByExampleSelective(user,userExample);
    }

    @Override
    public User findUserByUserNameAndPassword(String username, String password) {
        UserExample userExample=new UserExample();
        UserExample.Criteria criteria=userExample.createCriteria();
        criteria.andUserNameEqualTo(username);
        criteria.andPasswordEqualTo(password);
        List<User>list=userMapper.selectByExample(userExample);
        if(list==null||list.size()==0)
            return null;
        else return list.get(0);
    }

    @Override
    public List<User> searchUserByKeyword(String field, String keyword) {
        UserExample userExample=new UserExample();
        UserExample.Criteria criteria=userExample.createCriteria();
        if(field.equals("account")){
            criteria.andUserNameLike("%"+keyword+"%");
        }else{
            criteria.andRealNameLike("%"+keyword+"%");
        }
        List<User>list=userMapper.selectByExample(userExample);
        return list;
    }
}
