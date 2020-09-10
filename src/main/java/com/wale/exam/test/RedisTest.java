package com.wale.exam.test;

import com.wale.exam.util.RedisUtil;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * @Author WaleGarrett
 * @Date 2020/9/4 22:50
 * 用于测试redis是否可以正常进行访问和数据的存取
 */
@ContextConfiguration("classpath:applicationContext.xml")
@RunWith(SpringJUnit4ClassRunner.class)
public class RedisTest {
    @Test
    public void testRedis(){
        RedisUtil.setString("hello","helloworld");
        System.out.println(RedisUtil.getString("hello"));
    }
}
