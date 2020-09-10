package com.wale.exam.dao;

import com.wale.exam.bean.Sheet;
import com.wale.exam.bean.SheetExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface SheetMapper {
    long countByExample(SheetExample example);

    int deleteByExample(SheetExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Sheet record);

    int insertSelective(Sheet record);

    List<Sheet> selectByExample(SheetExample example);

    Sheet selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Sheet record, @Param("example") SheetExample example);

    int updateByExample(@Param("record") Sheet record, @Param("example") SheetExample example);

    int updateByPrimaryKeySelective(Sheet record);

    int updateByPrimaryKey(Sheet record);
}