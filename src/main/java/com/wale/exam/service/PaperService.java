package com.wale.exam.service;

import com.wale.exam.bean.Paper;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author WaleGarrett
 * @Date 2020/8/8 9:30
 */
@Service
public interface PaperService {
    List<Paper> findPaperByTeaId(Integer teacherId, int before, int after);

    int findPaperCountByTeaId(Integer teacherId);

    void addPaperWithoutProblems(Paper paper);

    int findLastRecordByCreaterId(Integer teacherId);

    List<Paper> findAllPapers();

    Paper findPaperByPaperId(Integer paperId);

    List<Paper> findPaperByCreaterId(Integer teacherId);

    List<Paper> findAllPapersWithUser(Integer userId);

    List<Paper> findAllPapersWithUserNotStart(int userId);

    List<Paper> findAllPapersWithUserHasEnd(int userId);

    List<Paper> findAllPapersWithUserDuring(int userId);

    List<Paper> findAllPapersWithUserHasDone(int userId);

    void updatePaper(Paper paper, String problems);

    List<Paper> findAllPaper();

    void updatePaper(Paper paper);

    void deletePaper(Integer paperId);

    int findAllPaperCount();

    List<Integer> findPaperList();

    int findAllPaperCountWithTeacherId(int userid);

    List<Integer> findPaperListWithTeacherId(int userid);

    List<Paper> findAllPaperWithNoEncry();

    List<Paper> searchPaper(Integer teacherId, Integer id, String title, int before, int after);

    int searchPaperCount(Integer teacherId, Integer id, String title);

    List<Paper> findPaperByCreaterIdBlur(Integer teacherId, String paperName);

    List<Paper> findPaperWithKeyword(String field,String keyword);

    List<Paper> findHottestPaper();
}
