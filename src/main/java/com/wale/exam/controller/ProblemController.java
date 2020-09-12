package com.wale.exam.controller;

import com.wale.exam.bean.Msg;
import com.wale.exam.bean.Paper;
import com.wale.exam.bean.PaperQuestion;
import com.wale.exam.bean.Problem;
import com.wale.exam.bean.question.QuestionItemObject;
import com.wale.exam.bean.question.QuestionObject;
import com.wale.exam.service.PaperService;
import com.wale.exam.service.ProblemService;
import com.wale.exam.util.JsonDateValueProcessor;
import com.wale.exam.util.JsonUtil;
import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;
import org.apache.commons.lang.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @Author WaleGarrett
 * @Date 2020/8/9 10:17
 */
@Controller
public class ProblemController {
    @Autowired
    ProblemService problemService;
    @Autowired
    PaperService paperService;
    /**
     * 根据创建者的id查找所有该老师创建的试卷
     * @param teacherId
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping(value="/findProblemPageByTeaId",produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public String findProblemPageByTeaId(@RequestParam("teacherId")Integer teacherId, String keyword, int page, int limit){
        System.out.println(keyword);
        int before = limit * (page - 1);
        int after = limit;//page * limit
        List<Problem> eilist;
        int count;
        if(keyword==null){
            //带参数从数据库里查询出来放到eilist的集合里
            eilist = problemService.findProblemByTeaId(teacherId,before, after);
            count = problemService.findProblemCountByTeaId(teacherId);
        }else{
            //带关键字的模糊查询
            eilist = problemService.findProblemByTeaId(teacherId,keyword,before, after);
            count = problemService.findProblemCountByTeaId(teacherId,keyword);
        }
        //用json来传值
        JsonConfig jsonConfig = new JsonConfig();
        jsonConfig.registerJsonValueProcessor(Date.class , new JsonDateValueProcessor());

        JSONArray json = JSONArray.fromObject(eilist, jsonConfig);
        String js = json.toString();
        //*****转为layui需要的json格式，必须要这一步，博主也是没写这一步，在页面上数据就是数据接口异常
        String jso = "{\"code\":0,\"msg\":\"\",\"count\":"+count+",\"data\":"+js+"}";
        return jso;
    }

    @RequestMapping("/addProblem")
    @ResponseBody
    public Msg addProblem(Integer teacherId, String titleContent, String answer, Integer score, Integer type, String analysis, String optionA, String optionB, String optionC, String optionD, HttpSession session) throws ParseException {
        System.out.println("新增题目："+teacherId+" "+titleContent+" "+answer+" "+type+" "+score+" "+analysis);
        Map<String,Object> map=new HashMap<>();//用来存储错误的字段
        Problem problem=new Problem();
        problem.setAnswer(answer);
        problem.setType(type);
        problem.setScore(score);
        problem.setCreateTime(new Date());
        problem.setCreaterId(teacherId);
        problem.setAnalysis(analysis);
        String content;
        QuestionObject questionObject=new QuestionObject();
        questionObject.setTitleContent(titleContent);
        questionObject.setAnalyze(analysis);
        questionObject.setCorrect(answer);
        List<QuestionItemObject>questionItemObjectList=new ArrayList<>();
        questionItemObjectList.add(new QuestionItemObject("A",optionA,0));
        questionItemObjectList.add(new QuestionItemObject("B",optionB,0));
        questionItemObjectList.add(new QuestionItemObject("C",optionC,0));
        questionItemObjectList.add(new QuestionItemObject("D",optionD,0));
        questionObject.setQuestionItemObjects(questionItemObjectList);
        //用json来传值
        JsonConfig jsonConfig = new JsonConfig();
        jsonConfig.registerJsonValueProcessor(Date.class , new JsonDateValueProcessor());
        JSONArray json = JSONArray.fromObject(questionObject, jsonConfig);
        String js = json.toString();
        String jso = js.substring(1,js.length()-1);
        System.out.println(jso);
        problem.setContent(jso);
        problemService.addProblem(problem);
        return Msg.success();
    }
    /**
     * 测试json数据
     * @return
     */
    @RequestMapping(value="/testJson")
    public String testJson(Model model){
        int before = 0;
        int after = 10;//page * limit
        //带参数从数据库里查询出来放到eilist的集合里
        List<Problem> eilist = problemService.findProblemByTeaId(2,before, after);
        List<String>list=new ArrayList<>();
        for(Problem problem:eilist){
            list.add(problem.getContent());
        }
        //用json来传值
        JsonConfig jsonConfig = new JsonConfig();
        //jsonConfig.setExcludes(new String[] {"content"});//忽略字段
        jsonConfig.registerJsonValueProcessor(Date.class , new JsonDateValueProcessor());
        JSONArray json = JSONArray.fromObject(list, jsonConfig);
        String js = json.toString();
        //String js= JsonUtil.toJsonStr(eilist);
        String jso = "{\"concreteItem\":"+js+"}";
        System.out.println(jso);
        model.addAttribute("jsonData",jso);
        return "testJson";
    }
    /**
     * 测试json数据
     * @return
     */
    @RequestMapping(value="/testJson1"/*,produces = {"application/json;charset=UTF-8"}*/)
//    @ResponseBody
    public String testJson1(Model model){
        List<Problem>radioProList=new ArrayList<>();

        radioProList=problemService.findProblemByPaperIdAndType(24,1,1);
//        model.addAttribute("radioProList1",radioProList);
        Map<String, Object> extend=new HashMap<>();
        extend.put("radioProList",radioProList);

//        JsonConfig jsonConfig = new JsonConfig();
//        jsonConfig.registerJsonValueProcessor(Date.class , new JsonDateValueProcessor());
//        JSONArray json = JSONArray.fromObject(msg, jsonConfig);
//        String js = json.toString();
        model.addAttribute("content",radioProList.get(0).getContent());
        return "testJson";
    }

    /**
     * 查找试卷中的所有题目---分题目类型查询
     * @param paperId
     * @param session
     * @param model
     * @return
     * @throws ParseException
     */
    @RequestMapping("/theAllProblem")
    @ResponseBody
    public Msg theAllProblem(@RequestParam("paperId") Integer paperId, @RequestParam("userId") Integer userId, HttpSession session,Model model) throws ParseException {
        List<Problem>radioProList=new ArrayList<>();
        List<Problem>mulProList=new ArrayList<>();
        List<Problem>judgeProList=new ArrayList<>();
        List<Problem>blankProList=new ArrayList<>();//填空题
        List<Problem>shortProList=new ArrayList<>();//简答题
        Integer userid=userId;
        radioProList=problemService.findProblemByPaperIdAndType(paperId,1,userid);
        mulProList=problemService.findProblemByPaperIdAndType(paperId,2,userid);
        judgeProList=problemService.findProblemByPaperIdAndType(paperId,3,userid);
        blankProList=problemService.findProblemByPaperIdAndType(paperId,4,userid);
        shortProList=problemService.findProblemByPaperIdAndType(paperId,5,userid);
//        model.addAttribute("radioProList1",radioProList);
        Map<String, Object> extend=new HashMap<>();
        extend.put("radioProList",radioProList);
        extend.put("mulProList",mulProList);
        extend.put("judgeProList",judgeProList);
        extend.put("blankProList",blankProList);
        extend.put("shortProList",shortProList);


//        System.out.println(mulProList.toString());
        Msg msg=new Msg();
        msg.setExtend(extend);
        msg.setCode(100);
        return msg;
    }

    @RequestMapping("/toEditProblem")
    public String toEditProblem(Integer problemId, Model model, HttpSession session){
        System.out.println("编辑题目："+problemId);
        session.setAttribute("problemId",problemId);
        Problem problem=problemService.findProblemByProblemId(problemId);
        session.setAttribute("problem",problem);
        session.setAttribute("content",problem.getContent());
        session.setAttribute("analysis",problem.getAnalysis());
        session.setAttribute("score",problem.getScore());
        session.setAttribute("type",problem.getType());
        session.setAttribute("answer",problem.getAnswer());
        return "editProblem";
    }

    /**
     * 更新题目
     * @param teacherId
     * @param titleContent
     * @param answer
     * @param score
     * @param type
     * @param analysis
     * @param optionA
     * @param optionB
     * @param optionC
     * @param optionD
     * @param session
     * @return
     * @throws ParseException
     */
    @RequestMapping("/updateProblem")
    @ResponseBody
    public Msg updateProblem(Integer problemId, Integer teacherId, String titleContent, String answer, Integer score, Integer type, String analysis, String optionA, String optionB, String optionC, String optionD, HttpSession session) throws ParseException {
        System.out.println("更新题目："+teacherId+" "+titleContent+" "+answer+" "+type+" "+score+" "+analysis);

        Map<String,Object> map=new HashMap<>();//用来存储错误的字段
        Problem problem=new Problem();
        problem.setAnswer(answer);
        problem.setType(type);
        problem.setScore(score);
//        problem.setCreateTime(new Date());
        problem.setCreaterId(teacherId);
        problem.setAnalysis(analysis);
        String content;
        QuestionObject questionObject=new QuestionObject();
        questionObject.setTitleContent(titleContent);
        questionObject.setAnalyze(analysis);
        questionObject.setCorrect(answer);
        List<QuestionItemObject>questionItemObjectList=new ArrayList<>();
        questionItemObjectList.add(new QuestionItemObject("A",optionA,0));
        questionItemObjectList.add(new QuestionItemObject("B",optionB,0));
        questionItemObjectList.add(new QuestionItemObject("C",optionC,0));
        questionItemObjectList.add(new QuestionItemObject("D",optionD,0));
        questionObject.setQuestionItemObjects(questionItemObjectList);
        //用json来传值
        JsonConfig jsonConfig = new JsonConfig();
        jsonConfig.registerJsonValueProcessor(Date.class , new JsonDateValueProcessor());
        JSONArray json = JSONArray.fromObject(questionObject, jsonConfig);
        String js = json.toString();
        String jso = js.substring(1,js.length()-1);
        System.out.println(jso);
        problem.setContent(jso);
        problem.setId(problemId);
        problemService.updateProblem(problem);
        return Msg.success();
    }

    @RequestMapping(value="/searchProblem",produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public String searchProblem(Integer teacherId, Integer id, Integer type,int page, int limit){
        System.out.println(id+" "+type+" "+page+" "+limit);
//        int page=1,limit=2;
        int before = limit * (page - 1);
        int after = limit;//page * limit

        //带参数从数据库里查询出来放到eilist的集合里
        List<Problem> eilist = problemService.searchProblem(teacherId, id,type,before, after);
        int count = problemService.searchProblemCount(teacherId, id,type);
        //用json来传值
        JsonConfig jsonConfig = new JsonConfig();
        jsonConfig.registerJsonValueProcessor(Date.class , new JsonDateValueProcessor());

        JSONArray json = JSONArray.fromObject(eilist, jsonConfig);
        String js = json.toString();
        //*****转为layui需要的json格式，必须要这一步，博主也是没写这一步，在页面上数据就是数据接口异常
        String jso = "{\"code\":0,\"msg\":\"\",\"count\":"+count+",\"data\":"+js+"}";
        return jso;
    }
    @RequestMapping("/deleteProblem")
    @ResponseBody
    public Msg deleteProblem(Integer problemId, HttpSession session) throws ParseException {
        System.out.println("删除题目："+problemId);
        problemService.deleteProblem(problemId);
        return Msg.success();
    }
}
