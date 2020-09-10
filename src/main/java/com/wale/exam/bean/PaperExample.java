package com.wale.exam.bean;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class PaperExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public PaperExample() {
        oredCriteria = new ArrayList<Criteria>();
    }

    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    public String getOrderByClause() {
        return orderByClause;
    }

    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    public boolean isDistinct() {
        return distinct;
    }

    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    protected abstract static class GeneratedCriteria {
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<Criterion>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        protected void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        protected void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        public Criteria andIdIsNull() {
            addCriterion("id is null");
            return (Criteria) this;
        }

        public Criteria andIdIsNotNull() {
            addCriterion("id is not null");
            return (Criteria) this;
        }

        public Criteria andIdEqualTo(Integer value) {
            addCriterion("id =", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotEqualTo(Integer value) {
            addCriterion("id <>", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdGreaterThan(Integer value) {
            addCriterion("id >", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("id >=", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdLessThan(Integer value) {
            addCriterion("id <", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdLessThanOrEqualTo(Integer value) {
            addCriterion("id <=", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdIn(List<Integer> values) {
            addCriterion("id in", values, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotIn(List<Integer> values) {
            addCriterion("id not in", values, "id");
            return (Criteria) this;
        }

        public Criteria andIdBetween(Integer value1, Integer value2) {
            addCriterion("id between", value1, value2, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotBetween(Integer value1, Integer value2) {
            addCriterion("id not between", value1, value2, "id");
            return (Criteria) this;
        }

        public Criteria andPaperNameIsNull() {
            addCriterion("paper_name is null");
            return (Criteria) this;
        }

        public Criteria andPaperNameIsNotNull() {
            addCriterion("paper_name is not null");
            return (Criteria) this;
        }

        public Criteria andPaperNameEqualTo(String value) {
            addCriterion("paper_name =", value, "paperName");
            return (Criteria) this;
        }

        public Criteria andPaperNameNotEqualTo(String value) {
            addCriterion("paper_name <>", value, "paperName");
            return (Criteria) this;
        }

        public Criteria andPaperNameGreaterThan(String value) {
            addCriterion("paper_name >", value, "paperName");
            return (Criteria) this;
        }

        public Criteria andPaperNameGreaterThanOrEqualTo(String value) {
            addCriterion("paper_name >=", value, "paperName");
            return (Criteria) this;
        }

        public Criteria andPaperNameLessThan(String value) {
            addCriterion("paper_name <", value, "paperName");
            return (Criteria) this;
        }

        public Criteria andPaperNameLessThanOrEqualTo(String value) {
            addCriterion("paper_name <=", value, "paperName");
            return (Criteria) this;
        }

        public Criteria andPaperNameLike(String value) {
            addCriterion("paper_name like", value, "paperName");
            return (Criteria) this;
        }

        public Criteria andPaperNameNotLike(String value) {
            addCriterion("paper_name not like", value, "paperName");
            return (Criteria) this;
        }

        public Criteria andPaperNameIn(List<String> values) {
            addCriterion("paper_name in", values, "paperName");
            return (Criteria) this;
        }

        public Criteria andPaperNameNotIn(List<String> values) {
            addCriterion("paper_name not in", values, "paperName");
            return (Criteria) this;
        }

        public Criteria andPaperNameBetween(String value1, String value2) {
            addCriterion("paper_name between", value1, value2, "paperName");
            return (Criteria) this;
        }

        public Criteria andPaperNameNotBetween(String value1, String value2) {
            addCriterion("paper_name not between", value1, value2, "paperName");
            return (Criteria) this;
        }

        public Criteria andTotalScoreIsNull() {
            addCriterion("total_score is null");
            return (Criteria) this;
        }

        public Criteria andTotalScoreIsNotNull() {
            addCriterion("total_score is not null");
            return (Criteria) this;
        }

        public Criteria andTotalScoreEqualTo(Integer value) {
            addCriterion("total_score =", value, "totalScore");
            return (Criteria) this;
        }

        public Criteria andTotalScoreNotEqualTo(Integer value) {
            addCriterion("total_score <>", value, "totalScore");
            return (Criteria) this;
        }

        public Criteria andTotalScoreGreaterThan(Integer value) {
            addCriterion("total_score >", value, "totalScore");
            return (Criteria) this;
        }

        public Criteria andTotalScoreGreaterThanOrEqualTo(Integer value) {
            addCriterion("total_score >=", value, "totalScore");
            return (Criteria) this;
        }

        public Criteria andTotalScoreLessThan(Integer value) {
            addCriterion("total_score <", value, "totalScore");
            return (Criteria) this;
        }

        public Criteria andTotalScoreLessThanOrEqualTo(Integer value) {
            addCriterion("total_score <=", value, "totalScore");
            return (Criteria) this;
        }

        public Criteria andTotalScoreIn(List<Integer> values) {
            addCriterion("total_score in", values, "totalScore");
            return (Criteria) this;
        }

        public Criteria andTotalScoreNotIn(List<Integer> values) {
            addCriterion("total_score not in", values, "totalScore");
            return (Criteria) this;
        }

        public Criteria andTotalScoreBetween(Integer value1, Integer value2) {
            addCriterion("total_score between", value1, value2, "totalScore");
            return (Criteria) this;
        }

        public Criteria andTotalScoreNotBetween(Integer value1, Integer value2) {
            addCriterion("total_score not between", value1, value2, "totalScore");
            return (Criteria) this;
        }

        public Criteria andCreateTimeIsNull() {
            addCriterion("create_time is null");
            return (Criteria) this;
        }

        public Criteria andCreateTimeIsNotNull() {
            addCriterion("create_time is not null");
            return (Criteria) this;
        }

        public Criteria andCreateTimeEqualTo(Date value) {
            addCriterion("create_time =", value, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeNotEqualTo(Date value) {
            addCriterion("create_time <>", value, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeGreaterThan(Date value) {
            addCriterion("create_time >", value, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeGreaterThanOrEqualTo(Date value) {
            addCriterion("create_time >=", value, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeLessThan(Date value) {
            addCriterion("create_time <", value, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeLessThanOrEqualTo(Date value) {
            addCriterion("create_time <=", value, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeIn(List<Date> values) {
            addCriterion("create_time in", values, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeNotIn(List<Date> values) {
            addCriterion("create_time not in", values, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeBetween(Date value1, Date value2) {
            addCriterion("create_time between", value1, value2, "createTime");
            return (Criteria) this;
        }

        public Criteria andCreateTimeNotBetween(Date value1, Date value2) {
            addCriterion("create_time not between", value1, value2, "createTime");
            return (Criteria) this;
        }

        public Criteria andStartTimeIsNull() {
            addCriterion("start_time is null");
            return (Criteria) this;
        }

        public Criteria andStartTimeIsNotNull() {
            addCriterion("start_time is not null");
            return (Criteria) this;
        }

        public Criteria andStartTimeEqualTo(Date value) {
            addCriterion("start_time =", value, "startTime");
            return (Criteria) this;
        }

        public Criteria andStartTimeNotEqualTo(Date value) {
            addCriterion("start_time <>", value, "startTime");
            return (Criteria) this;
        }

        public Criteria andStartTimeGreaterThan(Date value) {
            addCriterion("start_time >", value, "startTime");
            return (Criteria) this;
        }

        public Criteria andStartTimeGreaterThanOrEqualTo(Date value) {
            addCriterion("start_time >=", value, "startTime");
            return (Criteria) this;
        }

        public Criteria andStartTimeLessThan(Date value) {
            addCriterion("start_time <", value, "startTime");
            return (Criteria) this;
        }

        public Criteria andStartTimeLessThanOrEqualTo(Date value) {
            addCriterion("start_time <=", value, "startTime");
            return (Criteria) this;
        }

        public Criteria andStartTimeIn(List<Date> values) {
            addCriterion("start_time in", values, "startTime");
            return (Criteria) this;
        }

        public Criteria andStartTimeNotIn(List<Date> values) {
            addCriterion("start_time not in", values, "startTime");
            return (Criteria) this;
        }

        public Criteria andStartTimeBetween(Date value1, Date value2) {
            addCriterion("start_time between", value1, value2, "startTime");
            return (Criteria) this;
        }

        public Criteria andStartTimeNotBetween(Date value1, Date value2) {
            addCriterion("start_time not between", value1, value2, "startTime");
            return (Criteria) this;
        }

        public Criteria andEndTimeIsNull() {
            addCriterion("end_time is null");
            return (Criteria) this;
        }

        public Criteria andEndTimeIsNotNull() {
            addCriterion("end_time is not null");
            return (Criteria) this;
        }

        public Criteria andEndTimeEqualTo(Date value) {
            addCriterion("end_time =", value, "endTime");
            return (Criteria) this;
        }

        public Criteria andEndTimeNotEqualTo(Date value) {
            addCriterion("end_time <>", value, "endTime");
            return (Criteria) this;
        }

        public Criteria andEndTimeGreaterThan(Date value) {
            addCriterion("end_time >", value, "endTime");
            return (Criteria) this;
        }

        public Criteria andEndTimeGreaterThanOrEqualTo(Date value) {
            addCriterion("end_time >=", value, "endTime");
            return (Criteria) this;
        }

        public Criteria andEndTimeLessThan(Date value) {
            addCriterion("end_time <", value, "endTime");
            return (Criteria) this;
        }

        public Criteria andEndTimeLessThanOrEqualTo(Date value) {
            addCriterion("end_time <=", value, "endTime");
            return (Criteria) this;
        }

        public Criteria andEndTimeIn(List<Date> values) {
            addCriterion("end_time in", values, "endTime");
            return (Criteria) this;
        }

        public Criteria andEndTimeNotIn(List<Date> values) {
            addCriterion("end_time not in", values, "endTime");
            return (Criteria) this;
        }

        public Criteria andEndTimeBetween(Date value1, Date value2) {
            addCriterion("end_time between", value1, value2, "endTime");
            return (Criteria) this;
        }

        public Criteria andEndTimeNotBetween(Date value1, Date value2) {
            addCriterion("end_time not between", value1, value2, "endTime");
            return (Criteria) this;
        }

        public Criteria andDurationTimeIsNull() {
            addCriterion("duration_time is null");
            return (Criteria) this;
        }

        public Criteria andDurationTimeIsNotNull() {
            addCriterion("duration_time is not null");
            return (Criteria) this;
        }

        public Criteria andDurationTimeEqualTo(Integer value) {
            addCriterion("duration_time =", value, "durationTime");
            return (Criteria) this;
        }

        public Criteria andDurationTimeNotEqualTo(Integer value) {
            addCriterion("duration_time <>", value, "durationTime");
            return (Criteria) this;
        }

        public Criteria andDurationTimeGreaterThan(Integer value) {
            addCriterion("duration_time >", value, "durationTime");
            return (Criteria) this;
        }

        public Criteria andDurationTimeGreaterThanOrEqualTo(Integer value) {
            addCriterion("duration_time >=", value, "durationTime");
            return (Criteria) this;
        }

        public Criteria andDurationTimeLessThan(Integer value) {
            addCriterion("duration_time <", value, "durationTime");
            return (Criteria) this;
        }

        public Criteria andDurationTimeLessThanOrEqualTo(Integer value) {
            addCriterion("duration_time <=", value, "durationTime");
            return (Criteria) this;
        }

        public Criteria andDurationTimeIn(List<Integer> values) {
            addCriterion("duration_time in", values, "durationTime");
            return (Criteria) this;
        }

        public Criteria andDurationTimeNotIn(List<Integer> values) {
            addCriterion("duration_time not in", values, "durationTime");
            return (Criteria) this;
        }

        public Criteria andDurationTimeBetween(Integer value1, Integer value2) {
            addCriterion("duration_time between", value1, value2, "durationTime");
            return (Criteria) this;
        }

        public Criteria andDurationTimeNotBetween(Integer value1, Integer value2) {
            addCriterion("duration_time not between", value1, value2, "durationTime");
            return (Criteria) this;
        }

        public Criteria andQuestionCountIsNull() {
            addCriterion("question_count is null");
            return (Criteria) this;
        }

        public Criteria andQuestionCountIsNotNull() {
            addCriterion("question_count is not null");
            return (Criteria) this;
        }

        public Criteria andQuestionCountEqualTo(Integer value) {
            addCriterion("question_count =", value, "questionCount");
            return (Criteria) this;
        }

        public Criteria andQuestionCountNotEqualTo(Integer value) {
            addCriterion("question_count <>", value, "questionCount");
            return (Criteria) this;
        }

        public Criteria andQuestionCountGreaterThan(Integer value) {
            addCriterion("question_count >", value, "questionCount");
            return (Criteria) this;
        }

        public Criteria andQuestionCountGreaterThanOrEqualTo(Integer value) {
            addCriterion("question_count >=", value, "questionCount");
            return (Criteria) this;
        }

        public Criteria andQuestionCountLessThan(Integer value) {
            addCriterion("question_count <", value, "questionCount");
            return (Criteria) this;
        }

        public Criteria andQuestionCountLessThanOrEqualTo(Integer value) {
            addCriterion("question_count <=", value, "questionCount");
            return (Criteria) this;
        }

        public Criteria andQuestionCountIn(List<Integer> values) {
            addCriterion("question_count in", values, "questionCount");
            return (Criteria) this;
        }

        public Criteria andQuestionCountNotIn(List<Integer> values) {
            addCriterion("question_count not in", values, "questionCount");
            return (Criteria) this;
        }

        public Criteria andQuestionCountBetween(Integer value1, Integer value2) {
            addCriterion("question_count between", value1, value2, "questionCount");
            return (Criteria) this;
        }

        public Criteria andQuestionCountNotBetween(Integer value1, Integer value2) {
            addCriterion("question_count not between", value1, value2, "questionCount");
            return (Criteria) this;
        }

        public Criteria andIsEncryIsNull() {
            addCriterion("is_encry is null");
            return (Criteria) this;
        }

        public Criteria andIsEncryIsNotNull() {
            addCriterion("is_encry is not null");
            return (Criteria) this;
        }

        public Criteria andIsEncryEqualTo(Integer value) {
            addCriterion("is_encry =", value, "isEncry");
            return (Criteria) this;
        }

        public Criteria andIsEncryNotEqualTo(Integer value) {
            addCriterion("is_encry <>", value, "isEncry");
            return (Criteria) this;
        }

        public Criteria andIsEncryGreaterThan(Integer value) {
            addCriterion("is_encry >", value, "isEncry");
            return (Criteria) this;
        }

        public Criteria andIsEncryGreaterThanOrEqualTo(Integer value) {
            addCriterion("is_encry >=", value, "isEncry");
            return (Criteria) this;
        }

        public Criteria andIsEncryLessThan(Integer value) {
            addCriterion("is_encry <", value, "isEncry");
            return (Criteria) this;
        }

        public Criteria andIsEncryLessThanOrEqualTo(Integer value) {
            addCriterion("is_encry <=", value, "isEncry");
            return (Criteria) this;
        }

        public Criteria andIsEncryIn(List<Integer> values) {
            addCriterion("is_encry in", values, "isEncry");
            return (Criteria) this;
        }

        public Criteria andIsEncryNotIn(List<Integer> values) {
            addCriterion("is_encry not in", values, "isEncry");
            return (Criteria) this;
        }

        public Criteria andIsEncryBetween(Integer value1, Integer value2) {
            addCriterion("is_encry between", value1, value2, "isEncry");
            return (Criteria) this;
        }

        public Criteria andIsEncryNotBetween(Integer value1, Integer value2) {
            addCriterion("is_encry not between", value1, value2, "isEncry");
            return (Criteria) this;
        }

        public Criteria andInviCodeIsNull() {
            addCriterion("invi_code is null");
            return (Criteria) this;
        }

        public Criteria andInviCodeIsNotNull() {
            addCriterion("invi_code is not null");
            return (Criteria) this;
        }

        public Criteria andInviCodeEqualTo(String value) {
            addCriterion("invi_code =", value, "inviCode");
            return (Criteria) this;
        }

        public Criteria andInviCodeNotEqualTo(String value) {
            addCriterion("invi_code <>", value, "inviCode");
            return (Criteria) this;
        }

        public Criteria andInviCodeGreaterThan(String value) {
            addCriterion("invi_code >", value, "inviCode");
            return (Criteria) this;
        }

        public Criteria andInviCodeGreaterThanOrEqualTo(String value) {
            addCriterion("invi_code >=", value, "inviCode");
            return (Criteria) this;
        }

        public Criteria andInviCodeLessThan(String value) {
            addCriterion("invi_code <", value, "inviCode");
            return (Criteria) this;
        }

        public Criteria andInviCodeLessThanOrEqualTo(String value) {
            addCriterion("invi_code <=", value, "inviCode");
            return (Criteria) this;
        }

        public Criteria andInviCodeLike(String value) {
            addCriterion("invi_code like", value, "inviCode");
            return (Criteria) this;
        }

        public Criteria andInviCodeNotLike(String value) {
            addCriterion("invi_code not like", value, "inviCode");
            return (Criteria) this;
        }

        public Criteria andInviCodeIn(List<String> values) {
            addCriterion("invi_code in", values, "inviCode");
            return (Criteria) this;
        }

        public Criteria andInviCodeNotIn(List<String> values) {
            addCriterion("invi_code not in", values, "inviCode");
            return (Criteria) this;
        }

        public Criteria andInviCodeBetween(String value1, String value2) {
            addCriterion("invi_code between", value1, value2, "inviCode");
            return (Criteria) this;
        }

        public Criteria andInviCodeNotBetween(String value1, String value2) {
            addCriterion("invi_code not between", value1, value2, "inviCode");
            return (Criteria) this;
        }

        public Criteria andCreaterIdIsNull() {
            addCriterion("creater_id is null");
            return (Criteria) this;
        }

        public Criteria andCreaterIdIsNotNull() {
            addCriterion("creater_id is not null");
            return (Criteria) this;
        }

        public Criteria andCreaterIdEqualTo(Integer value) {
            addCriterion("creater_id =", value, "createrId");
            return (Criteria) this;
        }

        public Criteria andCreaterIdNotEqualTo(Integer value) {
            addCriterion("creater_id <>", value, "createrId");
            return (Criteria) this;
        }

        public Criteria andCreaterIdGreaterThan(Integer value) {
            addCriterion("creater_id >", value, "createrId");
            return (Criteria) this;
        }

        public Criteria andCreaterIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("creater_id >=", value, "createrId");
            return (Criteria) this;
        }

        public Criteria andCreaterIdLessThan(Integer value) {
            addCriterion("creater_id <", value, "createrId");
            return (Criteria) this;
        }

        public Criteria andCreaterIdLessThanOrEqualTo(Integer value) {
            addCriterion("creater_id <=", value, "createrId");
            return (Criteria) this;
        }

        public Criteria andCreaterIdIn(List<Integer> values) {
            addCriterion("creater_id in", values, "createrId");
            return (Criteria) this;
        }

        public Criteria andCreaterIdNotIn(List<Integer> values) {
            addCriterion("creater_id not in", values, "createrId");
            return (Criteria) this;
        }

        public Criteria andCreaterIdBetween(Integer value1, Integer value2) {
            addCriterion("creater_id between", value1, value2, "createrId");
            return (Criteria) this;
        }

        public Criteria andCreaterIdNotBetween(Integer value1, Integer value2) {
            addCriterion("creater_id not between", value1, value2, "createrId");
            return (Criteria) this;
        }
    }

    public static class Criteria extends GeneratedCriteria {

        protected Criteria() {
            super();
        }
    }

    public static class Criterion {
        private String condition;

        private Object value;

        private Object secondValue;

        private boolean noValue;

        private boolean singleValue;

        private boolean betweenValue;

        private boolean listValue;

        private String typeHandler;

        public String getCondition() {
            return condition;
        }

        public Object getValue() {
            return value;
        }

        public Object getSecondValue() {
            return secondValue;
        }

        public boolean isNoValue() {
            return noValue;
        }

        public boolean isSingleValue() {
            return singleValue;
        }

        public boolean isBetweenValue() {
            return betweenValue;
        }

        public boolean isListValue() {
            return listValue;
        }

        public String getTypeHandler() {
            return typeHandler;
        }

        protected Criterion(String condition) {
            super();
            this.condition = condition;
            this.typeHandler = null;
            this.noValue = true;
        }

        protected Criterion(String condition, Object value, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.typeHandler = typeHandler;
            if (value instanceof List<?>) {
                this.listValue = true;
            } else {
                this.singleValue = true;
            }
        }

        protected Criterion(String condition, Object value) {
            this(condition, value, null);
        }

        protected Criterion(String condition, Object value, Object secondValue, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.secondValue = secondValue;
            this.typeHandler = typeHandler;
            this.betweenValue = true;
        }

        protected Criterion(String condition, Object value, Object secondValue) {
            this(condition, value, secondValue, null);
        }
    }
}