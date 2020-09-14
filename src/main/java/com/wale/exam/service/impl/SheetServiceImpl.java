package com.wale.exam.service.impl;

import com.wale.exam.bean.*;
import com.wale.exam.dao.SheetMapper;
import com.wale.exam.service.*;
import com.wale.exam.util.RedisUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * @Author WaleGarrett
 * @Date 2020/8/11 15:37
 */
@Service
public class SheetServiceImpl implements SheetService {
    @Autowired
    SheetMapper sheetMapper;
    @Autowired
    PaperService paperService;
    @Autowired
    AnswerService answerService;
    @Autowired
    PaperQuestionService paperQuestionService;
    @Autowired
    UserService userService;
    @Override
    public void addSheet(Integer userId, Integer paperId) {
        Paper paper=paperService.findPaperByPaperId(paperId);
        Date deadline=paper.getEndTime();
        Date now=new Date();
        long diff=deadline.getTime()-now.getTime();
        diff=diff/60/1000;//还剩多少分钟
        int duration=paper.getDurationTime();
        int do_time=(int)(duration-diff);//完成试卷花费的时间
        Sheet sheet=new Sheet();
        sheet.setDoTime(do_time);
        sheet.setPaperId(paperId);
        sheet.setStatus(1);//1-未批改，2-已批改
        sheet.setUserId(userId);
        sheet.setSubmitTime(new Date());
        int totalScore=getSheetScoreByPaperIdAndUserId(paperId,userId);
        sheet.setScore(totalScore);
        sheetMapper.insertSelective(sheet);

    }



    /**
     * 首先根据teacherid找到创建的所有试卷，再根据每个paperId找到所有的Sheet即答卷
     * @param teacherId
     * @param before
     * @param after
     * @return
     */
    @Override
    public List<Sheet> findSheetByTeaId(Integer teacherId, int before, int after) {
        //首先找到该老师创建的所有试卷
        List<Sheet>sheetList=new ArrayList<>();
        List<Paper>paperList=new ArrayList<>();
        paperList=paperService.findPaperByCreaterId(teacherId);
        int index=0;
        for (Paper paper:paperList) {
            int paperId=paper.getId();
            SheetExample sheetExample=new SheetExample();
            SheetExample.Criteria criteria=sheetExample.createCriteria();
            criteria.andPaperIdEqualTo(paperId);
            criteria.andStatusEqualTo(1);//所有未批改的试卷
            sheetExample.setOrderByClause("submit_time desc");
            List<Sheet>sublist=new ArrayList<>();
            sublist=sheetMapper.selectByExample(sheetExample);
            for (Sheet sheet: sublist) {
                if(index>=before&&index<=before+after-1){
                    int userid=sheet.getUserId();
                    User user=userService.findUserByUserId(userid);
                    sheet.setUserName(user.getUserName());
                    sheet.setRealName(user.getRealName());
                    //将试卷名称信息放置在答卷上
                    sheet.setPaperName(paper.getPaperName());
                    sheetList.add(sheet);
                }
                index++;
            }
        }
        return sheetList;
    }

    /**
     * 找到该老师出的试卷被提交的答卷的数量
     * @param teacherId
     * @return
     */
    @Override
    public int findSheetCountByTeaId(Integer teacherId) {
        List<Paper>paperList=new ArrayList<>();
        paperList=paperService.findPaperByCreaterId(teacherId);
        int index=0;
        for (Paper paper:paperList) {
            int paperId=paper.getId();
            SheetExample sheetExample=new SheetExample();
            SheetExample.Criteria criteria=sheetExample.createCriteria();
            criteria.andPaperIdEqualTo(paperId);
            criteria.andStatusEqualTo(1);
            List<Sheet>sublist=new ArrayList<>();
            sublist=sheetMapper.selectByExample(sheetExample);
            for (Sheet sheet: sublist) {
                index++;
            }
        }
        return index;
    }

    @Override
    public Sheet findSheetById(Integer sheetId) {
        Sheet sheet=new Sheet();
        sheet=sheetMapper.selectByPrimaryKey(sheetId);
        return sheet;
    }

    @Override
    public void addSheetJudge(Integer userId, Integer paperId, Integer score, String comment) {
        SheetExample sheetExample=new SheetExample();
        SheetExample.Criteria criteria=sheetExample.createCriteria();
        criteria.andPaperIdEqualTo(paperId);
        criteria.andUserIdEqualTo(userId);
        Sheet sheet=new Sheet();
        sheet.setScore(score);
        sheet.setComment(comment);
        sheet.setStatus(2);
        answerService.updateAnswerStatus(userId,paperId);//更新所有相关题目作答的批改状态
        sheetMapper.updateByExampleSelective(sheet,sheetExample);
    }

    @Override
    public List<Sheet> findSheetByUserIdAndPaperId(Integer userId, Integer paperId) {
        SheetExample sheetExample=new SheetExample();
        SheetExample.Criteria criteria=sheetExample.createCriteria();
        criteria.andPaperIdEqualTo(paperId);
        criteria.andUserIdEqualTo(userId);
        List<Sheet>list=new ArrayList<>();
        list=sheetMapper.selectByExample(sheetExample);
        return list;
    }

    @Override
    public List<Sheet> findSheetByUserId(int userId) {
        List<Sheet>list=new ArrayList<>();
        SheetExample sheetExample=new SheetExample();
        SheetExample.Criteria criteria=sheetExample.createCriteria();
        criteria.andUserIdEqualTo(userId);
        sheetExample.setOrderByClause("submit_time desc");
        list=sheetMapper.selectByExample(sheetExample);
        return list;
    }

    @Override
    public List<Sheet> findAllSheetsWithUserHasDone(int userId) {
        List<Sheet>list=new ArrayList<>();
        SheetExample sheetExample=new SheetExample();
        SheetExample.Criteria criteria=sheetExample.createCriteria();
        criteria.andUserIdEqualTo(userId);
        list=sheetMapper.selectByExample(sheetExample);
        List<Sheet>sheetList=new ArrayList<>();
        for(Sheet sheet:list){
            int paperId=sheet.getPaperId();
            Paper paper=paperService.findPaperByPaperId(paperId);
            sheet.setPaperName(paper.getPaperName());
            sheetList.add(sheet);
        }
        return sheetList;
    }

    @Override
    public List<Sheet> findJudgedSheetByTeaId(Integer teacherId, int before, int after) {
        //首先找到该老师创建的所有试卷
        List<Sheet>sheetList=new ArrayList<>();
        List<Paper>paperList=new ArrayList<>();
        paperList=paperService.findPaperByCreaterId(teacherId);
        int index=0;
        for (Paper paper:paperList) {
            int paperId=paper.getId();
            SheetExample sheetExample=new SheetExample();
            SheetExample.Criteria criteria=sheetExample.createCriteria();
            criteria.andPaperIdEqualTo(paperId);
            criteria.andStatusEqualTo(2);//所有批改的试卷
            List<Sheet>sublist=new ArrayList<>();
            sublist=sheetMapper.selectByExample(sheetExample);
            for (Sheet sheet: sublist) {
                if(index>=before&&index<=before+after-1){
                    //将试卷名称信息放置在答卷上
                    sheet.setPaperName(paper.getPaperName());
                    int userid=sheet.getUserId();
                    User user=userService.findUserByUserId(userid);
                    sheet.setUserName(user.getUserName());
                    sheetList.add(sheet);
                }
                index++;
            }
        }
        return sheetList;
    }

    @Override
    public int findJudgedSheetCountByTeaId(Integer teacherId) {
        List<Paper>paperList=new ArrayList<>();
        paperList=paperService.findPaperByCreaterId(teacherId);
        int index=0;
        for (Paper paper:paperList) {
            int paperId=paper.getId();
            SheetExample sheetExample=new SheetExample();
            SheetExample.Criteria criteria=sheetExample.createCriteria();
            criteria.andPaperIdEqualTo(paperId);
            criteria.andStatusEqualTo(2);
            List<Sheet>sublist=new ArrayList<>();
            sublist=sheetMapper.selectByExample(sheetExample);
            for (Sheet sheet: sublist) {
                index++;
            }
        }
        return index;
    }

    @Override
    public void deleteSheetByPaperId(Integer paperId) {
        SheetExample sheetExample=new SheetExample();
        SheetExample.Criteria criteria=sheetExample.createCriteria();
        criteria.andPaperIdEqualTo(paperId);
        sheetMapper.deleteByExample(sheetExample);
    }

    /**
     * 查找所有批改了的试卷
     * @return
     */
    @Override
    public List<Sheet> findAllSheetWithJudged() {
        SheetExample sheetExample=new SheetExample();
        SheetExample.Criteria criteria=sheetExample.createCriteria();
        criteria.andStatusEqualTo(2);
        List<Sheet>sheetList=new ArrayList<>();
        sheetExample.setOrderByClause("submit_time desc");
        sheetList=sheetMapper.selectByExample(sheetExample);
        List<Sheet>list=new ArrayList<>();
        for(Sheet sheet:sheetList){
            int userId=sheet.getUserId();
            int paperId=sheet.getPaperId();
            User doUser=new User();
            doUser=userService.findUserByUserId(userId);
            User judgeUser=new User();
            Paper paper=new Paper();
            paper=paperService.findPaperByPaperId(paperId);
            judgeUser=userService.findUserByUserId(paper.getCreaterId());
            sheet.setUserName(doUser.getUserName());
            sheet.setPaperName(paper.getPaperName());
            sheet.setJudgerName(judgeUser.getUserName());
            sheet.setPaperScore(paper.getTotalScore());
            list.add(sheet);
        }
        return list;
    }

    @Override
    public Sheet findSheetBySheetId(Integer sheetId) {
        Sheet sheet=sheetMapper.selectByPrimaryKey(sheetId);
        int userId=sheet.getUserId();
        int paperId=sheet.getPaperId();
        User doUser=new User();
        doUser=userService.findUserByUserId(userId);
        User judgeUser=new User();
        Paper paper=new Paper();
        paper=paperService.findPaperByPaperId(paperId);
        judgeUser=userService.findUserByUserId(paper.getCreaterId());
        sheet.setUserName(doUser.getUserName());
        sheet.setPaperName(paper.getPaperName());
        sheet.setJudgerName(judgeUser.getUserName());
        sheet.setPaperScore(paper.getTotalScore());
        return sheet;
    }

    @Override
    public void updateSheet(Sheet sheet) {
        sheetMapper.updateByPrimaryKeySelective(sheet);
    }

    @Override
    public int findAllJudgedCountWithTeacherId(int userid) {
        List<Paper>paperList=new ArrayList<>();
        paperList=paperService.findPaperByCreaterId(userid);
        int count=0;
        for(Paper paper:paperList){
            int paperId=paper.getId();
            SheetExample sheetExample=new SheetExample();
            SheetExample.Criteria criteria=sheetExample.createCriteria();
            criteria.andStatusEqualTo(2);
            criteria.andPaperIdEqualTo(paperId);
            List<Sheet>sheetList=new ArrayList<>();
            sheetList=sheetMapper.selectByExample(sheetExample);
            count+=sheetList.size();
        }
        return count;
    }

    @Override
    public List<Sheet> searchJudge(Integer sheetId, String paperName, String userName, Integer teacherId, int before, int after) {
        //首先找到该老师创建的所有试卷
        List<Sheet>sheetList=new ArrayList<>();
        List<Paper>paperList=new ArrayList<>();
        if(paperName.equals(""))
            paperList=paperService.findPaperByCreaterId(teacherId);
        else paperList=paperService.findPaperByCreaterIdBlur(teacherId,paperName);
        int index=0;
        for (Paper paper:paperList) {
            int paperId=paper.getId();
            SheetExample sheetExample=new SheetExample();
            SheetExample.Criteria criteria=sheetExample.createCriteria();
            criteria.andPaperIdEqualTo(paperId);
            criteria.andStatusEqualTo(1);//所有未批改的试卷
            List<Sheet>sublist=new ArrayList<>();
            sublist=sheetMapper.selectByExample(sheetExample);
            for (Sheet sheet: sublist) {
                if(index>=before&&index<=before+after-1){
                    if(sheetId!=-1&&sheetId!=sheet.getId()){
                        continue;
                    }
                    //将试卷名称信息放置在答卷上
                    sheet.setPaperName(paper.getPaperName());
                    int userid=sheet.getUserId();
                    User user=userService.findUserByUserId(userid);
                    sheet.setUserName(user.getUserName());
                    String name=user.getUserName();
                    sheet.setRealName(user.getRealName());
                    if(userName.equals("")||name.contains(userName)){
                        sheetList.add(sheet);
                        index++;
                    }
                }
            }
        }
        return sheetList;
    }

    @Override
    public int searchJudgeCount(Integer sheetId, String paperName, String userName, Integer teacherId) {
        //首先找到该老师创建的所有试卷
        List<Sheet>sheetList=new ArrayList<>();
        List<Paper>paperList=new ArrayList<>();
        if(paperName.equals(""))
            paperList=paperService.findPaperByCreaterId(teacherId);
        else paperList=paperService.findPaperByCreaterIdBlur(teacherId,paperName);
        int index=0;
        for (Paper paper:paperList) {
            int paperId=paper.getId();
            SheetExample sheetExample=new SheetExample();
            SheetExample.Criteria criteria=sheetExample.createCriteria();
            if(sheetId!=-1)
                criteria.andPaperIdEqualTo(paperId);
            criteria.andStatusEqualTo(1);//所有未批改的试卷
            List<Sheet>sublist=new ArrayList<>();
            sublist=sheetMapper.selectByExample(sheetExample);
            for (Sheet sheet: sublist) {
                if(sheetId!=-1&&sheetId!=sheet.getId()){
                    continue;
                }
                //将试卷名称信息放置在答卷上
                sheet.setPaperName(paper.getPaperName());
                int userid=sheet.getUserId();
                User user=userService.findUserByUserId(userid);
                sheet.setUserName(user.getUserName());
                String name=user.getUserName();
                sheet.setRealName(user.getRealName());
                if(userName.equals("")||name.contains(userName))
                    index++;
            }
        }
        return index;
    }

    @Override
    public List<Sheet> searchGrade(Integer sheetId, String paperName, String userName, Integer teacherId, int before, int after) {
        //首先找到该老师创建的所有试卷
        List<Sheet>sheetList=new ArrayList<>();
        List<Paper>paperList=new ArrayList<>();
        if(paperName.equals(""))
            paperList=paperService.findPaperByCreaterId(teacherId);
        else paperList=paperService.findPaperByCreaterIdBlur(teacherId,paperName);
        int index=0;
        for (Paper paper:paperList) {
            int paperId=paper.getId();
            SheetExample sheetExample=new SheetExample();
            SheetExample.Criteria criteria=sheetExample.createCriteria();
            criteria.andPaperIdEqualTo(paperId);
            criteria.andStatusEqualTo(2);//所有已批改的试卷
            List<Sheet>sublist=new ArrayList<>();
            sublist=sheetMapper.selectByExample(sheetExample);
            for (Sheet sheet: sublist) {
                if(index>=before&&index<=before+after-1){
                    if(sheetId!=-1&&sheetId!=sheet.getId()){
                        continue;
                    }
                    //将试卷名称信息放置在答卷上
                    sheet.setPaperName(paper.getPaperName());
                    int userid=sheet.getUserId();
                    User user=userService.findUserByUserId(userid);
                    sheet.setUserName(user.getUserName());
                    String name=user.getUserName();
                    sheet.setRealName(user.getRealName());
                    if(userName.equals("")||name.contains(userName)){
                        sheetList.add(sheet);
                        index++;
                    }
                }
            }
        }
        return sheetList;
    }

    @Override
    public int searchGradeCount(Integer sheetId, String paperName, String userName, Integer teacherId) {
        //首先找到该老师创建的所有试卷
        List<Sheet>sheetList=new ArrayList<>();
        List<Paper>paperList=new ArrayList<>();
        if(paperName.equals(""))
            paperList=paperService.findPaperByCreaterId(teacherId);
        else paperList=paperService.findPaperByCreaterIdBlur(teacherId,paperName);
        int index=0;
        for (Paper paper:paperList) {
            int paperId=paper.getId();
            SheetExample sheetExample=new SheetExample();
            SheetExample.Criteria criteria=sheetExample.createCriteria();
            if(sheetId!=-1)
                criteria.andPaperIdEqualTo(paperId);
            criteria.andStatusEqualTo(2);//所有已批改的试卷
            List<Sheet>sublist=new ArrayList<>();
            sublist=sheetMapper.selectByExample(sheetExample);
            for (Sheet sheet: sublist) {
                if(sheetId!=-1&&sheetId!=sheet.getId()){
                    continue;
                }
                //将试卷名称信息放置在答卷上
                sheet.setPaperName(paper.getPaperName());
                int userid=sheet.getUserId();
                User user=userService.findUserByUserId(userid);
                sheet.setUserName(user.getUserName());
                String name=user.getUserName();
                sheet.setRealName(user.getRealName());
                if(userName.equals("")||name.contains(userName))
                    index++;
            }
        }
        return index;
    }

    @Override
    public boolean checkIsAnbswered(Integer userId, Integer paperId) {
        SheetExample sheetExample=new SheetExample();
        SheetExample.Criteria criteria=sheetExample.createCriteria();
        criteria.andPaperIdEqualTo(paperId);
        criteria.andUserIdEqualTo(userId);
        List<Sheet>sheetList=new ArrayList<>();
        sheetList=sheetMapper.selectByExample(sheetExample);
        if(sheetList==null||sheetList.size()==0){
            return false;
        }
        return true;
    }

    @Override
    public List<Sheet> findSheetWithJudgedAndKeyword(String field, String keyword) {
        SheetExample sheetExample=new SheetExample();
        SheetExample.Criteria criteria=sheetExample.createCriteria();
        criteria.andStatusEqualTo(2);

        List<Sheet>sheetList=new ArrayList<>();
        sheetExample.setOrderByClause("submit_time desc");
        sheetList=sheetMapper.selectByExample(sheetExample);
        List<Sheet>list=new ArrayList<>();
        for(Sheet sheet:sheetList){
            int userId=sheet.getUserId();
            int paperId=sheet.getPaperId();
            User doUser=new User();
            doUser=userService.findUserByUserId(userId);
            User judgeUser=new User();
            Paper paper=new Paper();
            paper=paperService.findPaperByPaperId(paperId);
            judgeUser=userService.findUserByUserId(paper.getCreaterId());
            if(field.equals("paperName")){
                if(!paper.getPaperName().contains(keyword))
                    continue;
            }else{
                if(!doUser.getUserName().contains(keyword))
                    continue;
            }
            sheet.setUserName(doUser.getUserName());
            sheet.setPaperName(paper.getPaperName());
            sheet.setJudgerName(judgeUser.getUserName());
            sheet.setPaperScore(paper.getTotalScore());
            list.add(sheet);
        }
        return list;
    }

    /**
     * 在答卷中查找考试人数最多的试卷
     * @return
     */
    @Override
    public Map<Integer, Integer> findHottestPaperInSheets() {
        SheetExample sheetExample=new SheetExample();
        SheetExample.Criteria criteria=sheetExample.createCriteria();
        criteria.andIdIsNotNull();
        List<Sheet>sheetList=new ArrayList<>();
        sheetList=sheetMapper.selectByExample(sheetExample);
        //根据试卷分组
        Map<Integer, List<Sheet>> dateListMap = sheetList.stream()
                .collect(Collectors.groupingBy(Sheet::getPaperId));
        // 遍历map,求出回答该套试卷的人数
        HashMap<Integer, Integer> resMap = new HashMap<>();
        for (Map.Entry<Integer, List<Sheet>> detailEntry:dateListMap.entrySet()){
            int daySize = detailEntry.getValue().size();
            resMap.put(detailEntry.getKey(),daySize);
        }
        // 按照人数排序
        Stream<Map.Entry<Integer, Integer>> st = resMap.entrySet().stream();
        Map<Integer, Integer> result = new LinkedHashMap<>();
        st.sorted((p1, p2) -> p2.getValue().compareTo(p1.getValue())).forEach(e -> result.put(e.getKey(), e.getValue()));//Comparator.comparing(e -> e.getValue())
        return result;//
    }

    @Override
    public List<Sheet> findAllSheet() {
        SheetExample sheetExample=new SheetExample();
        SheetExample.Criteria criteria=sheetExample.createCriteria();
        criteria.andIdIsNotNull();
        List<Sheet>sheetList=new ArrayList<>();
        sheetExample.setOrderByClause("submit_time desc");
        sheetList=sheetMapper.selectByExample(sheetExample);
        List<Sheet>list=new ArrayList<>();
        for(Sheet sheet:sheetList){
            int userId=sheet.getUserId();
            int paperId=sheet.getPaperId();
            User doUser=new User();
            doUser=userService.findUserByUserId(userId);
            User judgeUser=new User();
            Paper paper=new Paper();
            paper=paperService.findPaperByPaperId(paperId);
            judgeUser=userService.findUserByUserId(paper.getCreaterId());
            sheet.setUserName(doUser.getUserName());
            sheet.setPaperName(paper.getPaperName());
            sheet.setJudgerName(judgeUser.getUserName());
            list.add(sheet);
        }
        return list;
    }

    /**
     * 通过关键字查找答卷
     * @param field
     * @param keyword
     * @return
     */
    @Override
    public List<Sheet> findSheetWithKeyword(String field, String keyword) {
        SheetExample sheetExample=new SheetExample();
        SheetExample.Criteria criteria=sheetExample.createCriteria();
        criteria.andIdIsNotNull();
        List<Sheet>sheetList=new ArrayList<>();
        sheetExample.setOrderByClause("submit_time desc");
        sheetList=sheetMapper.selectByExample(sheetExample);
        List<Sheet>list=new ArrayList<>();
        for(Sheet sheet:sheetList){
            int userId=sheet.getUserId();
            int paperId=sheet.getPaperId();
            User doUser=new User();
            doUser=userService.findUserByUserId(userId);
            User judgeUser=new User();
            Paper paper=new Paper();
            paper=paperService.findPaperByPaperId(paperId);
            judgeUser=userService.findUserByUserId(paper.getCreaterId());
            if(field.equals("paperName")){
                if(!paper.getPaperName().contains(keyword))
                    continue;
            }else{
                if(!doUser.getUserName().contains(keyword))
                    continue;
            }
            sheet.setUserName(doUser.getUserName());
            sheet.setPaperName(paper.getPaperName());
            sheet.setJudgerName(judgeUser.getUserName());
            list.add(sheet);
        }
        return list;
    }

    /**
     * 删除答卷
     * 同时需要删除answer答题记录
     * @param sheetId
     */
    @Override
    public void deleteSheet(Integer sheetId) {
        Sheet sheet=findSheetById(sheetId);
        //最热考试的score-1
        String hottestkey="hottest:papers";
        RedisUtil.zSetincrementScore(hottestkey,sheet.getPaperId(),-1.0);
        answerService.deleteAnswerByPaperIdAndUserId(sheet.getPaperId(),sheet.getUserId());
        sheetMapper.deleteByPrimaryKey(sheetId);
    }
    @Override
    public void deleteBatch(List<Integer> del_ids) {
        SheetExample sheetExample=new SheetExample();
        SheetExample.Criteria criteria=sheetExample.createCriteria();
        criteria.andIdIn(del_ids);
        for(Integer sheetId:del_ids){
            Sheet sheet=findSheetById(sheetId);
            //最热考试的score-1
            String hottestkey="hottest:papers";
            RedisUtil.zSetincrementScore(hottestkey,sheet.getPaperId(),-1.0);
            //删除答题记录
            answerService.deleteAnswerByPaperIdAndUserId(sheet.getPaperId(),sheet.getUserId());
        }
        sheetMapper.deleteByExample(sheetExample);
    }

    /**
     * 打回重做
     * @param del_ids
     */
    @Override
    public void redoSheetBatch(List<Integer> del_ids) {
        for(Integer sheetId:del_ids){
            Sheet sheet=findSheetById(sheetId);
            int paperId=sheet.getPaperId();
            int studentId=sheet.getUserId();
            answerService.updateAnswerStatus1AndOtherInfo(studentId,paperId);//将状态设置为未批改
            String hottestkey="hottest:papers";
            RedisUtil.removeZSet(hottestkey,paperId);
            sheetMapper.deleteByPrimaryKey(sheetId);
        }
    }

    @Override
    public void redoSheet(Integer id) {
        Sheet sheet=findSheetById(id);
        int paperId=sheet.getPaperId();
        int studentId=sheet.getUserId();
        answerService.updateAnswerStatus1AndOtherInfo(studentId,paperId);//将状态设置为未批改
        String hottestkey="hottest:papers";
        RedisUtil.removeZSet(hottestkey,paperId);
        sheetMapper.deleteByPrimaryKey(id);
    }

    /**
     * 打回重新批改
     * @param del_ids
     */
    @Override
    public void reJudgeSheetBatch(List<Integer> del_ids) {
        for(Integer sheetId:del_ids){
            Sheet sheet=findSheetById(sheetId);
            int paperId=sheet.getPaperId();
            int studentId=sheet.getUserId();
            //更新答案的状态以及分数等信息
            answerService.updateAnswerStatus1AndOtherInfo(studentId,paperId);//将状态设置为未批改
            sheet.setStatus(1);
//            sheet.setScore(0);
            sheet.setComment("");
            //更新答卷的状态
            sheetMapper.updateByPrimaryKeySelective(sheet);
        }
    }

    @Override
    public void reJudgeSheet(Integer sheetId) {
        Sheet sheet=findSheetById(sheetId);
        int paperId=sheet.getPaperId();
        int studentId=sheet.getUserId();
        //更新答案的状态以及分数等信息
        answerService.updateAnswerStatus1AndOtherInfo(studentId,paperId);//将状态设置为未批改
        sheet.setStatus(1);
//        sheet.setScore(0);
        sheet.setComment("");
        //更新答卷的状态
        sheetMapper.updateByPrimaryKeySelective(sheet);
    }

    /**
     * 更新答卷的总分
     * 1. 首先找到答卷所属的所有试卷
     * 2. 遍历试卷，根据试卷id找到所有sheet
     * 3. 根据sheet的userid找到该题的score
     * 4. 减去对应sheet的score
     * @param problemId
     */
    @Override
    public void updateSheetScoreByProblemId(Integer problemId) {
        List<PaperQuestion>list=paperQuestionService.findItemByProblemId(problemId);
//        System.out.println("paperlist:"+list);
        for(PaperQuestion paperQuestion:list){
            Integer paperId=paperQuestion.getPaperId();
            List<Sheet> sheetList=findSheetByPaperId(paperId);//找到该包含该试卷所属的答卷
//            System.out.println("sheetList: "+sheetList+" paperId:"+paperId);
            for(Sheet sheet:sheetList){
                Sheet sheet1=new Sheet();
                sheet1.setId(sheet.getId());
                Integer userId=sheet.getUserId();
                Answer answer=answerService.findAnswerByUserProblemPaper(userId,problemId,paperId);
//                System.out.println("answer: "+answer+" userId:"+userId);
                if(answer!=null){
                    int score=0;
                    int origscore=sheet.getScore();
                    if(sheet.getScore()>answer.getScore()){
                        score=sheet.getScore()-answer.getScore();
                    }
                    sheet1.setScore(score);
                    sheetMapper.updateByPrimaryKeySelective(sheet1);//更新该答卷
                    System.out.println("更新"+userId+"提交的"+paperId+"试卷分数成功！"+score+"分,原来："+origscore+"分");
                }
            }
        }
    }

    @Override
    public List<Sheet> findSheetByPaperId(Integer paperId) {
        SheetExample sheetExample=new SheetExample();
        SheetExample.Criteria criteria=sheetExample.createCriteria();
        criteria.andPaperIdEqualTo(paperId);
        List<Sheet>sheetList=new ArrayList<>();
        sheetList=sheetMapper.selectByExample(sheetExample);
        return sheetList;
    }
    @Override
    public int getSheetScoreByPaperIdAndUserId(Integer paperId, Integer userId) {
        int score=0;
        List<Answer>answerList=answerService.findAnswerByPaperUser(paperId,userId);
        for(Answer answer:answerList){
            score+=answer.getScore();
        }
        return score;
    }

    /**
     * 更新试卷分数
     * @param paperId
     * @param userId
     */
    @Override
    public void updateSheetScoreByPaperIdAndUserId(Integer paperId, Integer userId) {
        int score=0;
        List<Answer>answerList=answerService.findAnswerByPaperUser(paperId,userId);
        for(Answer answer:answerList){
            score+=answer.getScore();
        }
        SheetExample sheetExample=new SheetExample();
        SheetExample.Criteria criteria=sheetExample.createCriteria();
        criteria.andPaperIdEqualTo(paperId);
        criteria.andUserIdEqualTo(userId);
        List<Sheet>sheetList=new ArrayList<>();
        sheetList=sheetMapper.selectByExample(sheetExample);
        for(Sheet sheet:sheetList){
            sheet.setScore(score);
            sheetMapper.updateByPrimaryKeySelective(sheet);
        }
    }
}
