package com.wale.exam.service.impl;

import com.wale.exam.bean.*;
import com.wale.exam.dao.PaperMapper;
import com.wale.exam.service.*;
import com.wale.exam.util.RedisUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * @Author WaleGarrett
 * @Date 2020/8/8 9:30
 */
@Service
public class PaperServiceImpl implements PaperService {
    @Autowired
    PaperMapper paperMapper;
    @Autowired
    SheetService sheetService;
    @Autowired
    ProblemService problemService;
    @Autowired
    AnswerService answerService;
    @Autowired
    PaperQuestionService paperQuestionService;
    @Autowired
    UserService userService;

    /**
     * 根据创建者id查找创建的所有试卷
     * @param teacherId
     * @param before
     * @param after
     * @return
     */
    @Override
    public List<Paper> findPaperByTeaId(Integer teacherId, int before, int after) {
        PaperExample paperExample=new PaperExample();
        PaperExample.Criteria criteria=paperExample.createCriteria();
        criteria.andCreaterIdEqualTo(teacherId);
//        paperExample.setOrderByClause("id");
        paperExample.setOrderByClause("create_time desc");
        List<Paper>list=new ArrayList<>();
        list=paperMapper.selectByExampleAndPage(paperExample,before,after);
        List<Paper>paperList=new ArrayList<>();
        User teacher=userService.findUserByUserId(teacherId);
        for(Paper paper:list) {
            if (paper.getIsEncry() == 1) {//未加密
                paper.setIsEncryString("否");
            }else{
                paper.setIsEncryString("是");
            }
            paper.setCreaterUserName(teacher.getUserName());//设置创建者的用户名
            paperList.add(paper);
        }
        return paperList;
    }

    @Override
    public int findPaperCountByTeaId(Integer teacherId) {
        PaperExample paperExample=new PaperExample();
        PaperExample.Criteria criteria=paperExample.createCriteria();
        criteria.andCreaterIdEqualTo(teacherId);
        List<Paper>list=new ArrayList<>();
        list=paperMapper.selectByExample(paperExample);
        return list.size();
    }
    /*
    新增试卷-但是没有试卷包含的题目的信息
     */
    @Override
    public void addPaperWithoutProblems(Paper paper) {
        paperMapper.insertSelective(paper);
    }

    /**
     * 查找由指定发布者创建的试卷中的最后也一个元素
     * @param teacherId
     * @return
     */
    @Override
    public int findLastRecordByCreaterId(Integer teacherId) {
        PaperExample paperExample=new PaperExample();
        PaperExample.Criteria criteria=paperExample.createCriteria();
        criteria.andCreaterIdEqualTo(teacherId);
        paperExample.setOrderByClause("id asc");
        int paperId=paperMapper.selectLastRecordByCreaterId(paperExample);
        return paperId;
    }

    @Override
    public List<Paper> findAllPapers() {
        PaperExample paperExample=new PaperExample();
        PaperExample.Criteria criteria=paperExample.createCriteria();
        criteria.andIdIsNotNull();
        List<Paper>list=new ArrayList<>();
        list=paperMapper.selectByExample(paperExample);
        List<Paper>paperList=new ArrayList<>();
        for(Paper paper:list) {
            if (paper.getIsEncry() == 1) {//未加密
                paper.setIsEncryString("否");
            }else{
                paper.setIsEncryString("是");
            }
            paperList.add(paper);
        }
        return paperList;
    }

    @Override
    public Paper findPaperByPaperId(Integer paperId) {
        return paperMapper.selectByPrimaryKey(paperId);
    }

    /**
     * 查找该老师创建的所有试卷
     * @param teacherId
     * @return
     */
    @Override
    public List<Paper> findPaperByCreaterId(Integer teacherId) {
        PaperExample paperExample=new PaperExample();
        PaperExample.Criteria criteria=paperExample.createCriteria();
        criteria.andCreaterIdEqualTo(teacherId);
        List<Paper>list=new ArrayList<>();
        list=paperMapper.selectByExample(paperExample);
        return list;
    }

    @Override
    public List<Paper> findAllPapersWithUser(Integer userId) {
        PaperExample paperExample=new PaperExample();
        PaperExample.Criteria criteria=paperExample.createCriteria();
        criteria.andIdIsNotNull();
        paperExample.setOrderByClause("start_time desc");
        List<Paper>list=new ArrayList<>();
        list=paperMapper.selectByExample(paperExample);
        List<Paper>listWithHas=new ArrayList<>();
        for(Paper paper: list){
            Integer paperId=paper.getId();
            List<Sheet>sheet=sheetService.findSheetByUserIdAndPaperId(userId,paperId);
            if(sheet==null||sheet.size()==0){
                paper.setHasDoExam(false);
            }else paper.setHasDoExam(true);
            listWithHas.add(paper);
        }
        return listWithHas;
    }

    @Override
    public List<Paper> findAllPapersWithUserNotStart(int userId) {
        PaperExample paperExample=new PaperExample();
        PaperExample.Criteria criteria=paperExample.createCriteria();
        criteria.andIdIsNotNull();
        criteria.andStartTimeGreaterThan(new Date());
        List<Paper>list=new ArrayList<>();
        paperExample.setOrderByClause("start_time desc");
        list=paperMapper.selectByExample(paperExample);
        List<Paper>listWithHas=new ArrayList<>();
        for(Paper paper: list){
            Integer paperId=paper.getId();
            List<Sheet>sheet=sheetService.findSheetByUserIdAndPaperId(userId,paperId);
            if(sheet==null||sheet.size()==0){
                paper.setHasDoExam(false);
            }else paper.setHasDoExam(true);
            listWithHas.add(paper);
        }
        return listWithHas;
    }

    @Override
    public List<Paper> findAllPapersWithUserHasEnd(int userId) {
        PaperExample paperExample=new PaperExample();
        PaperExample.Criteria criteria=paperExample.createCriteria();
        criteria.andIdIsNotNull();
        criteria.andEndTimeLessThanOrEqualTo(new Date());
        List<Paper>list=new ArrayList<>();
        paperExample.setOrderByClause("start_time desc");
        list=paperMapper.selectByExample(paperExample);
        List<Paper>listWithHas=new ArrayList<>();
        for(Paper paper: list){
            Integer paperId=paper.getId();
            List<Sheet>sheet=sheetService.findSheetByUserIdAndPaperId(userId,paperId);
            if(sheet==null||sheet.size()==0){
                paper.setHasDoExam(false);
            }else paper.setHasDoExam(true);
            listWithHas.add(paper);
        }
        return listWithHas;
    }

    @Override
    public List<Paper> findAllPapersWithUserDuring(int userId) {
        PaperExample paperExample=new PaperExample();
        PaperExample.Criteria criteria=paperExample.createCriteria();
        criteria.andIdIsNotNull();
        criteria.andStartTimeLessThanOrEqualTo(new Date());
        criteria.andEndTimeGreaterThan(new Date());
        List<Paper>list=new ArrayList<>();
        paperExample.setOrderByClause("start_time desc");
        list=paperMapper.selectByExample(paperExample);
        List<Paper>listWithHas=new ArrayList<>();
        for(Paper paper: list){
            Integer paperId=paper.getId();
            List<Sheet>sheet=sheetService.findSheetByUserIdAndPaperId(userId,paperId);
            if(sheet==null||sheet.size()==0){
                paper.setHasDoExam(false);
            }else paper.setHasDoExam(true);
            listWithHas.add(paper);
        }
        return listWithHas;
    }

    @Override
    public List<Paper> findAllPapersWithUserHasDone(int userId) {
        List<Sheet>sheetList=new ArrayList<>();
        sheetList=sheetService.findSheetByUserId(userId);
        List<Paper>paperList=new ArrayList<>();
        for(Sheet sheet:sheetList){
            int paperId=sheet.getPaperId();
            Paper paper=findPaperByPaperId(paperId);
            paperList.add(paper);
        }
        return paperList;
    }

    /**
     * 更新paper记录
     * @param paper
     * @param problems
     */
    @Override
    public void updatePaper(Paper paper, String problems) {
        String[] problem = problems.trim().split(",");
        int proCount=0;
        int totalScore=0;
        for(String item:problem){
            int proId=Integer.parseInt(item);
            int score=problemService.findScoreByProId(proId);
            totalScore+=score;
            proCount++;
        }
        paper.setTotalScore(totalScore);//默认总分100
        paper.setQuestionCount(proCount);//默认题目数量为0
        Integer paperId=paper.getId();

        //首先更新paper表的基本信息
        paperMapper.updateByPrimaryKeySelective(paper);
        //首先删除所有的答题记录--包括answer表和sheet表
        answerService.deleteAnswerByPaperId(paperId);
        sheetService.deleteSheetByPaperId(paperId);
        //其次删除paperQuestion表的paper记录
        paperQuestionService.deleteItemByPaperId(paperId);
        //接着插入paperQuestion表的记录
        for(String item:problem){
            int proId=Integer.parseInt(item);
            paperQuestionService.addItem(paperId,proId);//插入试卷-题目联系表
        }
    }

    @Override
    public List<Paper> findAllPaper() {
        List<Paper>paperList=new ArrayList<>();
        PaperExample paperExample=new PaperExample();
        PaperExample.Criteria criteria=paperExample.createCriteria();
        criteria.andIdIsNotNull();
        paperExample.setOrderByClause("create_time desc");
        paperList=paperMapper.selectByExample(paperExample);
        List<Paper>list=new ArrayList<>();
        for(Paper paper:paperList){
            int craterId=paper.getCreaterId();
            User user=userService.findUserByUserId(craterId);
            paper.setCreaterUserName(user.getUserName());
            if (paper.getIsEncry() == 1) {//未加密
                paper.setIsEncryString("否");
            }else{
                paper.setIsEncryString("是");
            }
            list.add(paper);
        }
        return list;
    }

    @Override
    public void updatePaper(Paper paper) {
        paperMapper.updateByPrimaryKeySelective(paper);
    }

    @Override
    public void deletePaper(Integer paperId) {
        String hottestkey="hottest:papers";
        RedisUtil.removeZSet(hottestkey,paperId);
        paperMapper.deleteByPrimaryKey(paperId);
    }

    /**
     * 批量删除
     * @param del_ids
     */
    @Override
    public void deleteBatch(List<Integer> del_ids) {
        PaperExample paperExample=new PaperExample();
        PaperExample.Criteria criteria=paperExample.createCriteria();
        criteria.andIdIn(del_ids);
        for(Integer paperId:del_ids){
            //删除最热考试
            String hottestkey="hottest:papers";
            RedisUtil.removeZSet(hottestkey,paperId);
        }
        paperMapper.deleteByExample(paperExample);
    }

    /**
     * 重新计算该试卷的总分数
     * @param paperId
     */
    @Override
    public void reComputeTotalScoreByPaperId(Integer paperId) {
        List<PaperQuestion>list=new ArrayList<>();
        list=paperQuestionService.findItemByPaperId(paperId);
        Paper paper=new Paper();
        paper.setId(paperId);
        int totalScore=0;
        for(PaperQuestion paperQuestion:list){
            Problem problem=problemService.findProblemByProblemId(paperQuestion.getQuestionId());
            totalScore+=problem.getScore();
        }
        paper.setTotalScore(totalScore);
        paperMapper.updateByPrimaryKeySelective(paper);
    }


    @Override
    public int findAllPaperCount() {
        PaperExample paperExample=new PaperExample();
        PaperExample.Criteria criteria=paperExample.createCriteria();
        criteria.andIdIsNotNull();
        List<Paper>list=paperMapper.selectByExample(paperExample);
        if(list==null)
            list=new ArrayList<>();
        return list.size();
    }

    @Override
    public List<Integer> findPaperList() {
        PaperExample paperExample=new PaperExample();
        PaperExample.Criteria criteria=paperExample.createCriteria();
        criteria.andIdIsNotNull();
        List<Paper>list=paperMapper.selectByExample(paperExample);
        int []num={0,0,0,0,0,0,0};
        for(Paper paper:list){
            Date time=paper.getCreateTime();
            Calendar cal = Calendar.getInstance();
            cal.setTime(time);
            int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
            if (w < 0)
                w = 0;
            num[w]++;
        }
        List<Integer> integerList=new ArrayList<>();
        for(int i=0;i<num.length;i++){
            integerList.add(num[i]);
        }
        return integerList;
    }

    @Override
    public int findAllPaperCountWithTeacherId(int userid) {
        PaperExample paperExample=new PaperExample();
        PaperExample.Criteria criteria=paperExample.createCriteria();
        criteria.andIdIsNotNull();
        criteria.andCreaterIdEqualTo(userid);
        List<Paper>list=paperMapper.selectByExample(paperExample);
        if(list==null)
            list=new ArrayList<>();
        return list.size();
    }

    @Override
    public List<Integer> findPaperListWithTeacherId(int userid) {
        PaperExample paperExample=new PaperExample();
        PaperExample.Criteria criteria=paperExample.createCriteria();
        criteria.andIdIsNotNull();
        criteria.andCreaterIdEqualTo(userid);
        List<Paper>list=paperMapper.selectByExample(paperExample);
        int []num={0,0,0,0,0,0,0};
        for(Paper paper:list){
            Date time=paper.getCreateTime();
            Calendar cal = Calendar.getInstance();
            cal.setTime(time);
            int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
            if (w < 0)
                w = 0;
            num[w]++;
        }
        List<Integer> integerList=new ArrayList<>();
        for(int i=0;i<num.length;i++){
            integerList.add(num[i]);
        }
        return integerList;
    }

    @Override
    public List<Paper> findAllPaperWithNoEncry() {
        PaperExample paperExample=new PaperExample();
        PaperExample.Criteria criteria=paperExample.createCriteria();
        criteria.andIsEncryEqualTo(1);//未加密
        paperExample.setOrderByClause("start_time desc");
        List<Paper>list=paperMapper.selectByExample(paperExample);
        List<Paper>paperList=new ArrayList<>();
        for(Paper paper:list){
            int createrId=paper.getCreaterId();
            User user=userService.findUserByUserId(createrId);
            paper.setCreaterUserName(user.getUserName());
            paperList.add(paper);
        }
        return paperList;
    }

    /**
     * 模糊查询试卷
     * @param teacherId
     * @param id
     * @param title
     * @param before
     * @param after
     * @return
     */
    @Override
    public List<Paper> searchPaper(Integer teacherId, Integer id, String title, int before, int after) {
        PaperExample paperExample=new PaperExample();
        PaperExample.Criteria criteria=paperExample.createCriteria();
        criteria.andCreaterIdEqualTo(teacherId);
        if(id!=-1){
            criteria.andIdEqualTo(id);
        }
        criteria.andPaperNameLike("%"+title+"%");
        paperExample.setOrderByClause("id");
        List<Paper>list=new ArrayList<>();
        list=paperMapper.selectByExampleAndPage(paperExample,before,after);
        List<Paper>paperList=new ArrayList<>();
        User teacher=userService.findUserByUserId(teacherId);
        for(Paper paper:list){
            int craterId=paper.getCreaterId();
            User user=userService.findUserByUserId(craterId);
            paper.setCreaterUserName(user.getUserName());
            if (paper.getIsEncry() == 1) {//未加密
                paper.setIsEncryString("否");
            }else{
                paper.setIsEncryString("是");
            }
            paper.setCreaterUserName(teacher.getUserName());//设置创建者用户名
            paperList.add(paper);
        }

        return paperList;
    }

    @Override
    public int searchPaperCount(Integer teacherId, Integer id, String title) {
        PaperExample paperExample=new PaperExample();
        PaperExample.Criteria criteria=paperExample.createCriteria();
        criteria.andCreaterIdEqualTo(teacherId);
        if(id!=-1){
            criteria.andIdEqualTo(id);
        }
        criteria.andPaperNameLike("%"+title+"%");
        paperExample.setOrderByClause("id");

        List<Paper>list=new ArrayList<>();
        list=paperMapper.selectByExample(paperExample);
        return list.size();
    }

    @Override
    public List<Paper> findPaperByCreaterIdBlur(Integer teacherId, String paperName) {
        PaperExample paperExample=new PaperExample();
        PaperExample.Criteria criteria=paperExample.createCriteria();
        criteria.andCreaterIdEqualTo(teacherId);
        criteria.andPaperNameLike("%"+paperName+"%");
        List<Paper>list=new ArrayList<>();
        list=paperMapper.selectByExample(paperExample);
        return list;
    }

    @Override
    public List<Paper> findPaperWithKeyword(String field,String keyword) {
        List<Paper>paperList=new ArrayList<>();
        PaperExample paperExample=new PaperExample();
        PaperExample.Criteria criteria=paperExample.createCriteria();
        if(field.equals("name")){
            criteria.andPaperNameLike("%"+keyword+"%");
        }
        paperList=paperMapper.selectByExample(paperExample);
        List<Paper>list=new ArrayList<>();
        for(Paper paper:paperList){
            int craterId=paper.getCreaterId();
            User user=userService.findUserByUserId(craterId);
            paper.setCreaterUserName(user.getUserName());
            if (paper.getIsEncry() == 1) {//未加密
                paper.setIsEncryString("否");
            }else{
                paper.setIsEncryString("是");
            }
            list.add(paper);
        }
        return list;
    }

    /**
     * 查找答卷人数最多的试卷
     * @return
     */
    @Override
    public List<Paper> findHottestPaper() {
        //paperId - 人数

        Map<Integer,Integer> map=sheetService.findHottestPaperInSheets();
        List<Paper> paperList=new ArrayList<>();
        int index=0;
        for (Map.Entry<Integer, Integer> detail:map.entrySet()){
            Integer paperId=detail.getKey();
            Integer num=detail.getValue();
            Paper paper=new Paper();
            paper=paperMapper.selectByPrimaryKey(paperId);
            paperList.add(paper);
            if(++index>20)
                break;
        }
        return paperList;
    }

    @Override
    public List<Paper> findHottestPaperWithRedis() {
        List<Paper> paperList=new ArrayList<>();
        String hottestkey="hottest:papers";
        //paperId - 人数
        if(RedisUtil.hasKey(hottestkey)){
            //取出最热考试试卷
            Set<Integer> hottestSet=RedisUtil.getZSetReverse(hottestkey,0,20);
            for(Integer paperId:hottestSet){
                Paper paper=new Paper();
                paper=paperMapper.selectByPrimaryKey(paperId);
                paperList.add(paper);
            }
        }else{
            Map<Integer,Integer> map=sheetService.findHottestPaperInSheets();
            int index=0;
            for (Map.Entry<Integer, Integer> detail:map.entrySet()){
                Integer paperId=detail.getKey();
                Integer num=detail.getValue();
                Paper paper=new Paper();
                paper=paperMapper.selectByPrimaryKey(paperId);
                paperList.add(paper);
                RedisUtil.addZSet(hottestkey,paperId,num);
                if(++index>20)
                    break;
            }
            //设置过期时间
            RedisUtil.setExp(hottestkey,7*24*60*60);//一个礼拜的过期时间7*24*60*60
        }
        return paperList;
    }

    /**
     * 根据创建者id来删除试卷
     * @param userId
     * @return
     */
    @Override
    public boolean deletePaperByCreaterId(Integer userId) {

        PaperExample paperExample=new PaperExample();
        PaperExample.Criteria criteria=paperExample.createCriteria();
        criteria.andCreaterIdEqualTo(userId);
        List<Paper>list=paperMapper.selectByExample(paperExample);
        for(Paper paper:list){
            int paperId=paper.getId();
            //删除最热考试
            String hottestkey="hottest:papers";
            RedisUtil.removeZSet(hottestkey,paperId);
        }
        paperMapper.deleteByExample(paperExample);
        return true;
    }


}
