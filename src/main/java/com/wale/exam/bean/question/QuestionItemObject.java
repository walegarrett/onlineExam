package com.wale.exam.bean.question;


public class QuestionItemObject {

    private String prefix;

    private String content;
    private Integer score;
    public String getPrefix() {
        return prefix;
    }

    public void setPrefix(String prefix) {
        this.prefix = prefix;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }
    public QuestionItemObject(){}
    public QuestionItemObject(String prefix, String content, Integer score) {
        this.prefix = prefix;
        this.content = content;
        this.score = score;
    }
}
