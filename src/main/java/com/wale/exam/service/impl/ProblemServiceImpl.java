package com.wale.exam.service.impl;

import com.wale.exam.bean.*;
import com.wale.exam.dao.PaperMapper;
import com.wale.exam.dao.PaperQuestionMapper;
import com.wale.exam.dao.ProblemMapper;
import com.wale.exam.service.*;
import com.wale.exam.util.JsonDateValueProcessor;
import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @Author WaleGarrett
 * @Date 2020/8/9 10:20
 */
@Service
public class ProblemServiceImpl implements ProblemService {
    @Autowired
    ProblemMapper problemMapper;
    @Autowired
    PaperQuestionMapper paperQuestionMapper;
    @Autowired
    AnswerService answerService;
    @Autowired
    UserService userService;
    @Autowired
    PaperService paperService;
    @Autowired
    PaperQuestionService paperQuestionService;
    @Autowired
    SheetService sheetService;
    @Override
    public int findProblemCountByTeaId(Integer teacherId) {
        ProblemExample problemExample=new ProblemExample();
        ProblemExample.Criteria criteria=problemExample.createCriteria();
        criteria.andCreaterIdEqualTo(teacherId);
        List<Problem>list=new ArrayList<>();
        list=problemMapper.selectByExample(problemExample);
        return list.size();
    }

    @Override
    public List<Problem> findProblemByTeaId(Integer teacherId, int before, int after) {
        ProblemExample problemExample=new ProblemExample();
        ProblemExample.Criteria criteria=problemExample.createCriteria();
        criteria.andCreaterIdEqualTo(teacherId);
        problemExample.setOrderByClause("create_time desc");

        List<Problem>list=new ArrayList<>();
        //problemMapper.selectByExampleWithBLOBs()
        list=problemMapper.selectByExampleWithBLOBsAndPage(problemExample,before,after);
        //list=problemMapper.selectByExampleAndPage(problemExample,before,after);
        List<Problem>problemList=new ArrayList<>();
        User teacher=userService.findUserByUserId(teacherId);
        for(Problem problem:list){
            Integer type=problem.getType();
            String content=problem.getContent();
            switch (type){
                case 1: problem.setTypeName("单选题");
                break;
                case 2: problem.setTypeName("多选题");
                break;
                case 3:problem.setTypeName("判断题");
                break;
                case 4:problem.setTypeName("填空题");
                break;
                case 5:problem.setTypeName("简答题");
                default:break;
            }
            int start=content.indexOf("titleContent");
            String titleContent=content.substring(start+15,content.length()-2);
            problem.setTitleContent(titleContent);
            problem.setCreaterUserName(teacher.getUserName());//设置创建问题者的用户名
            problemList.add(problem);
        }
        return problemList;
    }

    @Override
    public void addProblem(Problem problem) {
        problemMapper.insertSelective(problem);
    }

    @Override
    public int findScoreByProId(int proId) {
        Problem problem=problemMapper.selectByPrimaryKey(proId);
        return problem.getScore();
    }

    /**
     * 根据试卷名称和试题类型找试卷中该类型的所有题目
     * @param paperId
     * @param i 表示题目的类型
     * @return
     */
    @Override
    public List<Problem> findProblemByPaperIdAndType(Integer paperId, int i,Integer userid) {

        PaperQuestionExample paperQuestionExample=new PaperQuestionExample();
        PaperQuestionExample.Criteria criteria=paperQuestionExample.createCriteria();
        criteria.andPaperIdEqualTo(paperId);
        List<PaperQuestion>list=new ArrayList<>();
        list=paperQuestionMapper.selectByExample(paperQuestionExample);
        List<Problem>problemList=new ArrayList<>();
        for (PaperQuestion paperQuestion:list) {
            int questionId=paperQuestion.getQuestionId();
            Problem problem=new Problem();
            problem=problemMapper.selectByPrimaryKey(questionId);
            if(problem.getType()==i){
                Answer answer=answerService.getAnswerByUserIdAndQuesIdAndPaperId(userid,questionId,paperId);
                if(answer!=null){
                    problem.setUserAnswer(answer.getAnswer());
                    problem.setUserScore(answer.getScore());//用于判卷，显示该用户对应该题的得分
                } else {
                    problem.setUserAnswer("");
                    problem.setUserScore(0);
                }
                problemList.add(problem);
            }
        }
        return problemList;
    }

    @Override
    public Problem findProblemByProblemId(int problemId) {
        Problem problem=problemMapper.selectByPrimaryKey(problemId);
        return problem;
    }

    /**
     * 更新题目
     * @param problem
     */
    @Override
    public void updateProblem(Problem problem) {
//        System.out.println(problem);
        problemMapper.updateByPrimaryKeySelective(problem);
        int problemId=problem.getId();
        List<PaperQuestion>list=paperQuestionService.findItemByProblemId(problemId);
        //重新计算所属试卷的总分
        for(PaperQuestion paperQuestion:list){
            Integer paperId=paperQuestion.getPaperId();
            paperService.reComputeTotalScoreByPaperId(paperId);
        }
    }

    @Override
    public List<Problem> findAllProblem() {
        ProblemExample problemExample=new ProblemExample();
        ProblemExample.Criteria criteria=problemExample.createCriteria();
        criteria.andIdIsNotNull();
//        problemExample.setOrderByClause("id");
        problemExample.setOrderByClause("create_time desc");
        List<Problem>list=new ArrayList<>();
        list=problemMapper.selectByExampleWithBLOBs(problemExample);
        List<Problem>problemList=new ArrayList<>();
        for(Problem problem:list){
            Integer userId=problem.getCreaterId();
            Integer type=problem.getType();
            String content=problem.getContent();
            switch (type){
                case 1: problem.setTypeName("单选题");
                    break;
                case 2: problem.setTypeName("多选题");
                    break;
                case 3:problem.setTypeName("判断题");
                    break;
                case 4:problem.setTypeName("填空题");
                    break;
                case 5:problem.setTypeName("简答题");
                default:break;
            }
            int start=content.indexOf("titleContent");
            String titleContent=content.substring(start+15,content.length()-2);
            problem.setTitleContent(titleContent);
            User user=userService.findUserByUserId(userId);
            problem.setCreaterUserName(user.getUserName());
            problemList.add(problem);
        }
        return problemList;
    }

    @Override
    public int findAllProblemCount() {
        ProblemExample problemExample=new ProblemExample();
        ProblemExample.Criteria criteria=problemExample.createCriteria();
        criteria.andIdIsNotNull();
        List<Problem>list=problemMapper.selectByExample(problemExample);
        if(list==null)
            list=new ArrayList<>();
        return list.size();
    }

    @Override
    public int findAllProblemCountWithTeacherId(int userid) {
        ProblemExample problemExample=new ProblemExample();
        ProblemExample.Criteria criteria=problemExample.createCriteria();
        criteria.andIdIsNotNull();
        criteria.andCreaterIdEqualTo(userid);
        List<Problem>list=problemMapper.selectByExample(problemExample);
        if(list==null)
            list=new ArrayList<>();
        return list.size();
    }

    /**
     * 模糊查找创建者创建的所有题目
     * @param teacherId
     * @param id
     * @param type
     * @param before
     * @param after
     * @return
     */
    @Override
    public List<Problem> searchProblem(Integer teacherId, Integer id, Integer type, int before, int after) {
        ProblemExample problemExample=new ProblemExample();
        ProblemExample.Criteria criteria=problemExample.createCriteria();
        criteria.andCreaterIdEqualTo(teacherId);
        if(id!=-1){
            criteria.andIdEqualTo(id);
        }
        if(type!=0){
            criteria.andTypeEqualTo(type);
        }
        if(id==-1&&type==0){
            criteria.andIdIsNotNull();
//            return new ArrayList<Problem>();
        }
        problemExample.setOrderByClause("id");
        List<Problem>list=new ArrayList<>();
        //problemMapper.selectByExampleWithBLOBs()
        list=problemMapper.selectByExampleWithBLOBsAndPage(problemExample,before,after);
        //list=problemMapper.selectByExampleAndPage(problemExample,before,after);
        List<Problem>problemList=new ArrayList<>();
        User teacher=userService.findUserByUserId(teacherId);
        for(Problem problem:list){
            Integer types=problem.getType();
            String content=problem.getContent();
            switch (types){
                case 1: problem.setTypeName("单选题");
                    break;
                case 2: problem.setTypeName("多选题");
                    break;
                case 3:problem.setTypeName("判断题");
                    break;
                case 4:problem.setTypeName("填空题");
                    break;
                case 5:problem.setTypeName("简答题");
                default:break;
            }
            int start=content.indexOf("titleContent");
            String titleContent=content.substring(start+15,content.length()-2);
            problem.setTitleContent(titleContent);
            problem.setCreaterUserName(teacher.getUserName());//设置创建者的用户名
            problemList.add(problem);
        }
        return problemList;
    }

    @Override
    public int searchProblemCount(Integer teacherId, Integer id, Integer type) {
        ProblemExample problemExample=new ProblemExample();
        ProblemExample.Criteria criteria=problemExample.createCriteria();
        criteria.andCreaterIdEqualTo(teacherId);
        if(id!=-1){
            criteria.andIdEqualTo(id);
        }
        if(type!=0){
            criteria.andTypeEqualTo(type);
        }
        if(id==-1&&type==0){
            criteria.andIdIsNotNull();
//            return 0;
        }
        List<Problem>list=new ArrayList<>();
        //problemMapper.selectByExampleWithBLOBs()
        list=problemMapper.selectByExample(problemExample);
        return list.size();
    }



    /**
     * 模糊查找
     * @param teacherId
     * @param keyword
     * @return
     */
    @Override
    public int findProblemCountByTeaId(Integer teacherId, String keyword) {
        ProblemExample problemExample=new ProblemExample();
        ProblemExample.Criteria criteria=problemExample.createCriteria();
        criteria.andCreaterIdEqualTo(teacherId);
        Integer types=0;
        if(keyword.equals("单选")||keyword.equals("单选题")){
            types=1;
        }else if(keyword.equals("多选")||keyword.equals("多选题")){
            types=2;
        }else if(keyword.equals("判断")||keyword.equals("判断题")){
            types=3;
        }else if(keyword.equals("填空")||keyword.equals("填空题")){
            types=4;
        }else if(keyword.equals("简答")||keyword.equals("简答题")){
            types=5;
        }
        if(types!=0){
            criteria.andTypeEqualTo(types);
        }
        List<Problem>list=new ArrayList<>();
        list=problemMapper.selectByExample(problemExample);
        return list.size();
    }

    /**
     * 模糊查找
     * @param teacherId
     * @param keyword
     * @param before
     * @param after
     * @return
     */
    @Override
    public List<Problem> findProblemByTeaId(Integer teacherId, String keyword, int before, int after) {
        ProblemExample problemExample=new ProblemExample();
        ProblemExample.Criteria criteria=problemExample.createCriteria();
        criteria.andCreaterIdEqualTo(teacherId);
        List<Problem>list=new ArrayList<>();
        Integer types=0;
        if(keyword.equals("单选")||keyword.equals("单选题")){
            types=1;
        }else if(keyword.equals("多选")||keyword.equals("多选题")){
            types=2;
        }else if(keyword.equals("判断")||keyword.equals("判断题")){
            types=3;
        }else if(keyword.equals("填空")||keyword.equals("填空题")){
            types=4;
        }else if(keyword.equals("简答")||keyword.equals("简答题")){
            types=5;
        }
        if(types!=0){
            criteria.andTypeEqualTo(types);
        }
//        problemExample.setOrderByClause("id");
        problemExample.setOrderByClause("create_time desc");
        //problemMapper.selectByExampleWithBLOBs()
        list=problemMapper.selectByExampleWithBLOBsAndPage(problemExample,before,after);
        //list=problemMapper.selectByExampleAndPage(problemExample,before,after);
        List<Problem>problemList=new ArrayList<>();
        for(Problem problem:list){
            Integer type=problem.getType();
            String content=problem.getContent();
            switch (type){
                case 1: problem.setTypeName("单选题");
                    break;
                case 2: problem.setTypeName("多选题");
                    break;
                case 3:problem.setTypeName("判断题");
                    break;
                case 4:problem.setTypeName("填空题");
                    break;
                case 5:problem.setTypeName("简答题");
                default:break;
            }
            int start=content.indexOf("titleContent");
            String titleContent=content.substring(start+15,content.length()-2);
            problem.setTitleContent(titleContent);
            problemList.add(problem);
        }
        return problemList;
    }

    @Override
    public List<Problem> findProblemsWithKeyword(String field, String keyword) {
        ProblemExample problemExample=new ProblemExample();
        ProblemExample.Criteria criteria=problemExample.createCriteria();
        criteria.andIdIsNotNull();
        if(field.equals("type")){
            Integer types=0;
            if(keyword.equals("单选")||keyword.equals("单选题")){
                types=1;
            }else if(keyword.equals("多选")||keyword.equals("多选题")){
                types=2;
            }else if(keyword.equals("判断")||keyword.equals("判断题")){
                types=3;
            }else if(keyword.equals("填空")||keyword.equals("填空题")){
                types=4;
            }else if(keyword.equals("简答")||keyword.equals("简答题")){
                types=5;
            }
            if(types!=0){
                criteria.andTypeEqualTo(types);
            }
        }
        problemExample.setOrderByClause("create_time desc");
        List<Problem>list=new ArrayList<>();
        list=problemMapper.selectByExampleWithBLOBs(problemExample);
        List<Problem>problemList=new ArrayList<>();
        for(Problem problem:list){
            Integer userId=problem.getCreaterId();
            Integer type=problem.getType();
            String content=problem.getContent();
            switch (type){
                case 1: problem.setTypeName("单选题");
                    break;
                case 2: problem.setTypeName("多选题");
                    break;
                case 3:problem.setTypeName("判断题");
                    break;
                case 4:problem.setTypeName("填空题");
                    break;
                case 5:problem.setTypeName("简答题");
                default:break;
            }
            int start=content.indexOf("titleContent");
            String titleContent=content.substring(start+15,content.length()-2);
            problem.setTitleContent(titleContent);
            User user=userService.findUserByUserId(userId);
            problem.setCreaterUserName(user.getUserName());
            problemList.add(problem);
        }
        return problemList;
    }
    /**
     * 删除题目
     * 首先需要重新计算所属试卷的卷面总分
     * @param problemId
     */
    @Override
    public void deleteProblem(Integer problemId) {

        List<PaperQuestion>list=paperQuestionService.findItemByProblemId(problemId);
        //更新答卷的总分
        sheetService.updateSheetScoreByProblemId(problemId);
        problemMapper.deleteByPrimaryKey(problemId);
        //重新计算所属试卷的总分
        for(PaperQuestion paperQuestion:list){
            Integer paperId=paperQuestion.getPaperId();
            paperService.reComputeTotalScoreByPaperId(paperId);
        }

    }
    /**
     * 批量删除题目
     * @param del_ids
     */
    @Override
    public void deleteBatch(List<Integer> del_ids) {
//        ProblemExample problemExample=new ProblemExample();
//        ProblemExample.Criteria criteria=problemExample.createCriteria();
//        criteria.andIdIn(del_ids);
//        problemMapper.deleteByExample(problemExample);
        for(Integer problemId:del_ids){
            List<PaperQuestion>list=paperQuestionService.findItemByProblemId(problemId);
            //更新答卷的总分
            sheetService.updateSheetScoreByProblemId(problemId);
            problemMapper.deleteByPrimaryKey(problemId);
            //重新计算所属试卷的总分
            for(PaperQuestion paperQuestion:list){
                Integer paperId=paperQuestion.getPaperId();
                paperService.reComputeTotalScoreByPaperId(paperId);
            }
        }
    }

    /**
     * 查找某套试卷的某种题型的所有题目
     * @param paperId
     * @param i
     * @return
     */
    @Override
    public List<Problem> findProblemByPaperIdAndType(Integer paperId, int i) {
        PaperQuestionExample paperQuestionExample=new PaperQuestionExample();
        PaperQuestionExample.Criteria criteria=paperQuestionExample.createCriteria();
        criteria.andPaperIdEqualTo(paperId);
        List<PaperQuestion>list=new ArrayList<>();
        list=paperQuestionMapper.selectByExample(paperQuestionExample);
        List<Problem>problemList=new ArrayList<>();
        for (PaperQuestion paperQuestion:list) {
            int questionId=paperQuestion.getQuestionId();
            Problem problem=new Problem();
            problem=problemMapper.selectByPrimaryKey(questionId);
            if(problem.getType()==i){
                problem.setUserAnswer("");
                problem.setUserScore(0);
                problemList.add(problem);
            }
        }
        return problemList;
    }
}
