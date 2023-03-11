package com.wale.exam.service.impl;

import com.wale.exam.bean.*;
import com.wale.exam.dao.AnswerMapper;
import com.wale.exam.service.AnswerService;
import com.wale.exam.service.PaperService;
import com.wale.exam.service.ProblemService;
import com.wale.exam.service.SheetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @Author WaleGarrett
 * @Date 2020/8/11 13:01
 */
@Service
public class AnswerServiceImpl implements AnswerService {
    @Autowired
    AnswerMapper answerMapper;
    @Autowired
    PaperService paperService;
    @Autowired
    SheetService sheetService;
    @Autowired
    ProblemService problemService;

    /**
     * 更新试卷答案
     * @param userid
     * @param questionId
     * @param paperId
     * @param answer
     * @return
     */
    @Override
    public int insertOrUpdateAnswer(Integer userid, Integer questionId, Integer paperId, String answer) {
        AnswerExample answerExample=new AnswerExample();
        AnswerExample.Criteria criteria=answerExample.createCriteria();
        criteria.andUserIdEqualTo(userid);
        criteria.andQuestionIdEqualTo(questionId);
        criteria.andPaperIdEqualTo(paperId);
        List<Answer> list=new ArrayList<>();
        list=answerMapper.selectByExample(answerExample);
        Answer answer1=new Answer();
        answer1.setAnswer(answer);
        answer1.setPaperId(paperId);
        answer1.setQuestionId(questionId);
        answer1.setUserId(userid);
        //自动判卷
        Problem problem=problemService.findProblemByProblemId(questionId);
        if(answer.equals(problem.getAnswer())){
            answer1.setScore(problem.getScore());//分数设置为0
        }else
            answer1.setScore(0);//分数设置为0
        answer1.setStatus(1);//设置为未批改
        if(list==null||list.size()==0){
            //插入
            answerMapper.insertSelective(answer1);
            return 1;
        }else if(list.size()==1){
            //更新
            answer1.setId(list.get(0).getId());
            answerMapper.updateByPrimaryKeySelective(answer1);
            return 2;
        }else{
            return 0;
        }
    }

    @Override
    public Answer getAnswerByUserIdAndQuesIdAndPaperId(Integer userid, int questionId, Integer paperId) {
        AnswerExample answerExample=new AnswerExample();
        AnswerExample.Criteria criteria=answerExample.createCriteria();
        criteria.andUserIdEqualTo(userid);
        criteria.andQuestionIdEqualTo(questionId);
        criteria.andPaperIdEqualTo(paperId);
        List<Answer> list=new ArrayList<>();
        list=answerMapper.selectByExample(answerExample);
        if(list.size()>0)
            return list.get(0);
        else return null;
    }

    /**
     * 提交教师的每一题判分
     * @param userId
     * @param questionId
     * @param paperId
     * @param score
     * @return
     */
    @Override
    public int insertOrUpdateAnswerSheet(Integer userId, Integer questionId, Integer paperId, Integer score) {
        AnswerExample answerExample=new AnswerExample();
        AnswerExample.Criteria criteria=answerExample.createCriteria();
        criteria.andUserIdEqualTo(userId);
        criteria.andQuestionIdEqualTo(questionId);
        criteria.andPaperIdEqualTo(paperId);
        List<Answer> list=new ArrayList<>();
        list=answerMapper.selectByExample(answerExample);
        Answer answer1=new Answer();
        answer1.setScore(score);
        answer1.setPaperId(paperId);
        answer1.setQuestionId(questionId);
        answer1.setUserId(userId);
        answer1.setStatus(1);//设置为未批改
        if(list==null||list.size()==0){
            //插入
            answerMapper.insertSelective(answer1);
            sheetService.updateSheetScoreByPaperIdAndUserId(paperId,userId);//更新答卷总分
            return 1;
        }else if(list.size()==1){
            //更新
            answer1.setId(list.get(0).getId());
            answerMapper.updateByPrimaryKeySelective(answer1);
            sheetService.updateSheetScoreByPaperIdAndUserId(paperId,userId);//更新答卷总分
            return 2;
        }else{
            return 0;
        }
    }
    /**
     * 根据作答者id和试卷id计算该人该试卷的总分
     * @param userId
     * @param paperId
     * @return
     */
    @Override
    public Integer computeTotalScore(int userId, int paperId) {
        List<Answer>list=new ArrayList<>();
        AnswerExample answerExample=new AnswerExample();
        AnswerExample.Criteria criteria=answerExample.createCriteria();
        criteria.andUserIdEqualTo(userId);
        criteria.andPaperIdEqualTo(paperId);
        list=answerMapper.selectByExample(answerExample);
        int totalScore=0;
        for (Answer answer:list) {
            totalScore+=answer.getScore();
        }
        return totalScore;
    }

    /**
     * 更新每题答案的status状态
     * @param userId
     * @param paperId
     */
    @Override
    public void updateAnswerStatus(Integer userId, Integer paperId) {
        AnswerExample answerExample=new AnswerExample();
        AnswerExample.Criteria criteria=answerExample.createCriteria();
        criteria.andUserIdEqualTo(userId);
        criteria.andPaperIdEqualTo(paperId);
        Answer answer=new Answer();
        answer.setStatus(2);
        answerMapper.updateByExampleSelective(answer,answerExample);
    }

    /**
     * 根据用户id查找所有的错题记录
     * @param userId
     * @return
     */
    @Override
    public List<Answer> findAllWrongAnswerOfUser(Integer userId) {
        List<Answer>list=new ArrayList<>();
        //首先根据userid找到对应的answer(这里需要根据status来判断是否是已经批改的错题)
        List<Answer>answerList=new ArrayList<>();
        AnswerExample answerExample=new AnswerExample();
        AnswerExample.Criteria criteria=answerExample.createCriteria();
        criteria.andUserIdEqualTo(userId);
        criteria.andStatusEqualTo(2);//是已经批改的试卷了
        answerList=answerMapper.selectByExample(answerExample);
        //接着根据questionid找到对应的problem
        //最后根据userid和questionid找到对应的sheet
        for(Answer answer:answerList){
            int problemId=answer.getQuestionId();
            int paperId=answer.getPaperId();
            Problem problem=new Problem();
            problem=problemService.findProblemByProblemId(problemId);//找到对应的problem
            int score=problem.getScore();
            int trueScore=answer.getScore();
            if(score!=trueScore){
                answer.setProblem(problem);
                Paper paper=new Paper();
                paper=paperService.findPaperByPaperId(paperId);//找到对应的paper
                answer.setPaper(paper);
                Sheet sheet=new Sheet();
                List<Sheet> sheetList=sheetService.findSheetByUserIdAndPaperId(userId,paperId);
                sheet=sheetList.get(0);//找到对应的sheet
                answer.setSheet(sheet);
                list.add(answer);
            }
        }
        return list;
    }

    @Override
    public void deleteAnswerByPaperId(Integer paperId) {
        AnswerExample answerExample=new AnswerExample();
        AnswerExample.Criteria criteria=answerExample.createCriteria();
        criteria.andPaperIdEqualTo(paperId);
        answerMapper.deleteByExample(answerExample);
    }

    @Override
    public void updateAnswerStatus1(int userid, int paperid) {
        AnswerExample answerExample=new AnswerExample();
        AnswerExample.Criteria criteria=answerExample.createCriteria();
        criteria.andUserIdEqualTo(userid);
        criteria.andPaperIdEqualTo(paperid);
        Answer answer=new Answer();
        answer.setStatus(1);
        answerMapper.updateByExampleSelective(answer,answerExample);
    }

    /**
     * 删除某个学生答卷中包含的所有答题记录
     * @param paperId
     * @param userId
     */
    @Override
    public void deleteAnswerByPaperIdAndUserId(Integer paperId, Integer userId) {
        AnswerExample answerExample=new AnswerExample();
        AnswerExample.Criteria criteria=answerExample.createCriteria();
        criteria.andUserIdEqualTo(userId);
        criteria.andPaperIdEqualTo(paperId);
        answerMapper.deleteByExample(answerExample);
    }

    /**
     * 更改答题的状态为未批改以及分数等信息
     * @param studentId
     * @param paperId
     */
    @Override
    public void updateAnswerStatus1AndOtherInfo(int studentId, int paperId) {
        AnswerExample answerExample=new AnswerExample();
        AnswerExample.Criteria criteria=answerExample.createCriteria();
        criteria.andUserIdEqualTo(studentId);
        criteria.andPaperIdEqualTo(paperId);
        Answer answer=new Answer();
        answer.setStatus(1);
//        answer.setScore(0);
        answer.setComment("");
        answerMapper.updateByExampleSelective(answer,answerExample);
    }

    @Override
    public Answer findAnswerByUserProblemPaper(Integer userId, Integer problemId, Integer paperId) {
        AnswerExample answerExample=new AnswerExample();
        AnswerExample.Criteria criteria=answerExample.createCriteria();
        criteria.andUserIdEqualTo(userId);
        criteria.andPaperIdEqualTo(paperId);
        criteria.andQuestionIdEqualTo(problemId);
        List<Answer>answerList=answerMapper.selectByExample(answerExample);
        if(answerList!=null&&answerList.size()>0){
            return answerList.get(0);
        }
        return null;
    }

    @Override
    public List<Answer> findAnswerByPaperUser(Integer paperId, Integer userId) {
        AnswerExample answerExample=new AnswerExample();
        AnswerExample.Criteria criteria=answerExample.createCriteria();
        criteria.andUserIdEqualTo(userId);
        criteria.andPaperIdEqualTo(paperId);
        List<Answer>answerList=answerMapper.selectByExample(answerExample);
        return answerList;
    }

}
