package com.wale.exam.dao;

import com.wale.exam.bean.MessageUser;
import com.wale.exam.bean.MessageUserExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface MessageUserMapper {
    long countByExample(MessageUserExample example);

    int deleteByExample(MessageUserExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(MessageUser record);

    int insertSelective(MessageUser record);

    List<MessageUser> selectByExample(MessageUserExample example);

    MessageUser selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") MessageUser record, @Param("example") MessageUserExample example);

    int updateByExample(@Param("record") MessageUser record, @Param("example") MessageUserExample example);

    int updateByPrimaryKeySelective(MessageUser record);

    int updateByPrimaryKey(MessageUser record);
}