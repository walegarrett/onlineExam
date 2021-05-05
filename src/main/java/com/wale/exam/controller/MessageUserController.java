package com.wale.exam.controller;

import com.github.pagehelper.PageInfo;
import com.wale.exam.bean.*;
import com.wale.exam.service.MessageService;
import com.wale.exam.service.MessageUserService;
import com.wale.exam.util.MyPageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @Author WaleGarrett
 * @Date 2020/8/15 18:05
 */
@Controller
public class MessageUserController {
    @Autowired
    MessageUserService messageUserService;
    @Autowired
    MessageService messageService;
    @RequestMapping("/toReadMessage")
    public String getPerfectMains(@RequestParam("userId")Integer userId, Model model, HttpSession session){

        return "readMessage";
    }

    /**
     * 找到该用户未读消息的条数
     * @param userId
     * @param model
     * @param session
     * @return
     */
    @RequestMapping("/findNoReadCount")
    @ResponseBody
    public Msg findNoReadCount(@RequestParam("userId")Integer userId, Model model, HttpSession session){
        int receiveUserId=userId;
        List<MessageUser> messageUserList=messageUserService.findNoReadItemByReceiveUserId(receiveUserId);
        int noReadMessageCount=messageUserList.size();
        return Msg.success().add("noReadCount",noReadMessageCount);
    }

    /**
     * 更新该条消息的状态为已读
     * @param userId
     * @param messageId
     * @param messageUserId
     * @param model
     * @param session
     * @return
     */
    @RequestMapping("/updateReadStatus")
    @ResponseBody
    public Msg updateReadStatus(@RequestParam("userId")Integer userId, Integer messageId, Integer messageUserId, Model model, HttpSession session){
        MessageUser messageUser=messageUserService.findItemByMessageUserId(messageUserId);
        if(!messageUser.getReaded()){//如果未读
            messageUser.setReaded(true);
            messageUser.setReadTime(new Date());
            messageUserService.updateItem(messageUser);
            Message message=messageService.findMessageByMessageId(messageId);
            message.setReadCount(message.getReadCount()+1);
            messageService.updateMessage(message);
        }
        return Msg.success();
    }

    /**
     * 找到所有的某个用户收到的消息
     * @param pn
     * @param userId
     * @param session
     * @return
     */
    @RequestMapping("/findAllMessageOfReceiver")
    @ResponseBody//记得一定要加上这个注解
    public Msg findAllMessageOfReceiver(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Integer userId, HttpSession session){
        List<MessageUser>list=new ArrayList<>();
        int receiveUserId=userId;
        list=messageUserService.findItemByReceiveUserId(receiveUserId);
        System.out.println("消息数量："+list.size());
        //分页信息
        PageInfo page= MyPageInfo.getPageInfo(pn,10,list);
        return Msg.success().add("pageInfo",page);
    }
    /**
     * test-找到所有的某个用户收到的消息
     * @param pn
     * @param userId
     * @param session
     * @return
     */
    @RequestMapping("/testFindAllMessageOfReceiver")
    @ResponseBody//记得一定要加上这个注解
    public Msg testFindAllMessageOfReceiver(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Integer userId, HttpSession session){
        List<MessageUser>list=new ArrayList<>();
        int receiveUserId=userId;
        list=messageUserService.findItemByReceiveUserId(receiveUserId);
        System.out.println("消息数量："+list.size());
        //分页信息
        PageInfo page= MyPageInfo.getPageInfo(pn,10,list);
        return Msg.success().add("pageInfo",page);
    }
}
