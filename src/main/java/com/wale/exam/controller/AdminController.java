package com.wale.exam.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageInfo;
import com.wale.exam.bean.*;
import com.wale.exam.bean.question.QuestionItemObject;
import com.wale.exam.bean.question.QuestionObject;
import com.wale.exam.service.*;
import com.wale.exam.util.JsonDateValueProcessor;
import com.wale.exam.util.MyPageInfo;
import com.wale.exam.util.RedisUtil;
import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @Author WaleGarrett
 * @Date 2020/8/12 22:51
 */
@Controller
public class AdminController {
    @Autowired
    private UserService userService;
    @Autowired
    PaperService paperService;
    @Autowired
    AnswerService answerService;
    @Autowired
    SheetService sheetService;
    @Autowired
    ProblemService problemService;
    @Autowired
    MessageService messageService;
    @Autowired
    MessageUserService messageUserService;
    /**
     * 判断管理员用户是否存在
     * @param username
     * @return
     * @throws JsonProcessingException
     */
    @PostMapping(value = "/adminCheckUserName")
    @ResponseBody
    public String adminCheckUserName(String username) throws JsonProcessingException {
        HashMap<String,Boolean> hashMap = new HashMap();
        User user = userService.getUserByname(username);
        if (user == null ) {
            hashMap.put("valid",false);
        } else {
            if(user.getRole()!=3)
                hashMap.put("valid",false);
            else hashMap.put("valid",true);
        }
        ObjectMapper mapper = new ObjectMapper();
        String jsonStr = mapper.writeValueAsString(hashMap);
        return jsonStr;
    }
    @RequestMapping(value = "/adminLogin")
    @ResponseBody
    public Msg adminLogin(String username, String password, String code, HttpServletRequest request, HttpSession session) throws IOException, ServletException {
        System.out.println(username+" "+password+" "+code);
        if(session.getAttribute("username")!=null){
            return Msg.fail().add("err","您已经登录，请退出后重新登录！");
        }
        String sessionCode = "";
        try {
            sessionCode = request.getSession().getAttribute("code").toString();
        } catch (NullPointerException e) {
            sessionCode = "";
        }

        if (username==null||"".equals(username)||username==null||"".equals(password)||sessionCode==null||"".equals(sessionCode)) {
            return Msg.fail().add("err","选项均不能为空");
        }else {
            if (code.equalsIgnoreCase(sessionCode)) {
                User user= userService.login(username, password);
                if (user!=null) {
                    session.setAttribute("username",username);
                    session.setAttribute("userid",user.getId());
                    session.setAttribute("user",user);
                    session.setAttribute("userheadpic",user.getImagePath());//用户头像
                    session.setAttribute("role",user.getRole());
                    return Msg.success();
                }else {
                    return Msg.fail().add("err","密码错误请重新登录！");
                }
            }else {
                return Msg.fail().add("err","验证码错误！！");
            }
        }
    }
    @RequestMapping("/adminUserManage")
    @ResponseBody//记得一定要加上这个注解
    public Msg adminUserManage(@RequestParam(value = "pn",defaultValue = "1")Integer pn, HttpSession session){
        List<User> list=new ArrayList<>();
        list=userService.findAllUser();
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就可以了
        PageInfo page= MyPageInfo.getPageInfo(pn,10,list);
        return Msg.success().add("pageInfo",page);
    }
    @RequestMapping("/adminGetUser")
    @ResponseBody//记得一定要加上这个注解
    public Msg adminGetUser(Integer userId, HttpSession session){
        User user=userService.findUserByUserId(userId);
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就可以了
        return Msg.success().add("user",user);
    }
    @RequestMapping("/adminUpdateUser")
    @ResponseBody//记得一定要加上这个注解
    public Msg adminUpdateUser(Integer id, String password, Integer age, String realName, String email, Integer role, Integer sex, HttpSession session){
        System.out.println(id+" "+password+" "+age+" "+realName+" "+email+" "+sex+" "+role);
        User user=new User();
        user.setAge(age);
        user.setId(id);
        user.setRealName(realName);
        user.setPassword(password);
        user.setRole(role);
        user.setEmail(email);
        user.setSex(sex);
        userService.updateUser(user);
        return Msg.success();
    }
    @RequestMapping("/adminDeleteUser")
    @ResponseBody//记得一定要加上这个注解
    public Msg adminDeleteUser(Integer userId, HttpSession session){
        System.out.println(userId);
        userService.deleteUser(userId);
        return Msg.success();
    }

    /**
     * 试卷管理
     * @param pn
     * @param session
     * @return
     */
    @RequestMapping("/adminPaperManage")
    @ResponseBody//记得一定要加上这个注解
    public Msg adminPaperManage(@RequestParam(value = "pn",defaultValue = "1")Integer pn, HttpSession session){
        List<Paper> list=new ArrayList<>();
        list=paperService.findAllPaper();
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就可以了
        PageInfo page= MyPageInfo.getPageInfo(pn,10,list);
        return Msg.success().add("pageInfo",page);
    }

    /**
     * 根据试卷名称进行模糊搜索
     * @param field
     * @param keyword
     * @param session
     * @return
     */
    @RequestMapping("/adminPaperManageSearch")
    @ResponseBody//记得一定要加上这个注解
    public Msg adminPaperManageSearch(@RequestParam(value = "pn",defaultValue = "1")Integer pn,String field, String keyword, HttpSession session){
        List<Paper> list=new ArrayList<>();
        if(keyword==null||keyword.equals(""))
            list=paperService.findAllPaper();
        else list=paperService.findPaperWithKeyword(field,keyword);
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就可以了
        PageInfo page= MyPageInfo.getPageInfo(pn,10,list);
        return Msg.success().add("pageInfo",page);
    }

    @RequestMapping("/adminGetPaper")
    @ResponseBody//记得一定要加上这个注解
    public Msg adminGetPaper(Integer paperId, HttpSession session){
        Paper paper=new Paper();
        paper=paperService.findPaperByPaperId(paperId);
        return Msg.success().add("paper",paper);
    }
    @RequestMapping("/adminUpdatePaper")
    @ResponseBody//记得一定要加上这个注解
    public Msg adminUpdatePaper(Integer id, String paperName, Integer durationTime, String startTime, Integer isEncry, String inviCode, HttpSession session) throws ParseException {
        System.out.println(id+" "+paperName+" "+durationTime+" "+startTime+" "+isEncry+" "+inviCode);
        Paper paper=new Paper();
        paper.setId(id);
        paper.setPaperName(paperName);
        paper.setIsEncry(isEncry);
        paper.setInviCode(inviCode);
        //时间转换：前端传来的格式为2020-08-09T09:56
        String startTimes=startTime.substring(0,10)+"-"+startTime.substring(11,16);
        SimpleDateFormat formatter = new SimpleDateFormat( "yyyy-MM-dd-HH:mm");
        Date start = formatter.parse(startTimes);
        paper.setStartTime(start);
        paper.setDurationTime(durationTime);
        paper.setEndTime(new Date(start.getTime()+1000*60*durationTime));
        paperService.updatePaper(paper);
        return Msg.success();
    }

    /**
     * 删除试卷
     * @param paperId
     * @param session
     * @return
     */
    @RequestMapping("/adminDeletePaper")
    @ResponseBody//记得一定要加上这个注解
    public Msg adminDeletePaper(Integer paperId, HttpSession session){
        System.out.println(paperId);
        //删除最热考试
        String hottestkey="hottest:papers";
        RedisUtil.removeZSet(hottestkey,paperId);
        paperService.deletePaper(paperId);
        return Msg.success();
    }

    /**
     * 题目管理
     * @param pn
     * @param session
     * @return
     */
    @RequestMapping("/adminProblemManage")
    @ResponseBody//记得一定要加上这个注解
    public Msg adminProblemManage(@RequestParam(value = "pn",defaultValue = "1")Integer pn, HttpSession session){
        List<Problem> list=new ArrayList<>();
        list=problemService.findAllProblem();
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就可以了
        PageInfo page= MyPageInfo.getPageInfo(pn,10,list);
        return Msg.success().add("pageInfo",page);
    }
    /**
     * 带模糊搜索的查找
     * @param pn
     * @param session
     * @return
     */
    @RequestMapping("/adminProblemManageSearch")
    @ResponseBody//记得一定要加上这个注解
    public Msg adminProblemManageSearch(@RequestParam(value = "pn",defaultValue = "1")Integer pn, String field, String keyword, HttpSession session){
        List<Problem> list=new ArrayList<>();
        if(keyword==null||keyword.equals("")){
            list=problemService.findAllProblem();
        }else{
            list=problemService.findProblemsWithKeyword(field,keyword);
        }

        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就可以了
        PageInfo page= MyPageInfo.getPageInfo(pn,10,list);
        return Msg.success().add("pageInfo",page);
    }
    /**
     * 根据题目id获取题目
     * @param problemId
     * @param session
     * @return
     */
    @RequestMapping("/adminGetProblem")
    @ResponseBody//记得一定要加上这个注解
    public Msg adminGetProblem(Integer problemId, HttpSession session){
        Problem problem=new Problem();
        problem=problemService.findProblemByProblemId(problemId);
        return Msg.success().add("problem",problem);
    }

    /**
     * 更新题目
     * @param problemId
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
    @RequestMapping("/adminUpdateProblem")
    @ResponseBody
    public Msg adminUpdateProblem(Integer problemId, String titleContent, String answer, Integer score, Integer type, String analysis, String optionA, String optionB, String optionC, String optionD, HttpSession session) throws ParseException {
        System.out.println("更新题目："+" "+titleContent+" "+answer+" "+type+" "+score+" "+analysis);

        Map<String,Object> map=new HashMap<>();//用来存储错误的字段
        Problem problem=new Problem();
        problem.setAnswer(answer);
        problem.setType(type);
        problem.setScore(score);
//        problem.setCreateTime(new Date());
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
    /**
     * 成绩管理
     * @param pn
     * @param session
     * @return
     */
    @RequestMapping("/adminGradeManage")
    @ResponseBody//记得一定要加上这个注解
    public Msg adminGradeManage(@RequestParam(value = "pn",defaultValue = "1")Integer pn, HttpSession session){
        List<Sheet> list=new ArrayList<>();
        list=sheetService.findAllSheetWithJudged();
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就可以了
        PageInfo page= MyPageInfo.getPageInfo(pn,10,list);
        return Msg.success().add("pageInfo",page);
    }

    /**
     * 带模糊搜索的成绩管理查找
     * @param pn
     * @param field
     * @param keyword
     * @param session
     * @return
     */
    @RequestMapping("/adminGradeManageSearch")
    @ResponseBody//记得一定要加上这个注解
    public Msg adminGradeManageSearch(@RequestParam(value = "pn",defaultValue = "1")Integer pn, String field, String keyword,HttpSession session){
        System.out.println(field+" "+keyword);
        List<Sheet> list=new ArrayList<>();
        if(keyword==null||keyword.equals(""))
            list=sheetService.findAllSheetWithJudged();
        else list=sheetService.findSheetWithJudgedAndKeyword(field,keyword);
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就可以了
        PageInfo page= MyPageInfo.getPageInfo(pn,10,list);
        return Msg.success().add("pageInfo",page);
    }
    @RequestMapping("/adminGetGrade")
    @ResponseBody//记得一定要加上这个注解
    public Msg adminGetGrade(Integer sheetId, HttpSession session){
        Sheet sheet=new Sheet();
        sheet=sheetService.findSheetBySheetId(sheetId);
        return Msg.success().add("sheet",sheet);
    }

    @RequestMapping("/adminUpdateGrade")
    @ResponseBody//记得一定要加上这个注解
    public Msg adminUpdateGrade(Integer id, Integer score, HttpSession session) throws ParseException {
        System.out.println(id+" "+score);
        Sheet sheet=new Sheet();
        sheet.setId(id);
        sheet.setScore(score);
        sheetService.updateSheet(sheet);
        return Msg.success();
    }

    /**
     * 消息管理
     * @param pn
     * @param session
     * @return
     */
    @RequestMapping("/adminMessageManage")
    @ResponseBody//记得一定要加上这个注解
    public Msg adminMessageManage(@RequestParam(value = "pn",defaultValue = "1")Integer pn, HttpSession session){
        List<Message> list=new ArrayList<>();
        list=messageService.findAllMessage();
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就可以了
        PageInfo page= MyPageInfo.getPageInfo(pn,10,list);
        return Msg.success().add("pageInfo",page);
    }
    @RequestMapping("/adminGetMessage")
    @ResponseBody//记得一定要加上这个注解
    public Msg adminGetMessage(Integer messageId, HttpSession session){
        Message message=new Message();
        message=messageService.findMessageByMessageId(messageId);
        return Msg.success().add("message",message);
    }
    @RequestMapping("/adminUpdateMessage")
    @ResponseBody//记得一定要加上这个注解
    public Msg adminUpdateMessage(Integer id, String messageTitle,String messageContent, HttpSession session) throws ParseException {
        System.out.println(id+" "+messageTitle+" "+messageContent);
        Message message=new Message();
        message.setId(id);
        message.setTitle(messageTitle);
        message.setContent(messageContent);
        messageService.updateMessage(message);
        return Msg.success();
    }

    /**
     * 删除消息
     * @param messageId
     * @param session
     * @return
     */
    @RequestMapping("/adminDeleteMessage")
    @ResponseBody//记得一定要加上这个注解
    public Msg adminDeleteMessage(String messageId, HttpSession session){
        System.out.println(messageId);
//        Integer messageid=Integer.parseInt(messageId);
//        messageService.deleteMessage(messageid);
        if(messageId.contains("-")){
            String[] str_ids=messageId.split("-");
            //组装ids的数组
            List<Integer> del_ids=new ArrayList<>();
            for(String string:str_ids){
                del_ids.add(Integer.parseInt(string));
            }
            messageService.deleteBatch(del_ids);
        }else{
            //删除单个记录
            Integer id=Integer.parseInt(messageId);
            messageService.deleteMessage(id);
        }


        return Msg.success();
    }
    @RequestMapping("/adminInfoChange")
    public String userInfoChange(
            @RequestParam("userId") String userId,
            @RequestParam("realName") String realName,
            @RequestParam("email") String email,
            HttpSession session){
        System.out.println(userId+" "+realName+" "+email);
        User user = new User();
        user.setId(Integer.parseInt(userId));
        user.setEmail(email);
        user.setRealName(realName);
        userService.updateUser(user);
        changeSession(session,Integer.parseInt(userId));
        return "redirect:./toAdminProfile";
    }
    @RequestMapping("/toAdminProfile")
    public String toPersonalCenter(){
        return "admin/adminProfile";
    }
    /**
     * 改变session中关于user的内容
     * @param session
     * @param userid
     */
    public void changeSession(HttpSession session, Integer userid){
        User user=new User();
        user=userService.findUserByUserId(userid);
        session.setAttribute("username",user.getUserName());
        session.setAttribute("userid",user.getId());
        session.setAttribute("user",user);
        session.setAttribute("userheadpic",user.getImagePath());//用户头像
        session.setAttribute("role",user.getRole());
        Date createTime=user.getCreateTime();
        String time=new SimpleDateFormat("yyyy-MM-dd").format(createTime).toString()+" "
                +new SimpleDateFormat("HH:mm:ss").format(createTime).toString();
        session.setAttribute("createTime",time);
    }
    @RequestMapping("/adminUpdatePassword")
    public String updatePassword(
            @RequestParam("userId") String userId,
            @RequestParam("newpwd") String newpwd,
            HttpSession session){
        User user = new User();
        user.setId(Integer.parseInt(userId));
        user.setPassword(newpwd);
        userService.updateUser(user);
        changeSession(session,Integer.parseInt(userId));
        return "redirect:./toAdminProfile";
    }
    @PostMapping(value = "/adminCheckAddUserName")
    @ResponseBody
    public String adminCheckAddUserName(String userName) throws JsonProcessingException {
        HashMap<String,Boolean> hashMap = new HashMap();
        //检查数据库中是否存在注册时用户输入的用户名，如果存在则返回错误提示，否则则说明用户选择的账号是合法的
        User user = userService.getUserByname(userName);
        if (user == null ) {
            hashMap.put("valid",true);
        } else {
            hashMap.put("valid",false);
        }
        ObjectMapper mapper = new ObjectMapper();
        String jsonStr = mapper.writeValueAsString(hashMap);
        return jsonStr;
    }
    @RequestMapping("/adminAddUser")
    @ResponseBody//记得一定要加上这个注解
    public Msg adminAddUser(String userName, String password, Integer age, String realName, String email, Integer role, Integer sex, String phone, HttpSession session){
        System.out.println("管理员新增用户:"+userName+" "+password+" "+age+" "+realName+" "+email+" "+sex+" "+role+" "+phone);
        User user=new User();
        user.setAge(age);
        user.setUserName(userName);
        user.setRealName(realName);
        user.setPassword(password);
        user.setRole(role);
        user.setEmail(email);
        user.setSex(sex);
        user.setPhone(phone);
        user.setCreateTime(new Date());
        //设置默认头像地址
        user.setImagePath("/onlineExam/statics/images/default.jpeg");
        userService.addUser(user);
        return Msg.success();
    }

    @RequestMapping("/adminUserManageSearch")
    @ResponseBody//记得一定要加上这个注解
    public Msg adminUserManageSearch(@RequestParam(value = "pn",defaultValue = "1")Integer pn,String field, String keyword, HttpSession session){
        List<User> list=new ArrayList<>();
        if(keyword==null||keyword.equals(""))
            list=userService.findAllUser();
        else
            list=userService.searchUserByKeyword(field,keyword);
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就可以了
        PageInfo page= MyPageInfo.getPageInfo(pn,10,list);
        return Msg.success().add("pageInfo",page);
    }
    /**
     * 带模糊搜索的成绩管理查找
     * @param pn
     * @param field
     * @param keyword
     * @param session
     * @return
     */
    @RequestMapping("/adminSheetManageSearch")
    @ResponseBody//记得一定要加上这个注解
    public Msg adminSheetManageSearch(@RequestParam(value = "pn",defaultValue = "1")Integer pn, String field, String keyword,HttpSession session){
        System.out.println(field+" "+keyword);
        List<Sheet> list=new ArrayList<>();
        if(keyword==null||keyword.equals(""))
            list=sheetService.findAllSheet();
        else list=sheetService.findSheetWithKeyword(field,keyword);
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就可以了
        PageInfo page= MyPageInfo.getPageInfo(pn,10,list);
        return Msg.success().add("pageInfo",page);
    }
    /**
     * 删除答卷
     * @param sheetId
     * @param session
     * @return
     */
    @RequestMapping("/adminDeleteSheet")
    @ResponseBody//记得一定要加上这个注解
    public Msg adminDeleteSheet(String sheetId, HttpSession session){
        System.out.println(sheetId);

//        //删除答卷
//        sheetService.deleteSheet(sheetId);

        if(sheetId.contains("-")){
            String[] str_ids=sheetId.split("-");
            //组装ids的数组
            List<Integer> del_ids=new ArrayList<>();
            for(String string:str_ids){
                del_ids.add(Integer.parseInt(string));
            }
            sheetService.deleteBatch(del_ids);
        }else{
            //删除单个记录
            Integer id=Integer.parseInt(sheetId);
            sheetService.deleteSheet(id);
        }
        return Msg.success();
    }
}
