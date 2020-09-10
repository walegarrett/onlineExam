package com.wale.exam.controller;

import com.github.pagehelper.PageInfo;
import com.wale.exam.bean.Answer;
import com.wale.exam.bean.Msg;
import com.wale.exam.bean.Sheet;
import com.wale.exam.service.AnswerService;
import com.wale.exam.util.MyPageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * @Author WaleGarrett
 * @Date 2020/8/11 12:57
 */
@Controller
public class AnswerController {

    @Autowired
    AnswerService answerService;

    /**
     * 更新或者插入每一题的答案，用于考试提交每一题的答案
     * @param questionId
     * @param answer
     * @param paperId
     * @param session
     * @return
     */
    @RequestMapping("/insertOrUpdateAnswer")
    @ResponseBody
    public Msg insertOrUpdateAnswer(Integer userId, Integer questionId, String answer, Integer paperId, HttpSession session){
        System.out.println(userId+" "+questionId+" "+paperId+" "+answer);
        int kind=answerService.insertOrUpdateAnswer(userId,questionId,paperId,answer);
        //1-插入，2-更新，0-失败

        Msg msg=new Msg();
        msg.setCode(100);//成功
        if(kind==0)
            msg.setMsg("提交答案失败，服务器异常！！！");
        else if(kind==1)
            msg.setMsg("插入新记录。");
        else msg.setMsg("更新记录。");
        return msg;
    }

    /**
     * 用于判卷提交每一题的分数
     * @param userId
     * @param questionId
     * @param score
     * @param paperId
     * @param session
     * @return
     */
    @RequestMapping("/insertOrUpdateAnswerSheet")
    @ResponseBody
    public Msg insertOrUpdateAnswerSheet(Integer userId, Integer questionId, Integer score, Integer paperId, HttpSession session){
        System.out.println(userId+" "+questionId+" "+paperId+" "+score);
        int kind=answerService.insertOrUpdateAnswerSheet(userId,questionId,paperId,score);
        int totalScore=answerService.computeTotalScore(userId,paperId);
        //1-插入，2-更新，0-失败
        Msg msg=new Msg();
        msg.setCode(100);//成功
        if(kind==0)
            msg.setMsg("提交分数失败，服务器异常！！！");
        else if(kind==1)
            msg.setMsg("插入新记录。");
        else msg.setMsg("更新记录。");
        msg.add("totalScore",totalScore);
        return msg;
    }

    /**
     * 找到自己的所有错题记录
     * @param pn
     * @param userId
     * @param session
     * @return
     */
    @RequestMapping("/findAllWrongAnswerOfUser")
    @ResponseBody//记得一定要加上这个注解
    public Msg findAllWrongAnswerOfUser(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Integer userId, HttpSession session){
        List<Answer>list=new ArrayList<>();
        list=answerService.findAllWrongAnswerOfUser(userId);
        //分页信息
        PageInfo page= MyPageInfo.getPageInfo(pn,4,list);
        return Msg.success().add("pageInfo",page).add("answerlist",list);
    }
}
