package com.wale.exam.service;

import com.wale.exam.bean.Paper;
import com.wale.exam.bean.Problem;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author WaleGarrett
 * @Date 2020/8/9 10:20
 */
@Service
public interface ProblemService {
    int findProblemCountByTeaId(Integer teacherId);

    List<Problem> findProblemByTeaId(Integer teacherId, int before, int after);

    void addProblem(Problem problem);

    int findScoreByProId(int proId);

    List<Problem> findProblemByPaperIdAndType(Integer paperId, int i,Integer userid);

    Problem findProblemByProblemId(int problemId);

    void updateProblem(Problem problem);

    List<Problem> findAllProblem();

    int findAllProblemCount();

    int findAllProblemCountWithTeacherId(int userid);

    List<Problem> searchProblem(Integer teacherId, Integer id, Integer type, int before, int after);

    int searchProblemCount(Integer teacherId, Integer id, Integer type);

    void deleteProblem(Integer problemId);
    int findProblemCountByTeaId(Integer teacherId,String keyword);

    List<Problem> findProblemByTeaId(Integer teacherId, String keyword, int before, int after);

    List<Problem> findProblemsWithKeyword(String field, String keyword);

    void deleteBatch(List<Integer> del_ids);

    List<Problem> findProblemByPaperIdAndType(Integer paperId, int i);
}
