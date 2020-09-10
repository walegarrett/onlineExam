package com.wale.exam.dao;

import com.wale.exam.bean.Paper;
import com.wale.exam.bean.PaperExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface PaperMapper {
    long countByExample(PaperExample example);

    int deleteByExample(PaperExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Paper record);

    int insertSelective(Paper record);

    List<Paper> selectByExample(PaperExample example);
    List<Paper> selectByExampleAndPage(@Param("example") PaperExample example, @Param("before") int before,@Param("after") int after);
    Paper selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Paper record, @Param("example") PaperExample example);

    int updateByExample(@Param("record") Paper record, @Param("example") PaperExample example);

    int updateByPrimaryKeySelective(Paper record);

    int updateByPrimaryKey(Paper record);

    int selectLastRecordByCreaterId(PaperExample paperExample);
}
