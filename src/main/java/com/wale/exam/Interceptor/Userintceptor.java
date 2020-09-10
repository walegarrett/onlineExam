package com.wale.exam.Interceptor;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.wale.exam.bean.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;


public class Userintceptor implements HandlerInterceptor{

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        //获得session对象
        HttpSession session = request.getSession();
        //从session对象中获得user对象
        User user = (User) session.getAttribute("user");
        //判断user对象是否存在
        if(user == null){
            response.setCharacterEncoding("UTF-8");
            response.setContentType("text/html;charset=UTF-8");
//            response.getWriter().write("请先登录！！");
            response.sendRedirect("noLogin.jsp");
            return false;
        }
        return true;
        //判断权限是否通过
//        if(user.getGrade() >= 1001){
//            return true;
//        }else{
//            response.setCharacterEncoding("UTF-8");
//            response.setContentType("text/html;charset=UTF-8");
//            response.getWriter().write("权限不够！！");
//            return false;
//        }

    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
                           ModelAndView modelAndView) throws Exception {
        System.out.println("进来了！！2！！");

        // TODO Auto-generated method stub

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
        System.out.println("进来了！3！！！");

    }

}
