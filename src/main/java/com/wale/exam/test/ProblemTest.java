package com.wale.exam.test;

import com.wale.exam.bean.Problem;
import com.wale.exam.bean.question.QuestionItemObject;
import com.wale.exam.bean.question.QuestionObject;
import com.wale.exam.dao.ProblemMapper;
import com.wale.exam.util.JsonDateValueProcessor;
import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import sun.text.normalizer.UCharacter;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @Author WaleGarrett
 * @Date 2020/8/9 10:45
 */
@ContextConfiguration("classpath:applicationContext.xml")
@RunWith(SpringJUnit4ClassRunner.class)
public class ProblemTest {
    @Autowired
    ProblemMapper problemMapper;
    @Test
    public void addProblems(){
        for(int i=0;i<5;i++){
            Problem problem=new Problem();
            int random=(int)(4*Math.random());
            QuestionObject questionObject=new QuestionObject();
            questionObject.setTitleContent("题目："+i);
            questionObject.setAnalyze("题目："+i+"的解析");
            problem.setAnalysis("题目："+i+"的解析");
            List<QuestionItemObject>questionItemObjectList=new ArrayList<>();
            switch (random){
                case 0://单选
                    for(int j=0;j<4;j++){
                        QuestionItemObject questionItemObject=new QuestionItemObject();
                        questionItemObject.setPrefix(""+(char)('A'+j));
                        questionItemObject.setContent(""+(char)('A'+j)+"选项的内容！");
                        questionItemObjectList.add(questionItemObject);
                    }
                    questionObject.setCorrect("题目："+i+"的正确答案为：D");
                    problem.setType(1);
                    problem.setAnswer("D");
                    break;
                case 1://多选
                    for(int j=0;j<4;j++){
                        QuestionItemObject questionItemObject=new QuestionItemObject();
                        questionItemObject.setPrefix(""+(char)('A'+j));
                        questionItemObject.setContent(""+(char)('A'+j)+"选项的内容！");
                        questionItemObjectList.add(questionItemObject);
                    }
                    questionObject.setCorrect("题目："+i+"的正确答案为：A,D");
                    problem.setType(2);
                    problem.setAnswer("A,D");
                    break;
                case 2://判断
                    QuestionItemObject questionItemObject=new QuestionItemObject();
                    questionItemObject.setPrefix(""+(char)('A'+0));
                    questionItemObject.setContent(""+(char)('A'+0)+"是");
                    questionItemObjectList.add(questionItemObject);
                    QuestionItemObject questionItemObjects=new QuestionItemObject();
                    questionItemObjects.setPrefix(""+(char)('A'+1));
                    questionItemObjects.setContent(""+(char)('A'+1)+"否");
                    questionItemObjectList.add(questionItemObjects);
                    questionObject.setCorrect("题目："+i+"的正确答案为：B");
                    problem.setType(3);
                    problem.setAnswer("B");
                    break;
                case 3:
                    questionObject.setCorrect("题目："+i+"的正确答案为.....");
                    problem.setType(4);
                    problem.setAnswer("正确答案");
                    break;
                case 4:
                    questionObject.setCorrect("题目："+i+"的正确答案为.....");
                    problem.setType(5);
                    problem.setAnswer("正确答案");
                    break;
            }
            questionObject.setQuestionItemObjects(questionItemObjectList);
            //用json来传值
            JsonConfig jsonConfig = new JsonConfig();
            jsonConfig.registerJsonValueProcessor(Date.class , new JsonDateValueProcessor());
            JSONArray json = JSONArray.fromObject(questionObject, jsonConfig);
            String js = json.toString();
            String jso = js.substring(1,js.length()-1);
            System.out.println(jso);
            problem.setContent(jso);
            problem.setAnalysis("题目答案解析");
            problem.setCreaterId(2);
            problem.setCreateTime(new Date());
            problem.setScore(20);
            problemMapper.insertSelective(problem);
        }
    }
}
