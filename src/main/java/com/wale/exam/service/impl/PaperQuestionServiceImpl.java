package com.wale.exam.service.impl;

import com.wale.exam.bean.PaperQuestion;
import com.wale.exam.bean.PaperQuestionExample;
import com.wale.exam.dao.PaperQuestionMapper;
import com.wale.exam.service.PaperQuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author WaleGarrett
 * @Date 2020/8/10 6:40
 */
@Service
public class PaperQuestionServiceImpl implements PaperQuestionService {

    @Autowired
    PaperQuestionMapper paperQuestionMapper;

    @Override
    public void addItem(int paperId, int proId) {
        PaperQuestion paperQuestion=new PaperQuestion();
        paperQuestion.setPaperId(paperId);
        paperQuestion.setQuestionId(proId);
        paperQuestionMapper.insertSelective(paperQuestion);
    }

    @Override
    public List<PaperQuestion> findItemByPaperId(Integer paperId) {
        PaperQuestionExample paperQuestionExample=new PaperQuestionExample();
        PaperQuestionExample.Criteria criteria=paperQuestionExample.createCriteria();
        criteria.andPaperIdEqualTo(paperId);
        List<PaperQuestion>list=paperQuestionMapper.selectByExample(paperQuestionExample);
        return list;
    }

    @Override
    public void deleteItemByPaperId(Integer paperId) {
        PaperQuestionExample paperQuestionExample=new PaperQuestionExample();
        PaperQuestionExample.Criteria criteria=paperQuestionExample.createCriteria();
        criteria.andPaperIdEqualTo(paperId);
        paperQuestionMapper.deleteByExample(paperQuestionExample);
    }
}
