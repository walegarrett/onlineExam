package com.wale.exam.service;

import com.wale.exam.bean.Answer;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author WaleGarrett
 * @Date 2020/8/11 13:00
 */
@Service
public interface AnswerService {
    int insertOrUpdateAnswer(Integer userid, Integer questionId, Integer paperId, String answer);

    Answer getAnswerByUserIdAndQuesIdAndPaperId(Integer userid, int questionId, Integer paperId);

    int insertOrUpdateAnswerSheet(Integer userId, Integer questionId, Integer paperId, Integer score);
    Integer computeTotalScore(int userId, int paperId);

    void updateAnswerStatus(Integer userId, Integer paperId);

    List<Answer> findAllWrongAnswerOfUser(Integer userId);

    void deleteAnswerByPaperId(Integer paperId);

    void updateAnswerStatus1(int userid, int paperid);

    void deleteAnswerByPaperIdAndUserId(Integer paperId, Integer userId);

    void updateAnswerStatus1AndOtherInfo(int studentId, int paperId);

    Answer findAnswerByUserProblemPaper(Integer userId, Integer problemId, Integer paperId);

    List<Answer> findAnswerByPaperUser(Integer paperId, Integer userId);
}
