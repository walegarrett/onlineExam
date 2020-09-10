package com.wale.exam.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.wale.exam.bean.Msg;
import com.wale.exam.bean.Problem;
import com.wale.exam.bean.User;
import com.wale.exam.service.*;
import com.wale.exam.util.JsonDateValueProcessor;
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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * @Author WaleGarrett
 * @Date 2020/8/6 21:27
 */
@Controller
public class UserController {
    @Autowired
    private UserService userService;
    @Autowired
    PaperService paperService;
    @Autowired
    ProblemService problemService;
    @Autowired
    MessageService messageService;
    @Autowired
    SheetService sheetService;

    /**
     * 用户登录功能-学生端和教师端
     * @param request
     * @param response
     * @param session
     * @return
     * @throws IOException
     * @throws ServletException
     */
    @RequestMapping(value = "/userLogin",  produces="text/html;charset=UTF-8")
    @ResponseBody
    public ModelAndView login(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException, ServletException {
        request.setCharacterEncoding("utf-8");
        ModelAndView mav = new ModelAndView();
        String userName= request.getParameter("username");
        String passWord= request.getParameter("password");
        if(session.getAttribute("username")!=null){
            mav.setViewName("login");//
            mav.addObject("message", "您已经登录，请退出登录后再进行操作！");
            return mav;
        }
        String code = request.getParameter("captcha");
        String sessionCode = "";
        try {
            sessionCode = request.getSession().getAttribute("code").toString();
        } catch (NullPointerException e) {
            sessionCode = "";
        }
        //如果用户名为空或者密码为空，则返回登录失败信息
        if (userName==null||"".equals(userName)||passWord==null||"".equals(passWord)||sessionCode==null||"".equals(sessionCode)) {
            mav.setViewName("login");
            return mav;
        }else {
            //判断用户输入的验证码是否正确
            if (code.equalsIgnoreCase(sessionCode)) {
                User user= userService.login(userName, passWord);//查询是否存在该用户
                if (user!=null) {
                    session.setAttribute("username",userName);
                    session.setAttribute("userid",user.getId());
                    session.setAttribute("user",user);
                    session.setAttribute("userheadpic",user.getImagePath());//用户头像
                    session.setAttribute("role",user.getRole());
                    Date createTime=user.getCreateTime();
                    String time=new SimpleDateFormat("yyyy-MM-dd").format(createTime).toString()+" "
                            +new SimpleDateFormat("HH:mm:ss").format(createTime).toString();
                    session.setAttribute("createTime",time);
                    if(user.getRole()==2){//登陆者的角色是否是老师
                        int userid=user.getId();
                        int totalPaperCount=paperService.findAllPaperCountWithTeacherId(userid);
                        int totalProblemCount=problemService.findAllProblemCountWithTeacherId(userid);
                        int totalMessageCount=messageService.findAllMessageCountWithTeacherId(userid);
                        int totalJudgeCount=sheetService.findAllJudgedCountWithTeacherId(userid);
                        session.setAttribute("paperCount",totalPaperCount);
                        session.setAttribute("problemCount",totalProblemCount);
                        session.setAttribute("messageCount",totalMessageCount);
                        session.setAttribute("judgedCount",totalJudgeCount);
                        List<Integer> paperList=new ArrayList<>();
                        paperList=paperService.findPaperListWithTeacherId(userid);
                        session.setAttribute("paperList",paperList);
                        mav.setViewName("redirect:./teacher");//调用上一个方法进行重定向
                    }
                    else mav.setViewName("redirect:/index2.jsp");//跳转到主页面
                    return mav;
                }else {//密码错误
                    mav.setViewName("login");//
                    mav.addObject("message", "密码错误，请重新登录！");
                    return mav;
                }

            }else {//验证码输入不正确
                mav.setViewName("login");
                mav.addObject("message", "验证码错误，请重新登录！");
                return mav;
            }
        }
    }
    /**
     * 通过下面的登录重定向到教师页面
     * @param request
     * @param response
     * @param session
     * @return
     * @throws IOException
     * @throws ServletException
     */
    @RequestMapping(value = "/teacher",  produces="text/html;charset=UTF-8")
    public ModelAndView teacher(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException, ServletException {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("teacher");//
        int userid=(int)session.getAttribute("userid");
        int totalPaperCount=paperService.findAllPaperCountWithTeacherId(userid);
        int totalProblemCount=problemService.findAllProblemCountWithTeacherId(userid);
        int totalMessageCount=messageService.findAllMessageCountWithTeacherId(userid);
        int totalJudgeCount=sheetService.findAllJudgedCountWithTeacherId(userid);
        session.setAttribute("paperCount",totalPaperCount);
        session.setAttribute("problemCount",totalProblemCount);
        session.setAttribute("messageCount",totalMessageCount);
        session.setAttribute("judgedCount",totalJudgeCount);
        List<Integer> paperList=new ArrayList<>();
        paperList=paperService.findPaperListWithTeacherId(userid);
        session.setAttribute("paperList",paperList);
        return mav;
    }

    /**
     * 登录------------redis缓存登录失效期
     * user:login:lock：账户被锁定
     * user:logincount:fail该key则表示登录失败次数
     * 1. 如果账户被锁定：提示还剩多长时间解锁
     * 2. 否则账户未被锁定
     *     2.1 登录成功  移除user:login:lock，user:logincount:fail
     *     2.2 登录失败
     *         2.2.1 登录失败次数<5
     *         2.2.2 登录失败次数>5 锁定账户，设置锁定时间
     * @param request
     * @param response
     * @param session
     * @return
     * @throws IOException
     * @throws ServletException
     */
    @RequestMapping(value = "/userLogins",  produces="text/html;charset=UTF-8")
    @ResponseBody
    public ModelAndView logins(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException, ServletException {
        request.setCharacterEncoding("utf-8");
        ModelAndView mav = new ModelAndView();
        String userName= request.getParameter("username");
        String passWord= request.getParameter("password");
        if(session.getAttribute("username")!=null){
            mav.setViewName("login");//
            mav.addObject("message", "您已经登录，请退出登录后再进行操作！");
            return mav;
        }
        String code = request.getParameter("captcha");
        String sessionCode = "";
        try {
            sessionCode = request.getSession().getAttribute("code").toString();
        } catch (NullPointerException e) {
            sessionCode = "";
        }
        //1. 判断账户是否锁定
        if(RedisUtil.hasKey("user:login:lock:"+userName)){
            mav.setViewName("login");
            mav.addObject("message","您的账户已经被锁定，还剩"+RedisUtil.getExpire("user:login:lock:"+userName, TimeUnit.SECONDS)+"秒解锁！");
            return mav;
        }
        //如果用户名为空或者密码为空，则返回登录失败信息
        if (userName==null||"".equals(userName)||passWord==null||"".equals(passWord)||sessionCode==null||"".equals(sessionCode)) {
            mav.setViewName("login");
        }else {
            //判断用户输入的验证码是否正确
            if (code.equalsIgnoreCase(sessionCode)) {
                User user= userService.login(userName, passWord);//查询是否存在该用户
                if (user!=null) {
                    session.setAttribute("username",userName);
                    session.setAttribute("userid",user.getId());
                    session.setAttribute("user",user);
                    session.setAttribute("userheadpic",user.getImagePath());//用户头像
                    session.setAttribute("role",user.getRole());
                    Date createTime=user.getCreateTime();
                    String time=new SimpleDateFormat("yyyy-MM-dd").format(createTime).toString()+" "
                            +new SimpleDateFormat("HH:mm:ss").format(createTime).toString();
                    session.setAttribute("createTime",time);
                    if(user.getRole()==2){//登陆者的角色是否是老师
                        int userid=user.getId();
                        int totalPaperCount=paperService.findAllPaperCountWithTeacherId(userid);
                        int totalProblemCount=problemService.findAllProblemCountWithTeacherId(userid);
                        int totalMessageCount=messageService.findAllMessageCountWithTeacherId(userid);
                        int totalJudgeCount=sheetService.findAllJudgedCountWithTeacherId(userid);
                        session.setAttribute("paperCount",totalPaperCount);
                        session.setAttribute("problemCount",totalProblemCount);
                        session.setAttribute("messageCount",totalMessageCount);
                        session.setAttribute("judgedCount",totalJudgeCount);
                        List<Integer> paperList=new ArrayList<>();
                        paperList=paperService.findPaperListWithTeacherId(userid);
                        session.setAttribute("paperList",paperList);
                        mav.setViewName("redirect:./teacher");//调用上一个方法进行重定向
                    }
                    else mav.setViewName("redirect:/index2.jsp");//跳转到主页面
                    //登录成功,删除缓存
                    RedisUtil.del("user:logincount:fail:"+userName,"user:login:lock:"+userName);
                }else {//密码错误
                    mav.setViewName("login");//
                    //判断登录失败次数
                    if(RedisUtil.hasKey("user:logincount:fail:"+userName)){
                        String value=RedisUtil.getString("user:logincount:fail:"+userName);
                        int count=Integer.parseInt(value);
                        count++;
                        if(count<5){
                            RedisUtil.setString("user:logincount:fail:"+userName,""+count);
                            mav.addObject("message", "密码错误，您还有"+(5-count)+"次尝试机会！");
                        }else{
                            RedisUtil.setString("user:login:lock:"+userName,"1",60);//设置过期时间
                            RedisUtil.del("user:logincount:fail:"+userName);
                            mav.addObject("message", "密码错误！登录失败次数已连续超过5次，您的账号已被锁定1分钟！");
                        }
                    }else{
                        RedisUtil.setString("user:logincount:fail:"+userName,"1");
                        mav.addObject("message", "密码错误，您还有"+(5-1)+"次尝试机会！");
                    }
                }
            }else {//验证码输入不正确
                mav.setViewName("login");
                mav.addObject("message", "验证码错误，请重新登录！");
            }
        }
        return mav;
    }

    /**
     * 校验
     * @param username
     * @return
     */
    @PostMapping(value = "/checkUserName")
    @ResponseBody
    public Msg checkUserName(String username) {
        HashMap<String,Boolean> hashMap = new HashMap();
        User user = userService.getUserByname(username);
        System.out.println("查找用户名："+username);
        if (user != null ) {
            if(user.getRole()==3)
                return Msg.fail();
            else return Msg.success();
        } else {
            return Msg.fail();
        }
    }
    @PostMapping(value = "/registerCheckUserName")
    @ResponseBody
    public String registerCheckUserName(String userName) throws JsonProcessingException {
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

    /**
     * 退出登录
     */
    @RequestMapping("/userExit")
    public String UserExit(HttpSession session){
        session.removeAttribute("username");
        session.removeAttribute("userid");
        session.removeAttribute("user");
        session.removeAttribute("userheadpic");
        return "login";
    }

    /**
     * 用户注册功能
     * @param userName
     * @param realName
     * @param password
     * @param email
     * @param sex
     * @param role
     * @param phone
     * @return
     */
    @RequestMapping("/userRegister")
    public String userRegister(@RequestParam("userName") String userName,
                           @RequestParam("realName") String realName,
                           @RequestParam("password") String password,
                           @RequestParam("email") String email,
                           @RequestParam("sex") String sex,
                           @RequestParam("role") String role,
                           @RequestParam("phone") String phone,
                           @RequestParam("age") String age){
        //新建一个用户
        User user = new User();
        user.setAge(Integer.parseInt(age));
        user.setCreateTime(new Date());
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(Integer.parseInt(role));
        user.setRealName(realName);
        user.setUserName(userName);
        user.setPhone(phone);
        user.setSex(Integer.parseInt(sex));
        //设置默认头像地址
        user.setImagePath("/onlineExam/statics/images/default.jpeg");
        userService.addUser(user);
        return "login";
    }

    /**
     * 查找所有的学生教师用户
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping(value="/findUserPage",produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public String findUserPage(String keyword,int page, int limit){
        System.out.println(keyword);
        int before = limit * (page - 1);
        int after = limit;//page * limit
        //带参数从数据库里查询出来放到eilist的集合里
        List<User> eilist = userService.findUserPage(keyword,before, after);
        int count = userService.findUserCount(keyword);
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
     * 用户的个人信息修改
     * @param userId
     * @param realName
     * @param email
     * @param sex
     * @param phone
     * @param age
     * @param session
     * @return
     */
    @RequestMapping("/userInfoChange")
    public String userInfoChange(
                                @RequestParam("userId") String userId,
                               @RequestParam("realName") String realName,
                               @RequestParam("email") String email,
                               @RequestParam("sex") String sex,
                               @RequestParam("phone") String phone,
                               @RequestParam("age") String age,
                                HttpSession session){
        User user = new User();
        user.setId(Integer.parseInt(userId));
        user.setAge(Integer.parseInt(age));
        user.setEmail(email);
        user.setRealName(realName);
        user.setPhone(phone);
        user.setSex(Integer.parseInt(sex));
        userService.updateUser(user);//调用service中信息更新的函数
        changeSession(session,Integer.parseInt(userId));
        return "redirect:./toPersonalCenter";
    }
    @RequestMapping("/toPersonalCenter")
    public String toPersonalCenter(){
        return "personalCenter";
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

    /**
     * 检验密码是否输入正确
     * @param userId
     * @param password
     * @return
     * @throws JsonProcessingException
     */
    @RequestMapping(value = "/checkPassword")
    @ResponseBody
    public String checkPassword(Integer userId, String password) throws JsonProcessingException {
        System.out.println(userId+" "+password);
        HashMap<String,Boolean> hashMap = new HashMap();
        User user = userService.findUserByUserId(userId);
        if (user.getPassword().equals(password)) {
            hashMap.put("valid",true);
        } else {
            hashMap.put("valid",false);
        }
        ObjectMapper mapper = new ObjectMapper();
        String jsonStr = mapper.writeValueAsString(hashMap);
        return jsonStr;
    }

    /**
     * 修改密码
     * @param userId
     * @param password
     * @param session
     * @return
     */
    @RequestMapping("/updatePassword")
    public String updatePassword(
            @RequestParam("userId") String userId,
            @RequestParam("password") String password,
            HttpSession session){
        User user = new User();
        user.setId(Integer.parseInt(userId));
        user.setPassword(password);
        userService.updateUser(user);
        changeSession(session,Integer.parseInt(userId));
        return "redirect:./toPersonalCenter";
    }

    @RequestMapping("/teacherInfoChange")
    public String teacherInfoChange(
            @RequestParam("userid") String userid,
            @RequestParam("username") String username,
            @RequestParam("realname") String realname,
            @RequestParam("email") String email,
            @RequestParam("phone") String phone,
            HttpSession session){
        User user = new User();
        user.setId(Integer.parseInt(userid));
        user.setEmail(email);
        user.setUserName(username);
        user.setRealName(realname);
        user.setPhone(phone);
        userService.updateUser(user);
        changeSession(session,Integer.parseInt(userid));
        return "redirect:./toTeacherInfo";
    }
    @RequestMapping("/toTeacherInfo")
    public String toTeacher(){
        return "teacherInfo";
    }

    @RequestMapping("/teacherPasswordChange")
    public String teacherPasswordChange(
            @RequestParam("userid") String userid,
            @RequestParam("new_password") String new_password,
            HttpSession session){
        System.out.println("修改密码: "+userid+" "+new_password);
        User user = new User();
        user.setId(Integer.parseInt(userid));
        user.setPassword(new_password);
        userService.updateUser(user);
        changeSession(session,Integer.parseInt(userid));
        return "redirect:./toWelcome";
    }
    @RequestMapping("/toWelcome")
    public String toWelcome(){
        return "welcome";
    }

    @PostMapping(value = "/checkTeacherPassword")
    @ResponseBody
    public Msg checkTeacherPassword(Integer userId, String password) {
        System.out.println(userId+" "+password);
        User user = userService.findUserByUserId(userId);
        if (user.getPassword().equals(password) ) {
            return Msg.success();
        } else {
            return Msg.fail();
        }
    }
    @PostMapping(value = "/checkLoginCode")
    @ResponseBody
    public Msg checkLoginCode(HttpServletRequest request,String code) throws JsonProcessingException {
        String sessionCode = request.getSession().getAttribute("code").toString();
        if (code != null && !"".equals(code) && sessionCode != null && !"".equals(sessionCode)) {
            if (code.equalsIgnoreCase(sessionCode)) {
                return Msg.success();
            } else {
                return Msg.fail();
            }
        } else {
            return Msg.fail();
        }
    }
    @PostMapping(value = "/checkLoginPassword")
    @ResponseBody
    public Msg checkLoginPassword(HttpServletRequest request,String username, String password) throws JsonProcessingException {
        User user=userService.findUserByUserNameAndPassword(username,password);
        if(user==null)
            return Msg.fail();
        else return Msg.success();
    }
}
