package com.wale.exam.service;

import com.wale.exam.bean.Paper;
import com.wale.exam.bean.Sheet;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @Author WaleGarrett
 * @Date 2020/8/11 15:37
 */
@Service
public interface SheetService {
    void addSheet(Integer userId, Integer paperId);

    List<Sheet> findSheetByTeaId(Integer teacherId, int before, int after);

    int findSheetCountByTeaId(Integer teacherId);

    Sheet findSheetById(Integer sheetId);


    void addSheetJudge(Integer userId, Integer paperId, Integer score, String comment);

    List<Sheet> findSheetByUserIdAndPaperId(Integer userId, Integer paperId);

    List<Sheet> findSheetByUserId(int userId);

    List<Sheet> findAllSheetsWithUserHasDone(int userId);

    List<Sheet> findJudgedSheetByTeaId(Integer teacherId, int before, int after);

    int findJudgedSheetCountByTeaId(Integer teacherId);

    void deleteSheetByPaperId(Integer paperId);

    List<Sheet> findAllSheetWithJudged();

    Sheet findSheetBySheetId(Integer sheetId);

    void updateSheet(Sheet sheet);

    int findAllJudgedCountWithTeacherId(int userid);

    List<Sheet> searchJudge(Integer sheetId, String paperName, String userName, Integer teacherId, int before, int after);

    int searchJudgeCount(Integer sheetId, String paperName, String userName, Integer teacherId);

    List<Sheet> searchGrade(Integer sheetId, String paperName, String userName, Integer teacherId, int before, int after);

    int searchGradeCount(Integer sheetId, String paperName, String userName, Integer teacherId);

    boolean checkIsAnbswered(Integer userId, Integer paperId);

    List<Sheet> findSheetWithJudgedAndKeyword(String field, String keyword);

    Map<Integer, Integer> findHottestPaperInSheets();

    List<Sheet> findAllSheet();

    List<Sheet> findSheetWithKeyword(String field, String keyword);

    void deleteSheet(Integer sheetId);
}
