package com.wale.exam.dao;

import com.wale.exam.bean.UserEventLog;
import com.wale.exam.bean.UserEventLogExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface UserEventLogMapper {
    long countByExample(UserEventLogExample example);

    int deleteByExample(UserEventLogExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(UserEventLog record);

    int insertSelective(UserEventLog record);

    List<UserEventLog> selectByExampleWithBLOBs(UserEventLogExample example);

    List<UserEventLog> selectByExample(UserEventLogExample example);

    UserEventLog selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") UserEventLog record, @Param("example") UserEventLogExample example);

    int updateByExampleWithBLOBs(@Param("record") UserEventLog record, @Param("example") UserEventLogExample example);

    int updateByExample(@Param("record") UserEventLog record, @Param("example") UserEventLogExample example);

    int updateByPrimaryKeySelective(UserEventLog record);

    int updateByPrimaryKeyWithBLOBs(UserEventLog record);

    int updateByPrimaryKey(UserEventLog record);
}