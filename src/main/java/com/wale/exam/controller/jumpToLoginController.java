package com.wale.exam.controller;

import com.wale.exam.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

@Controller
public class jumpToLoginController {
    @Autowired
    PaperService paperService;
    @Autowired
    ProblemService problemService;
    @Autowired
    MessageService messageService;
    @Autowired
    UserService userService;
    @Autowired
    SheetService sheetService;
    @RequestMapping(value = "/login")//跳转到登陆页面
    public  String login(HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException {
        return "login";
    }
    @RequestMapping(value = "/register")//跳转到登陆页面
    public  String register(HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException {
        return "register";
    }

    @RequestMapping("/toAdminLogin")
    public  String toAdmin(HttpServletResponse response,HttpServletRequest request)
            throws UnsupportedEncodingException {
        return "admin/adminLogin";
    }
    @RequestMapping("/admin")
    public  String admin(HttpServletResponse response,HttpServletRequest request, HttpSession session)
            throws UnsupportedEncodingException {
        int totalPaperCount=paperService.findAllPaperCount();
        int totalProblemCount=problemService.findAllProblemCount();
        int totalMessageCount=messageService.findAllMessageCount();
        int totalUserCount=userService.findAllUserCount();
        session.setAttribute("paperCount",totalPaperCount);
        session.setAttribute("problemCount",totalProblemCount);
        session.setAttribute("messageCount",totalMessageCount);
        session.setAttribute("userCount",totalUserCount);
        List<Integer> dateList=new ArrayList<>();
        dateList=userService.findDateList();
        session.setAttribute("dateList",dateList);
        List<Integer> paperList=new ArrayList<>();
        paperList=paperService.findPaperList();
        session.setAttribute("paperList",paperList);
        return "admin/admin";
    }
    @RequestMapping("/toWhere")
    public  String toWhere(HttpServletResponse response,HttpServletRequest request,HttpSession session)
            throws UnsupportedEncodingException {
        String s=request.getParameter("where");
        if(s.equals("welcome")||s.equals("teacher")){
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
        }
        return s;
    }


}
