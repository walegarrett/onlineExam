package com.wale.exam.controller;

import com.wale.exam.bean.*;
import com.wale.exam.service.MessageService;
import com.wale.exam.service.MessageUserService;
import com.wale.exam.service.UserService;
import com.wale.exam.util.JsonDateValueProcessor;
import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @Author WaleGarrett
 * @Date 2020/8/15 12:28
 */
@Controller
public class MessageController {
    @Autowired
    MessageService messageService;
    @Autowired
    UserService userService;
    @Autowired
    MessageUserService messageUserService;

    /**
     * 找到所有该发送者发送的用户
     * @param sendUserId
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping(value="/findAllMessageByUserId",produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public String findAllMessageByUserId(@RequestParam("sendUserId")Integer sendUserId, int page, int limit){
        System.out.println(sendUserId+" "+page+" "+limit);
        int before = limit * (page - 1);
        int after = limit;//page * limit
        //带参数从数据库里查询出来放到eilist的集合里
        List<Message> eilist = messageService.findMessageBySendUserId(sendUserId,before, after);
//        System.out.println(eilist.size());
        int count = messageService.findMessageCountBySendUserId(sendUserId);
        //用json来传值
        JsonConfig jsonConfig = new JsonConfig();
        jsonConfig.registerJsonValueProcessor(Date.class , new JsonDateValueProcessor());
        JSONArray json = JSONArray.fromObject(eilist, jsonConfig);
        String js = json.toString();
        //*****转为layui需要的json格式，必须要这一步，博主也是没写这一步，在页面上数据就是数据接口异常
        String jso = "{\"code\":0,\"msg\":\"\",\"count\":"+count+",\"data\":"+js+"}";
        System.out.println(jso);
        return jso;
    }
    /**
     * 删除消息
     * @param messageId
     * @param session
     * @return
     */
    @RequestMapping("/deleteMessage")
    @ResponseBody//记得一定要加上这个注解
    public Msg deleteMessage(String messageId, HttpSession session){
        System.out.println("删除消息"+messageId);
        if(messageId.contains("-")){
            String[] str_ids=messageId.split("-");
            //组装ids的数组
            List<Integer> del_ids=new ArrayList<>();
            for(String string:str_ids){
                del_ids.add(Integer.parseInt(string));
            }
            messageService.deleteBatch(del_ids);
        }else{
            //删除单个记录
            Integer id=Integer.parseInt(messageId);
            messageService.deleteMessage(id);
        }
        return Msg.success();
    }
    @RequestMapping("/addMessage")
    @ResponseBody
    public Msg addMessage(Integer sendUserId, String title, String content, String receivers, HttpSession session) throws ParseException {
        System.out.println("新增消息："+sendUserId+" "+title+" "+content+" "+receivers);
        Map<String,Object> map=new HashMap<>();//用来存储错误的字段
        Message message=new Message();
        message.setCreateTime(new Date());
        message.setTitle(title);
        message.setContent(content);
        message.setSendUserId(sendUserId);
        User user=userService.findUserByUserId(sendUserId);
        message.setSendUserName(user.getUserName());
        message.setSendRealName(user.getRealName());
        message.setReadCount(0);
        String[] receiverIds = receivers.trim().split(",");
        int receiverCount=receiverIds.length;//接受者的数量
        message.setReceiveUserCount(receiverCount);
        //新建消息
        messageService.addMessage(message);
        //获取刚刚新建的消息的id
        int messageId=messageService.findLatestRecordMessageId();
        for(String item:receiverIds){
            int userId=Integer.parseInt(item);
            User usera=userService.findUserByUserId(userId);
            MessageUser messageUser=new MessageUser();
            messageUser.setCreateTime(new Date());
            messageUser.setMessageId(messageId);
            messageUser.setReaded(false);
            messageUser.setReceiveUserId(userId);
            messageUser.setReceiveRealName(usera.getRealName());
            messageUser.setReceiveUserName(usera.getUserName());
            messageUserService.addItem(messageUser);//插入
        }
        return Msg.success();
    }
    @RequestMapping(value="/searchMessage",produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public String searchMessage(String title, String content, Integer teacherId,int page, int limit){
        System.out.println(title+" "+content+" "+page+" "+limit);
        int before = limit * (page - 1);
        int after = limit;//page * limit

        //带参数从数据库里查询出来放到eilist的集合里
        List<Message> eilist = messageService.searchMessage(teacherId, title,content,before, after);
        int count = messageService.searchMessageCount(teacherId, title,content);
        //用json来传值
        JsonConfig jsonConfig = new JsonConfig();
        jsonConfig.registerJsonValueProcessor(Date.class , new JsonDateValueProcessor());

        JSONArray json = JSONArray.fromObject(eilist, jsonConfig);
        String js = json.toString();
        //*****转为layui需要的json格式，必须要这一步，博主也是没写这一步，在页面上数据就是数据接口异常
        String jso = "{\"code\":0,\"msg\":\"\",\"count\":"+count+",\"data\":"+js+"}";
        return jso;
    }
}
