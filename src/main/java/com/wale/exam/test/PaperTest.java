package com.wale.exam.test;

import com.wale.exam.bean.Paper;
import com.wale.exam.dao.PaperMapper;
import com.wale.exam.service.PaperService;
import net.sf.json.JSONArray;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;
import java.util.List;

/**
 * @Author WaleGarrett
 * @Date 2020/8/8 9:29
 */
@ContextConfiguration("classpath:applicationContext.xml")
@RunWith(SpringJUnit4ClassRunner.class)
public class PaperTest {
    @Autowired
    PaperMapper paperMapper;
    @Autowired
    PaperService paperService;
    @Test
    public void addPaperTest(){
        for(int i=0;i<10;i++){
            Paper paper=new Paper();
            paper.setPaperName("教师3创建的第"+i+"套试卷");
            paper.setTotalScore(100);
            paper.setDurationTime(60);
            paper.setCreaterId(3);
            Date create=new Date();
            paper.setCreateTime(create);
            Date start=new Date(create.getTime()+24*60*60*10);
            paper.setStartTime(start);
            Date end=new Date(start.getTime()+60*60*10);
            paper.setEndTime(end);
            paper.setIsEncry(1);//没有邀请码
            paper.setQuestionCount(0);
            paperMapper.insertSelective(paper);
        }
    }
    @Test
    public void testFindPaperPageByTeaId(){
        int before = 3 * (2 - 1) + 1;
        int after = 3;
        //带参数从数据库里查询出来放到eilist的集合里
        List<Paper> eilist = paperService.findPaperByTeaId(2,before, after);
        int count = paperService.findPaperCountByTeaId(2);
        //用json来传值
        JSONArray json = JSONArray.fromObject(eilist);
        String js = json.toString();
        //*****转为layui需要的json格式，必须要这一步，博主也是没写这一步，在页面上数据就是数据接口异常
        String jso = "{\"code\":0,\"msg\":\"\",\"count\":"+count+",\"data\":"+js+"}";
        System.out.println(jso);
    }
}
