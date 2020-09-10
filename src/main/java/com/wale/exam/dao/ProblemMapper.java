package com.wale.exam.dao;

import com.wale.exam.bean.Paper;
import com.wale.exam.bean.Problem;
import com.wale.exam.bean.ProblemExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ProblemMapper {
    long countByExample(ProblemExample example);

    int deleteByExample(ProblemExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Problem record);

    int insertSelective(Problem record);

    List<Problem> selectByExampleWithBLOBs(ProblemExample example);

    List<Problem> selectByExample(ProblemExample example);

    Problem selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Problem record, @Param("example") ProblemExample example);

    int updateByExampleWithBLOBs(@Param("record") Problem record, @Param("example") ProblemExample example);

    int updateByExample(@Param("record") Problem record, @Param("example") ProblemExample example);

    int updateByPrimaryKeySelective(Problem record);

    int updateByPrimaryKeyWithBLOBs(Problem record);

    int updateByPrimaryKey(Problem record);

    List<Problem> selectByExampleAndPage(@Param("example") ProblemExample problemExample, @Param("before") int before, @Param("after") int after);

    List<Problem> selectByExampleWithBLOBsAndPage(@Param("example") ProblemExample problemExample, @Param("before") int before, @Param("after") int after);
}
