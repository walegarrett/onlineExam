package com.wale.exam.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wale.exam.bean.*;
import com.wale.exam.service.PaperQuestionService;
import com.wale.exam.service.PaperService;
import com.wale.exam.service.ProblemService;
import com.wale.exam.util.JsonDateValueProcessor;
import com.wale.exam.util.MyPageInfo;
import com.wale.exam.util.RedisUtil;
import com.wale.exam.util.dateUtil;
import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import static javafx.scene.input.KeyCode.T;

/**
 * @Author WaleGarrett
 * @Date 2020/8/8 11:25
 */
@Controller
public class PaperController {
    @Autowired
    PaperService paperService;
    @Autowired
    ProblemService problemService;
    @Autowired
    PaperQuestionService paperQuestionService;
    /**
     * 根据创建者的id查找所有该老师创建的试卷
     * @param teacherId
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping(value="/findPaperPageByTeaId",produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public String findPaperPageByTeaId(@RequestParam("teacherId")Integer teacherId, int page, int limit){
        int before = limit * (page - 1);
        int after = limit;//page * limit
        //带参数从数据库里查询出来放到eilist的集合里
        List<Paper> eilist = paperService.findPaperByTeaId(teacherId,before, after);
        int count = paperService.findPaperCountByTeaId(teacherId);
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
     * 添加试卷
     * @param teacherId
     * @param paperName
     * @param startTime
     * @param durationTime
     * @param isEncry
     * @param inviCode
     * @param problems
     * @param session
     * @return
     * @throws ParseException
     */
    @RequestMapping("/addPaper")
    @ResponseBody
    public Msg publishMain(Integer teacherId, String paperName, String startTime, Integer durationTime, Integer isEncry, String inviCode, String problems, HttpSession session) throws ParseException {
        System.out.println("新增试卷："+teacherId+" "+paperName+" "+startTime+" "+durationTime+" "+isEncry+" "+inviCode);
        Map<String,Object> map=new HashMap<>();//用来存储错误的字段
        Paper paper=new Paper();
        paper.setQuestionCount(0);
        paper.setIsEncry(isEncry);
        //时间转换：前端传来的格式为2020-08-09T09:56
        String startTimes=startTime.substring(0,10)+"-"+startTime.substring(11,16);
        SimpleDateFormat formatter = new SimpleDateFormat( "yyyy-MM-dd-HH:mm");
        Date start = formatter.parse(startTimes);
        paper.setStartTime(start);
        paper.setDurationTime(durationTime);
        paper.setCreaterId(teacherId);
        paper.setInviCode(inviCode);
        Date endTime=new Date(start.getTime()+1000*60*durationTime);
        paper.setEndTime(endTime);
        paper.setPaperName(paperName);
        paper.setCreateTime(new Date());
        //获取用户输入的组成该试卷的题目id
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
        paper.setIsEncry(isEncry);
        //System.out.println(start+" "+endTime);
        //新建试卷
        paperService.addPaperWithoutProblems(paper);
        //获取刚刚新建的试卷的id
        int paperId=paperService.findLastRecordByCreaterId(teacherId);
        for(String item:problem){
            int proId=Integer.parseInt(item);
            //插入试卷-题目联系表
            paperQuestionService.addItem(paperId,proId);
        }
        return Msg.success();
    }

    /**
     * 查找所有的试卷
     * @param session
     * @return
     */
    @RequestMapping("/findAllPaper")
    @ResponseBody//记得一定要加上这个注解
    public Msg findAll(@RequestParam(value = "pn",defaultValue = "1")Integer pn,HttpSession session){
        int userId=(int)session.getAttribute("userid");
        //引入分页插件,在查询之前只需要调用，传入页码，以及每页的大小
//        PageHelper.startPage(pn,2);
        List<Paper> list=paperService.findAllPapersWithUser(userId);

        System.out.println(list.toString());
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就可以了
//        PageInfo page=new PageInfo(list,3);
        PageInfo page= MyPageInfo.getPageInfo(pn,4,list);
        System.out.println(page.getTotal());
        return Msg.success().add("pageInfo",page).add("paperlist",list);
    }
    @RequestMapping("/findNotStartPaper")
    @ResponseBody//记得一定要加上这个注解
    public Msg findNotStartPaper(@RequestParam(value = "pn",defaultValue = "1")Integer pn,HttpSession session){
        //引入分页插件,在查询之前只需要调用，传入页码，以及每页的大小
//        PageHelper.startPage(pn,1);
        List<Paper> list=new ArrayList<Paper>();
        int userId=(int)session.getAttribute("userid");
        list=paperService.findAllPapersWithUserNotStart(userId);
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就可以了
        PageInfo page= MyPageInfo.getPageInfo(pn,4,list);
        return Msg.success().add("pageInfo",page).add("paperlist",list);
    }
    @RequestMapping("/findHasEndPaper")
    @ResponseBody//记得一定要加上这个注解
    public Msg findHasEndPaper(@RequestParam(value = "pn",defaultValue = "1")Integer pn,HttpSession session){
        //引入分页插件,在查询之前只需要调用，传入页码，以及每页的大小
//        PageHelper.startPage(pn,1);
        List<Paper> list=new ArrayList<Paper>();
        int userId=(int)session.getAttribute("userid");
        list=paperService.findAllPapersWithUserHasEnd(userId);
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就可以了
        PageInfo page= MyPageInfo.getPageInfo(pn,4,list);
        return Msg.success().add("pageInfo",page).add("paperlist",list);
    }
    @RequestMapping("/findDuringPaper")
    @ResponseBody//记得一定要加上这个注解
    public Msg findDuringPaper(@RequestParam(value = "pn",defaultValue = "1")Integer pn,HttpSession session){
        //引入分页插件,在查询之前只需要调用，传入页码，以及每页的大小
//        PageHelper.startPage(pn,1);
        List<Paper> list=new ArrayList<Paper>();
        int userId=(int)session.getAttribute("userid");
        list=paperService.findAllPapersWithUserDuring(userId);
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就可以了
        PageInfo page= MyPageInfo.getPageInfo(pn,4,list);
        return Msg.success().add("pageInfo",page).add("paperlist",list);
    }


    /**
     * 根据试卷id查找该张试卷的信息，包括试卷中的每道题目
     * @param paperId
     * @param model
     * @return
     */
    @RequestMapping("/thePaper")
    public String getPerfectMains(@RequestParam("paperId")Integer paperId, Model model){
        Paper paper=new Paper();
        paper=paperService.findPaperByPaperId(paperId);
        model.addAttribute("paper",paper);
        model.addAttribute("paperId",paperId);
        model.addAttribute("hour",paper.getDurationTime()/60);
        model.addAttribute("minute",paper.getDurationTime()%60);
        Date deadline=paper.getEndTime();
        Date now=new Date();
        long diff=deadline.getTime()-now.getTime();
        long min = diff /60/1000;// 计算差多少分钟
        model.addAttribute("avaHour",min/60);
        model.addAttribute("avaMinute",min%60);
        return "online";
    }
    //跳转到试卷详情页面
    @RequestMapping(value = "/showPaperDetail")
    public  String showPaperDetail(Integer paperId, HttpServletRequest request, HttpSession session, Model model) throws UnsupportedEncodingException {
        model.addAttribute("paperId",paperId);
        Paper paper=new Paper();
        paper=paperService.findPaperByPaperId(paperId);
        model.addAttribute("paper",paper);
        return "showPaperDetail";
    }
    /**
     * 找到答卷记录----未修改的
     * @param paperId
     * @param model
     * @return
     */
    @RequestMapping("/theSheetRecord")
    public String theSheetRecord(@RequestParam("paperId")Integer paperId,@RequestParam("userId")Integer userId, Model model){
        Paper paper=new Paper();
        paper=paperService.findPaperByPaperId(paperId);
        model.addAttribute("paper",paper);
        model.addAttribute("paperId",paperId);
        model.addAttribute("hour",paper.getDurationTime()/60);
        model.addAttribute("minute",paper.getDurationTime()%60);
        Date deadline=paper.getEndTime();
        Date now=new Date();
        long diff=deadline.getTime()-now.getTime();
        long min = diff /60/1000;// 计算差多少分钟
        model.addAttribute("avaHour",min/60);
        model.addAttribute("avaMinute",min%60);
        model.addAttribute("userId",userId);
        return "examDetail";
    }
    @RequestMapping("/checkInviCode")
    @ResponseBody
    public Msg checkExam(Integer paperId, String code, HttpSession session) throws ParseException {
        //判断用户输入的邀请码是否正确
        Paper paper=new Paper();
        paper=paperService.findPaperByPaperId(paperId);
        if(paper.getInviCode().equals(code))
            return Msg.success();
        else return Msg.fail();
    }
    /**
     * 编辑试卷
     */
    @RequestMapping("/toEditPaper")
    public String toAdminPost(Integer paperId, Model model, HttpSession session){
        System.out.println("编辑试卷："+paperId);
        session.setAttribute("paperId",paperId);
        Paper paper=paperService.findPaperByPaperId(paperId);
        List<PaperQuestion>paperQuestionList=paperQuestionService.findItemByPaperId(paperId);
        String problems="";
        for(PaperQuestion paperQuestion:paperQuestionList){
            Integer problemId=paperQuestion.getQuestionId();
            problems+=problemId;
            problems+=",";
        }
        session.setAttribute("paper",paper);
        Date start=paper.getStartTime();
        String startTime1 = new SimpleDateFormat("yyyy-MM-dd").format(start).toString();
        String startTime2 = new SimpleDateFormat("HH:mm:ss").format(start).toString();
        String startTime=startTime1+"T"+startTime2;
        session.setAttribute("startTime",startTime);
        session.setAttribute("problems",problems.substring(0,problems.length()-1));
        return "editPaper";
    }

    @RequestMapping("/updatePaper")
    @ResponseBody
    public Msg updatePaper(Integer paperId, Integer teacherId, String paperName, String startTime, Integer durationTime, Integer isEncry, String inviCode, String problems, HttpSession session) throws ParseException {
        System.out.println("更新试卷："+paperId+" "+teacherId+" "+paperName+" "+startTime+" "+durationTime+" "+isEncry+" "+inviCode);
        Map<String,Object> map=new HashMap<>();//用来存储错误的字段

        Paper paper=new Paper();
        paper.setQuestionCount(0);
        paper.setIsEncry(isEncry);
        //时间转换：前端传来的格式为2020-08-09T09:56
        String startTimes=startTime.substring(0,10)+"-"+startTime.substring(11,16);
        SimpleDateFormat formatter = new SimpleDateFormat( "yyyy-MM-dd-HH:mm");
        Date start = formatter.parse(startTimes);
        paper.setId(paperId);
        paper.setStartTime(start);
        paper.setDurationTime(durationTime);
        paper.setCreaterId(teacherId);
        paper.setInviCode(inviCode);
        Date endTime=new Date(start.getTime()+1000*60*durationTime);
        paper.setEndTime(endTime);
        paper.setPaperName(paperName);
//        paper.setCreateTime(new Date());
        paper.setIsEncry(isEncry);
        paperService.updatePaper(paper,problems);
        return Msg.success();
    }

    /**
     * 查找最近创建的帖子
     * @param session
     * @return
     */
    @RequestMapping("/findPaperInIndex")
    @ResponseBody//记得一定要加上这个注解
    public Msg findPaperInIndex(HttpSession session){
        List<Paper> list=paperService.findAllPaper();
//        List<Paper> list=paperService.findAllPaperWithNoEncry();
        return Msg.success().add("paperlist",list);
    }
    /**
     * 查找最热的帖子
     * @param session
     * @return
     */
    @RequestMapping("/findPaperHottest")
    @ResponseBody//记得一定要加上这个注解
    public Msg findPaperHottest(HttpSession session){
//        List<Paper> list=paperService.findHottestPaper();
        List<Paper> list=paperService.findHottestPaperWithRedis();
        return Msg.success().add("paperlist",list);
    }

    @RequestMapping(value="/searchPaper",produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public String searchPaper(Integer teacherId, Integer id, String title,int page, int limit){
        System.out.println(id+" "+title+" "+page+" "+limit);
//        int page=1,limit=2;
        int before = limit * (page - 1);
        int after = limit;//page * limit

        //带参数从数据库里查询出来放到eilist的集合里
        List<Paper> eilist = paperService.searchPaper(teacherId,id,title,before, after);
        int count = paperService.searchPaperCount(teacherId,id,title);
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
     * 删除试卷
     * @param paperId
     * @param session
     * @return
     * @throws ParseException
     */
    @RequestMapping("/deletePaper")
    @ResponseBody
    public Msg deletePaper(String paperId, HttpSession session) throws ParseException {
        System.out.println("删除试卷："+paperId);
//        //删除最热考试缓存
//        String hottestkey="hottest:papers";
//        RedisUtil.removeZSet(hottestkey,paperId);
//        paperService.deletePaper(paperId);
        if(paperId.contains("-")){
            String[] str_ids=paperId.split("-");
            //组装ids的数组
            List<Integer> del_ids=new ArrayList<>();
            for(String string:str_ids){
                del_ids.add(Integer.parseInt(string));
            }
            paperService.deleteBatch(del_ids);
        }else{
            //删除单个记录
            Integer id=Integer.parseInt(paperId);
            paperService.deletePaper(id);
        }
        return Msg.success();
    }
}
