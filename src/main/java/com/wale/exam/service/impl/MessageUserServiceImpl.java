package com.wale.exam.service.impl;

import com.wale.exam.bean.Message;
import com.wale.exam.bean.MessageUser;
import com.wale.exam.bean.MessageUserExample;
import com.wale.exam.dao.MessageUserMapper;
import com.wale.exam.service.MessageService;
import com.wale.exam.service.MessageUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @Author WaleGarrett
 * @Date 2020/8/15 16:59
 */
@Service
public class MessageUserServiceImpl implements MessageUserService {
    @Autowired
    MessageUserMapper messageUserMapper;
    @Autowired
    MessageService messageService;
    @Override
    public void addItem(MessageUser messageUser) {
        messageUserMapper.insertSelective(messageUser);
    }

    @Override
    public List<MessageUser> findItemByMessageId(Integer messageId) {
        MessageUserExample messageUserExample=new MessageUserExample();
        MessageUserExample.Criteria criteria=messageUserExample.createCriteria();
        criteria.andMessageIdEqualTo(messageId);
        return messageUserMapper.selectByExample(messageUserExample);
    }

    @Override
    public List<MessageUser> findItemByReceiveUserId(int receiveUserId) {
        MessageUserExample messageUserExample=new MessageUserExample();
        MessageUserExample.Criteria criteria=messageUserExample.createCriteria();
        criteria.andReceiveUserIdEqualTo(receiveUserId);
        List<MessageUser>list=messageUserMapper.selectByExample(messageUserExample);
        List<MessageUser>messageUserList=new ArrayList<>();
        for(MessageUser messageUser:list){
            int messageId=messageUser.getMessageId();
            Message message=messageService.findMessageByMessageId(messageId);
            messageUser.setMessage(message);
            messageUserList.add(messageUser);
        }
        return messageUserList;
    }

    @Override
    public List<MessageUser> findNoReadItemByReceiveUserId(int receiveUserId) {
        MessageUserExample messageUserExample=new MessageUserExample();
        MessageUserExample.Criteria criteria=messageUserExample.createCriteria();
        criteria.andReceiveUserIdEqualTo(receiveUserId);
        criteria.andReadedEqualTo(false);//未读消息的
        return messageUserMapper.selectByExample(messageUserExample);    }

    @Override
    public MessageUser findItemByMessageUserId(Integer messageUserId) {
        return messageUserMapper.selectByPrimaryKey(messageUserId);
    }

    @Override
    public void updateItem(MessageUser messageUser) {
        messageUserMapper.updateByPrimaryKeySelective(messageUser);
    }
}
