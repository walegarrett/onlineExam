package com.wale.exam.bean;

import java.util.Date;

public class Problem {
    private Integer id;

    private String answer;

    private Integer type;

    private Date createTime;

    private String analysis;

    private Integer score;

    private Integer createrId;

    private String content;

    //新增用户填写的answer选项
    private String userAnswer;

    //用于判卷显示用户的对应该题的分数
    private Integer userScore;

    private String titleContent;//题干

    private String typeName;//题型全称

    private String createrUserName;//创建者的用户名

    public String getCreaterUserName() {
        return createrUserName;
    }

    public void setCreaterUserName(String createrUserName) {
        this.createrUserName = createrUserName;
    }

    public String getTitleContent() {
        return titleContent;
    }

    public void setTitleContent(String titleContent) {
        this.titleContent = titleContent;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public Integer getUserScore() {
        return userScore;
    }

    public void setUserScore(Integer userScore) {
        this.userScore = userScore;
    }

    public String getUserAnswer() {
        return userAnswer;
    }

    public void setUserAnswer(String userAnswer) {
        this.userAnswer = userAnswer;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getAnalysis() {
        return analysis;
    }

    public void setAnalysis(String analysis) {
        this.analysis = analysis;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public Integer getCreaterId() {
        return createrId;
    }

    public void setCreaterId(Integer createrId) {
        this.createrId = createrId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Override
    public String toString() {
        return "Problem{" +
                "id=" + id +
                ", answer='" + answer + '\'' +
                ", type=" + type +
                ", createTime=" + createTime +
                ", analysis='" + analysis + '\'' +
                ", score=" + score +
                ", createrId=" + createrId +
                ", content='" + content + '\'' +
                '}';
    }
}
