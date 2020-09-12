package com.wale.exam.controller;

import com.github.pagehelper.PageInfo;
import com.wale.exam.bean.*;
import com.wale.exam.service.*;
import com.wale.exam.util.JsonDateValueProcessor;
import com.wale.exam.util.MyPageInfo;
import com.wale.exam.util.RedisUtil;
import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;
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
 * @Date 2020/8/11 15:34
 */
@Controller
public class SheetController {
    @Autowired
    SheetService sheetService;
    @Autowired
    PaperService paperService;
    @Autowired
    ProblemService problemService;
    @Autowired
    AnswerService answerService;
    @Autowired
    UserService userService;
    /**
     * 提交答卷
     * @param userId
     * @param paperId
     * @param session
     * @return
     */
    @RequestMapping("/submitPaper")
    @ResponseBody
    public Msg submitPaper(Integer userId, Integer paperId, HttpSession session){
        System.out.println(userId+" "+paperId);
        //加入缓存
        String hottestkey="hottest:papers";
        RedisUtil.zSetincrementScore(hottestkey,paperId,1.0);
        sheetService.addSheet(userId,paperId);
        return Msg.success();
    }

    /**
     * 寻找所有未批改的试卷
     * @param teacherId
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping(value="/findSheetByTeaId",produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public String findSheetByTeaId(@RequestParam("teacherId")Integer teacherId, int page, int limit){
        int before = limit * (page - 1);
        int after = limit;//page * limit
        //带参数从数据库里查询出来放到eilist的集合里
        List<Sheet> eilist = sheetService.findSheetByTeaId(teacherId,before, after);
        int count = sheetService.findSheetCountByTeaId(teacherId);
        //用json来传值
        JsonConfig jsonConfig = new JsonConfig();
        jsonConfig.registerJsonValueProcessor(Date.class , new JsonDateValueProcessor());
        JSONArray json = JSONArray.fromObject(eilist, jsonConfig);
        String js = json.toString();
        //*****转为layui需要的json格式，必须要这一步，博主也是没写这一步，在页面上数据就是数据接口异常
        String jso = "{\"code\":0,\"msg\":\"\",\"count\":"+count+",\"data\":"+js+"}";
        return jso;
    }

    /**
     * 寻找所有已经批改了的试卷
     * @param teacherId
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping(value="/findJudgedSheetByTeaId",produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public String findJudgedSheetByTeaId(@RequestParam("teacherId")Integer teacherId, int page, int limit){
        int before = limit * (page - 1);
        int after = limit;//page * limit
        //带参数从数据库里查询出来放到eilist的集合里
        List<Sheet> eilist = sheetService.findJudgedSheetByTeaId(teacherId,before, after);
        int count = sheetService.findJudgedSheetCountByTeaId(teacherId);
        //用json来传值
        JsonConfig jsonConfig = new JsonConfig();
        jsonConfig.registerJsonValueProcessor(Date.class , new JsonDateValueProcessor());
        JSONArray json = JSONArray.fromObject(eilist, jsonConfig);
        String js = json.toString();
        //*****转为layui需要的json格式，必须要这一步，博主也是没写这一步，在页面上数据就是数据接口异常
        String jso = "{\"code\":0,\"msg\":\"\",\"count\":"+count+",\"data\":"+js+"}";
        return jso;
    }

    /**
     * 找到指定的一张答卷，并将答卷的信息放入model中
     * @param sheetId
     * @param model
     * @return
     */
    @RequestMapping("/theSheet")
    public String getPerfectMains(@RequestParam("sheetId")Integer sheetId, Model model){
        Sheet sheet=new Sheet();
        sheet=sheetService.findSheetById(sheetId);
        int paperId=sheet.getPaperId();//获取这份答卷的试卷id
        int userId=sheet.getUserId();//获取这份试卷的答卷人id
        Paper paper=new Paper();
        paper=paperService.findPaperByPaperId(paperId);
        model.addAttribute("paper",paper);
        model.addAttribute("paperId",paperId);
        model.addAttribute("sheet",sheet);
        model.addAttribute("sheetId",sheetId);
        model.addAttribute("studentId",sheet.getUserId());
        //获取总分数
        Integer totalScore;
        totalScore=answerService.computeTotalScore(userId,paperId);
        model.addAttribute("totalScore",totalScore);

        return "onJudge";
    }

    @RequestMapping("/theScoreSheetRecord")
    public String theScoreSheetRecord(@RequestParam("sheetId")Integer sheetId, Model model){
        Sheet sheet=new Sheet();
        sheet=sheetService.findSheetById(sheetId);
        int paperId=sheet.getPaperId();//获取这份答卷的试卷id
        int userId=sheet.getUserId();//获取这份试卷的答卷人id
        Paper paper=new Paper();
        paper=paperService.findPaperByPaperId(paperId);
        model.addAttribute("paper",paper);
        model.addAttribute("paperId",paperId);
        model.addAttribute("sheet",sheet);
        model.addAttribute("sheetId",sheetId);
        model.addAttribute("studentId",sheet.getUserId());
        //获取总分数
        Integer totalScore;
        totalScore=answerService.computeTotalScore(userId,paperId);
        model.addAttribute("totalScore",totalScore);
        return "examScoreDetail";
    }

    /**
     * 找到一张答卷的所有题目和题目相关信息
     * @param paperId
     * @param studentId
     * @param session
     * @param model
     * @return
     * @throws ParseException
     */
    @RequestMapping("/theAllProblemAndAnswer")
    @ResponseBody
    public Msg theAllProblemAndAnswer(@RequestParam("paperId") Integer paperId, @RequestParam("studentId") Integer studentId, HttpSession session,Model model) throws ParseException {
        List<Problem>radioProList=new ArrayList<>();
        List<Problem>mulProList=new ArrayList<>();
        List<Problem>judgeProList=new ArrayList<>();
        List<Problem>blankProList=new ArrayList<>();//填空题
        List<Problem>shortProList=new ArrayList<>();//简答题
        Integer userid=studentId;
        radioProList=problemService.findProblemByPaperIdAndType(paperId,1,userid);
        mulProList=problemService.findProblemByPaperIdAndType(paperId,2,userid);
        judgeProList=problemService.findProblemByPaperIdAndType(paperId,3,userid);
        blankProList=problemService.findProblemByPaperIdAndType(paperId,4,userid);
        shortProList=problemService.findProblemByPaperIdAndType(paperId,5,userid);
        Map<String, Object> extend=new HashMap<>();
        extend.put("radioProList",radioProList);
        extend.put("mulProList",mulProList);
        extend.put("judgeProList",judgeProList);
        extend.put("blankProList",blankProList);
        extend.put("shortProList",shortProList);
        Msg msg=new Msg();
        msg.setExtend(extend);
        msg.setCode(100);
        return msg;
    }

    /**
     * 提交判卷---包括总成绩和评语
     * @param userId
     * @param paperId
     * @param score
     * @param comment
     * @param session
     * @return
     */
    @RequestMapping("/submitJudge")
    @ResponseBody
    public Msg submitJudge(Integer userId, Integer paperId, Integer score, String comment, HttpSession session){
        System.out.println(userId+" "+paperId+" "+score+" "+comment);
        sheetService.addSheetJudge(userId,paperId,score,comment);
        return Msg.success();
    }

    /**
     * 判断用户是否已经答过这套试卷了
     * @param userId
     * @param paperId
     * @param session
     * @return
     * @throws ParseException
     */
    @RequestMapping("/checkExam")
    @ResponseBody
    public Msg checkExam(Integer userId, Integer paperId, HttpSession session) throws ParseException {
        System.out.println(userId+" "+paperId);
        //判断该用户是否已经答卷了
        List<Sheet>list=new ArrayList<>();
        list=sheetService.findSheetByUserIdAndPaperId(userId,paperId);
        if(list==null||list.size()==0)
            return Msg.success();
        else return Msg.fail();
    }

    /**
     * 查找用户已经完成的考试
     * @param pn
     * @param session
     * @return
     */
    @RequestMapping("/findHasDone")
    @ResponseBody//记得一定要加上这个注解
    public Msg findHasDone(@RequestParam(value = "pn",defaultValue = "1")Integer pn,HttpSession session){
        List<Sheet> list=new ArrayList<Sheet>();
        int userId=(int)session.getAttribute("userid");
        list=sheetService.findAllSheetsWithUserHasDone(userId);
        //分页信息
        PageInfo page= MyPageInfo.getPageInfo(pn,4,list);
        return Msg.success().add("pageInfo",page).add("sheetlist",list);
    }
    @RequestMapping(value="/searchJudge",produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public String searchJudge(Integer sheetId, String paperName, String userName, Integer teacherId, int page, int limit){
        int before = limit * (page - 1);
        int after = limit;//page * limit
        //带参数从数据库里查询出来放到eilist的集合里
        List<Sheet> eilist = sheetService.searchJudge(sheetId, paperName,userName,teacherId,before, after);
//        System.out.println(eilist.size());
        int count = sheetService.searchJudgeCount(sheetId, paperName,userName,teacherId);
        //用json来传值
        JsonConfig jsonConfig = new JsonConfig();
        jsonConfig.registerJsonValueProcessor(Date.class , new JsonDateValueProcessor());
        JSONArray json = JSONArray.fromObject(eilist, jsonConfig);
        String js = json.toString();
        //*****转为layui需要的json格式，必须要这一步，博主也是没写这一步，在页面上数据就是数据接口异常
        String jso = "{\"code\":0,\"msg\":\"\",\"count\":"+count+",\"data\":"+js+"}";
        return jso;
    }
    @RequestMapping(value="/searchGrade",produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public String searchGrade(Integer sheetId, String paperName, String userName, Integer teacherId, int page, int limit){
        int before = limit * (page - 1);
        int after = limit;//page * limit
        //带参数从数据库里查询出来放到eilist的集合里
        List<Sheet> eilist = sheetService.searchGrade(sheetId, paperName,userName,teacherId,before, after);
//        System.out.println(eilist.size());
        int count = sheetService.searchGradeCount(sheetId, paperName,userName,teacherId);
        System.out.println(count);
        //用json来传值
        JsonConfig jsonConfig = new JsonConfig();
        jsonConfig.registerJsonValueProcessor(Date.class , new JsonDateValueProcessor());
        JSONArray json = JSONArray.fromObject(eilist, jsonConfig);
        String js = json.toString();
        //*****转为layui需要的json格式，必须要这一步，博主也是没写这一步，在页面上数据就是数据接口异常
        String jso = "{\"code\":0,\"msg\":\"\",\"count\":"+count+",\"data\":"+js+"}";
        return jso;
    }

    @RequestMapping("/toEditGrade")
    public String toEditGrade(Integer sheetId, Model model, HttpSession session){
        System.out.println("修改成绩："+sheetId);
        session.setAttribute("sheetId",sheetId);
        Sheet sheet=sheetService.findSheetById(sheetId);
        session.setAttribute("sheet",sheet);
        Integer paperId=sheet.getPaperId();
        Paper paper=paperService.findPaperByPaperId(paperId);
        User user=userService.findUserByUserId(sheet.getUserId());
        session.setAttribute("user",user);
        session.setAttribute("paper",paper);
        session.setAttribute("totalScore",paper.getTotalScore());
        return "editGrade";
    }

    @RequestMapping("/updateGrade")
    @ResponseBody
    public Msg updateGrade(Integer sheetId, Integer score, HttpSession session) throws ParseException {
        System.out.println("修改成绩："+sheetId+" "+score);
        Sheet sheet=new Sheet();
        sheet.setId(sheetId);
        sheet.setScore(score);
        sheetService.updateSheet(sheet);
        return Msg.success();
    }

    @RequestMapping("/deleteGrade")
    @ResponseBody
    public Msg deleteGrade(Integer sheetId, HttpSession session) throws ParseException {
        System.out.println("删除成绩："+sheetId);
        Sheet sheet=new Sheet();
        sheet.setId(sheetId);
        sheet.setStatus(1);//设置为未批改状态
        sheetService.updateSheet(sheet);
        Sheet grade=sheetService.findSheetById(sheetId);
        int userid=grade.getUserId();
        int paperid=grade.getPaperId();
        answerService.updateAnswerStatus1(userid,paperid);
        return Msg.success();
    }
    @RequestMapping("/checkIsAnswer")
    @ResponseBody
    public Msg checkIsAnswer(Integer userId, Integer paperId, HttpSession session,Model model) throws ParseException {
        boolean flag=sheetService.checkIsAnbswered(userId,paperId);
        if(flag){//已经交卷了也就是答题了
            return Msg.success();
        }
        return Msg.fail();
    }
}
