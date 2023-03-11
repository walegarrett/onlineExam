package com.wale.exam.service;

import com.wale.exam.bean.PaperQuestion;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author WaleGarrett
 * @Date 2020/8/10 6:40
 */
@Service
public interface PaperQuestionService {
    void addItem(int paperId, int proId);

    List<PaperQuestion> findItemByPaperId(Integer paperId);

    void deleteItemByPaperId(Integer paperId);

    List<PaperQuestion> findItemByProblemId(Integer problemId);
}
