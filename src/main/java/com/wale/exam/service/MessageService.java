package com.wale.exam.service;

import com.wale.exam.bean.Message;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author WaleGarrett
 * @Date 2020/8/15 12:30
 */
@Service
public interface MessageService {
    List<Message> findMessageBySendUserId(Integer sendUserId, int before, int after);

    int findMessageCountBySendUserId(Integer sendUserId);

    void addMessage(Message message);

    int findLatestRecordMessageId();

    Message findMessageByMessageId(int messageId);

    void updateMessage(Message message);

    List<Message> findAllMessage();

    void deleteMessage(Integer messageId);

    int findAllMessageCount();

    int findAllMessageCountWithTeacherId(int userid);
}
