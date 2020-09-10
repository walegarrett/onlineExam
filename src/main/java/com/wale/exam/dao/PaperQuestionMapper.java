package com.wale.exam.dao;

import com.wale.exam.bean.PaperQuestion;
import com.wale.exam.bean.PaperQuestionExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface PaperQuestionMapper {
    long countByExample(PaperQuestionExample example);

    int deleteByExample(PaperQuestionExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(PaperQuestion record);

    int insertSelective(PaperQuestion record);

    List<PaperQuestion> selectByExample(PaperQuestionExample example);

    PaperQuestion selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") PaperQuestion record, @Param("example") PaperQuestionExample example);

    int updateByExample(@Param("record") PaperQuestion record, @Param("example") PaperQuestionExample example);

    int updateByPrimaryKeySelective(PaperQuestion record);

    int updateByPrimaryKey(PaperQuestion record);
}