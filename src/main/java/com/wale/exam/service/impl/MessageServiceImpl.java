package com.wale.exam.service.impl;

import com.wale.exam.bean.Message;
import com.wale.exam.bean.MessageExample;
import com.wale.exam.bean.MessageUser;
import com.wale.exam.bean.User;
import com.wale.exam.dao.MessageMapper;
import com.wale.exam.service.MessageService;
import com.wale.exam.service.MessageUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @Author WaleGarrett
 * @Date 2020/8/15 12:31
 */
@Service
public class MessageServiceImpl implements MessageService {
    @Autowired
    MessageMapper messageMapper;
    @Autowired
    MessageUserService messageUserService;
    /**
     * 找到发送人发送的所有消息
     * @param sendUserId
     * @param before
     * @param after
     * @return
     */
    @Override
    public List<Message> findMessageBySendUserId(Integer sendUserId, int before, int after) {
        MessageExample messageExample=new MessageExample();
        MessageExample.Criteria criteria=messageExample.createCriteria();
        criteria.andSendUserIdEqualTo(sendUserId);
        List<Message>list= messageMapper.selectByExampleWithPage(messageExample,before,after);
        List<Message>messageList=new ArrayList<>();
        for(Message message:list){
            Integer messageId=message.getId();
            List<MessageUser>messageUserList=messageUserService.findItemByMessageId(messageId);
            String recevierAccounts="";
            for(MessageUser messageUser:messageUserList){
                recevierAccounts+=messageUser.getReceiveUserName();
                recevierAccounts+=",";
            }
            message.setReceiverAccounts(recevierAccounts.substring(0,recevierAccounts.length()-1));
            messageList.add(message);
        }
        return messageList;
    }

    @Override
    public int findMessageCountBySendUserId(Integer sendUserId) {
        MessageExample messageExample=new MessageExample();
        MessageExample.Criteria criteria=messageExample.createCriteria();
        criteria.andSendUserIdEqualTo(sendUserId);
        List<Message>list=messageMapper.selectByExample(messageExample);
        return list.size();
    }

    @Override
    public void addMessage(Message message) {
        messageMapper.insertSelective(message);
    }

    @Override
    public int findLatestRecordMessageId() {
        List<Message>list=new ArrayList<>();
        MessageExample messageExample=new MessageExample();
        MessageExample.Criteria criteria=messageExample.createCriteria();
        criteria.andIdIsNotNull();
        list=messageMapper.selectByExample(messageExample);
        Message message=list.get(list.size()-1);
        return message.getId();
    }

    @Override
    public Message findMessageByMessageId(int messageId) {
        return messageMapper.selectByPrimaryKey(messageId);
    }

    @Override
    public void updateMessage(Message message) {
        messageMapper.updateByPrimaryKeySelective(message);
    }

    @Override
    public List<Message> findAllMessage() {
        MessageExample messageExample=new MessageExample();
        MessageExample.Criteria criteria=messageExample.createCriteria();
        criteria.andIdIsNotNull();
        messageExample.setOrderByClause("create_time desc");
        List<Message>list= messageMapper.selectByExample(messageExample);
        List<Message>messageList=new ArrayList<>();
        for(Message message:list){
            Integer messageId=message.getId();
            List<MessageUser>messageUserList=messageUserService.findItemByMessageId(messageId);
            String recevierAccounts="";
            for(MessageUser messageUser:messageUserList){
                recevierAccounts+=messageUser.getReceiveUserName();
                recevierAccounts+=",";
            }
            message.setReceiverAccounts(recevierAccounts.substring(0,recevierAccounts.length()-1));
            messageList.add(message);
        }
        return messageList;
    }

    @Override
    public void deleteMessage(Integer messageId) {
        messageMapper.deleteByPrimaryKey(messageId);
    }

    @Override
    public int findAllMessageCount() {
        MessageExample messageExample=new MessageExample();
        MessageExample.Criteria criteria=messageExample.createCriteria();
        criteria.andIdIsNotNull();
        List<Message>list=messageMapper.selectByExample(messageExample);
        if(list==null)
            list=new ArrayList<>();
        return list.size();
    }

    @Override
    public int findAllMessageCountWithTeacherId(int userid) {
        MessageExample messageExample=new MessageExample();
        MessageExample.Criteria criteria=messageExample.createCriteria();
        criteria.andIdIsNotNull();
        criteria.andSendUserIdEqualTo(userid);
        List<Message>list=messageMapper.selectByExample(messageExample);
        if(list==null)
            list=new ArrayList<>();
        return list.size();
    }

    /**
     * 批量删除
     * @param del_ids
     */
    @Override
    public void deleteBatch(List<Integer> del_ids) {
        MessageExample messageExample=new MessageExample();
        MessageExample.Criteria criteria=messageExample.createCriteria();
        criteria.andIdIn(del_ids);
        messageMapper.deleteByExample(messageExample);
    }
}
