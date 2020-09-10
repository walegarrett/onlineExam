package com.wale.exam.service;

import com.wale.exam.bean.MessageUser;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author WaleGarrett
 * @Date 2020/8/15 16:59
 */
@Service
public interface MessageUserService {
    void addItem(MessageUser messageUser);

    List<MessageUser> findItemByMessageId(Integer messageId);

    List<MessageUser> findItemByReceiveUserId(int receiveUserId);

    List<MessageUser> findNoReadItemByReceiveUserId(int receiveUserId);

    MessageUser findItemByMessageUserId(Integer messageUserId);

    void updateItem(MessageUser messageUser);
}
