package com.wale.exam.bean;

import java.util.Date;

public class Paper {
    private Integer id;

    private String paperName;

    private Integer totalScore;

    private Date createTime;

    private Date startTime;

    private Date endTime;

    private Integer durationTime;

    private Integer questionCount;

    private Integer isEncry;

    private String inviCode;

    private Integer createrId;

    private boolean hasDoExam;//对应的用户是否已经考过该套试卷了

    private Sheet sheet;//

    private String createrUserName;//创建者的用户名

    private String isEncryString;//是否加密中文描述

    public String getIsEncryString() {
        return isEncryString;
    }

    public void setIsEncryString(String isEncryString) {
        this.isEncryString = isEncryString;
    }

    public String getCreaterUserName() {
        return createrUserName;
    }

    public void setCreaterUserName(String createrUserName) {
        this.createrUserName = createrUserName;
    }

    public Sheet getSheet() {
        return sheet;
    }

    public void setSheet(Sheet sheet) {
        this.sheet = sheet;
    }

    public boolean isHasDoExam() {
        return hasDoExam;
    }

    public void setHasDoExam(boolean hasDoExam) {
        this.hasDoExam = hasDoExam;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPaperName() {
        return paperName;
    }

    public void setPaperName(String paperName) {
        this.paperName = paperName;
    }

    public Integer getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(Integer totalScore) {
        this.totalScore = totalScore;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Integer getDurationTime() {
        return durationTime;
    }

    public void setDurationTime(Integer durationTime) {
        this.durationTime = durationTime;
    }

    public Integer getQuestionCount() {
        return questionCount;
    }

    public void setQuestionCount(Integer questionCount) {
        this.questionCount = questionCount;
    }

    public Integer getIsEncry() {
        return isEncry;
    }

    public void setIsEncry(Integer isEncry) {
        this.isEncry = isEncry;
    }

    public String getInviCode() {
        return inviCode;
    }

    public void setInviCode(String inviCode) {
        this.inviCode = inviCode;
    }

    public Integer getCreaterId() {
        return createrId;
    }

    public void setCreaterId(Integer createrId) {
        this.createrId = createrId;
    }
}
