package com.wale.exam.bean;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class MessageUserExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public MessageUserExample() {
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

        public Criteria andMessageIdIsNull() {
            addCriterion("message_id is null");
            return (Criteria) this;
        }

        public Criteria andMessageIdIsNotNull() {
            addCriterion("message_id is not null");
            return (Criteria) this;
        }

        public Criteria andMessageIdEqualTo(Integer value) {
            addCriterion("message_id =", value, "messageId");
            return (Criteria) this;
        }

        public Criteria andMessageIdNotEqualTo(Integer value) {
            addCriterion("message_id <>", value, "messageId");
            return (Criteria) this;
        }

        public Criteria andMessageIdGreaterThan(Integer value) {
            addCriterion("message_id >", value, "messageId");
            return (Criteria) this;
        }

        public Criteria andMessageIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("message_id >=", value, "messageId");
            return (Criteria) this;
        }

        public Criteria andMessageIdLessThan(Integer value) {
            addCriterion("message_id <", value, "messageId");
            return (Criteria) this;
        }

        public Criteria andMessageIdLessThanOrEqualTo(Integer value) {
            addCriterion("message_id <=", value, "messageId");
            return (Criteria) this;
        }

        public Criteria andMessageIdIn(List<Integer> values) {
            addCriterion("message_id in", values, "messageId");
            return (Criteria) this;
        }

        public Criteria andMessageIdNotIn(List<Integer> values) {
            addCriterion("message_id not in", values, "messageId");
            return (Criteria) this;
        }

        public Criteria andMessageIdBetween(Integer value1, Integer value2) {
            addCriterion("message_id between", value1, value2, "messageId");
            return (Criteria) this;
        }

        public Criteria andMessageIdNotBetween(Integer value1, Integer value2) {
            addCriterion("message_id not between", value1, value2, "messageId");
            return (Criteria) this;
        }

        public Criteria andReceiveUserIdIsNull() {
            addCriterion("receive_user_id is null");
            return (Criteria) this;
        }

        public Criteria andReceiveUserIdIsNotNull() {
            addCriterion("receive_user_id is not null");
            return (Criteria) this;
        }

        public Criteria andReceiveUserIdEqualTo(Integer value) {
            addCriterion("receive_user_id =", value, "receiveUserId");
            return (Criteria) this;
        }

        public Criteria andReceiveUserIdNotEqualTo(Integer value) {
            addCriterion("receive_user_id <>", value, "receiveUserId");
            return (Criteria) this;
        }

        public Criteria andReceiveUserIdGreaterThan(Integer value) {
            addCriterion("receive_user_id >", value, "receiveUserId");
            return (Criteria) this;
        }

        public Criteria andReceiveUserIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("receive_user_id >=", value, "receiveUserId");
            return (Criteria) this;
        }

        public Criteria andReceiveUserIdLessThan(Integer value) {
            addCriterion("receive_user_id <", value, "receiveUserId");
            return (Criteria) this;
        }

        public Criteria andReceiveUserIdLessThanOrEqualTo(Integer value) {
            addCriterion("receive_user_id <=", value, "receiveUserId");
            return (Criteria) this;
        }

        public Criteria andReceiveUserIdIn(List<Integer> values) {
            addCriterion("receive_user_id in", values, "receiveUserId");
            return (Criteria) this;
        }

        public Criteria andReceiveUserIdNotIn(List<Integer> values) {
            addCriterion("receive_user_id not in", values, "receiveUserId");
            return (Criteria) this;
        }

        public Criteria andReceiveUserIdBetween(Integer value1, Integer value2) {
            addCriterion("receive_user_id between", value1, value2, "receiveUserId");
            return (Criteria) this;
        }

        public Criteria andReceiveUserIdNotBetween(Integer value1, Integer value2) {
            addCriterion("receive_user_id not between", value1, value2, "receiveUserId");
            return (Criteria) this;
        }

        public Criteria andReceiveUserNameIsNull() {
            addCriterion("receive_user_name is null");
            return (Criteria) this;
        }

        public Criteria andReceiveUserNameIsNotNull() {
            addCriterion("receive_user_name is not null");
            return (Criteria) this;
        }

        public Criteria andReceiveUserNameEqualTo(String value) {
            addCriterion("receive_user_name =", value, "receiveUserName");
            return (Criteria) this;
        }

        public Criteria andReceiveUserNameNotEqualTo(String value) {
            addCriterion("receive_user_name <>", value, "receiveUserName");
            return (Criteria) this;
        }

        public Criteria andReceiveUserNameGreaterThan(String value) {
            addCriterion("receive_user_name >", value, "receiveUserName");
            return (Criteria) this;
        }

        public Criteria andReceiveUserNameGreaterThanOrEqualTo(String value) {
            addCriterion("receive_user_name >=", value, "receiveUserName");
            return (Criteria) this;
        }

        public Criteria andReceiveUserNameLessThan(String value) {
            addCriterion("receive_user_name <", value, "receiveUserName");
            return (Criteria) this;
        }

        public Criteria andReceiveUserNameLessThanOrEqualTo(String value) {
            addCriterion("receive_user_name <=", value, "receiveUserName");
            return (Criteria) this;
        }

        public Criteria andReceiveUserNameLike(String value) {
            addCriterion("receive_user_name like", value, "receiveUserName");
            return (Criteria) this;
        }

        public Criteria andReceiveUserNameNotLike(String value) {
            addCriterion("receive_user_name not like", value, "receiveUserName");
            return (Criteria) this;
        }

        public Criteria andReceiveUserNameIn(List<String> values) {
            addCriterion("receive_user_name in", values, "receiveUserName");
            return (Criteria) this;
        }

        public Criteria andReceiveUserNameNotIn(List<String> values) {
            addCriterion("receive_user_name not in", values, "receiveUserName");
            return (Criteria) this;
        }

        public Criteria andReceiveUserNameBetween(String value1, String value2) {
            addCriterion("receive_user_name between", value1, value2, "receiveUserName");
            return (Criteria) this;
        }

        public Criteria andReceiveUserNameNotBetween(String value1, String value2) {
            addCriterion("receive_user_name not between", value1, value2, "receiveUserName");
            return (Criteria) this;
        }

        public Criteria andReceiveRealNameIsNull() {
            addCriterion("receive_real_name is null");
            return (Criteria) this;
        }

        public Criteria andReceiveRealNameIsNotNull() {
            addCriterion("receive_real_name is not null");
            return (Criteria) this;
        }

        public Criteria andReceiveRealNameEqualTo(String value) {
            addCriterion("receive_real_name =", value, "receiveRealName");
            return (Criteria) this;
        }

        public Criteria andReceiveRealNameNotEqualTo(String value) {
            addCriterion("receive_real_name <>", value, "receiveRealName");
            return (Criteria) this;
        }

        public Criteria andReceiveRealNameGreaterThan(String value) {
            addCriterion("receive_real_name >", value, "receiveRealName");
            return (Criteria) this;
        }

        public Criteria andReceiveRealNameGreaterThanOrEqualTo(String value) {
            addCriterion("receive_real_name >=", value, "receiveRealName");
            return (Criteria) this;
        }

        public Criteria andReceiveRealNameLessThan(String value) {
            addCriterion("receive_real_name <", value, "receiveRealName");
            return (Criteria) this;
        }

        public Criteria andReceiveRealNameLessThanOrEqualTo(String value) {
            addCriterion("receive_real_name <=", value, "receiveRealName");
            return (Criteria) this;
        }

        public Criteria andReceiveRealNameLike(String value) {
            addCriterion("receive_real_name like", value, "receiveRealName");
            return (Criteria) this;
        }

        public Criteria andReceiveRealNameNotLike(String value) {
            addCriterion("receive_real_name not like", value, "receiveRealName");
            return (Criteria) this;
        }

        public Criteria andReceiveRealNameIn(List<String> values) {
            addCriterion("receive_real_name in", values, "receiveRealName");
            return (Criteria) this;
        }

        public Criteria andReceiveRealNameNotIn(List<String> values) {
            addCriterion("receive_real_name not in", values, "receiveRealName");
            return (Criteria) this;
        }

        public Criteria andReceiveRealNameBetween(String value1, String value2) {
            addCriterion("receive_real_name between", value1, value2, "receiveRealName");
            return (Criteria) this;
        }

        public Criteria andReceiveRealNameNotBetween(String value1, String value2) {
            addCriterion("receive_real_name not between", value1, value2, "receiveRealName");
            return (Criteria) this;
        }

        public Criteria andReadedIsNull() {
            addCriterion("readed is null");
            return (Criteria) this;
        }

        public Criteria andReadedIsNotNull() {
            addCriterion("readed is not null");
            return (Criteria) this;
        }

        public Criteria andReadedEqualTo(Boolean value) {
            addCriterion("readed =", value, "readed");
            return (Criteria) this;
        }

        public Criteria andReadedNotEqualTo(Boolean value) {
            addCriterion("readed <>", value, "readed");
            return (Criteria) this;
        }

        public Criteria andReadedGreaterThan(Boolean value) {
            addCriterion("readed >", value, "readed");
            return (Criteria) this;
        }

        public Criteria andReadedGreaterThanOrEqualTo(Boolean value) {
            addCriterion("readed >=", value, "readed");
            return (Criteria) this;
        }

        public Criteria andReadedLessThan(Boolean value) {
            addCriterion("readed <", value, "readed");
            return (Criteria) this;
        }

        public Criteria andReadedLessThanOrEqualTo(Boolean value) {
            addCriterion("readed <=", value, "readed");
            return (Criteria) this;
        }

        public Criteria andReadedIn(List<Boolean> values) {
            addCriterion("readed in", values, "readed");
            return (Criteria) this;
        }

        public Criteria andReadedNotIn(List<Boolean> values) {
            addCriterion("readed not in", values, "readed");
            return (Criteria) this;
        }

        public Criteria andReadedBetween(Boolean value1, Boolean value2) {
            addCriterion("readed between", value1, value2, "readed");
            return (Criteria) this;
        }

        public Criteria andReadedNotBetween(Boolean value1, Boolean value2) {
            addCriterion("readed not between", value1, value2, "readed");
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

        public Criteria andReadTimeIsNull() {
            addCriterion("read_time is null");
            return (Criteria) this;
        }

        public Criteria andReadTimeIsNotNull() {
            addCriterion("read_time is not null");
            return (Criteria) this;
        }

        public Criteria andReadTimeEqualTo(Date value) {
            addCriterion("read_time =", value, "readTime");
            return (Criteria) this;
        }

        public Criteria andReadTimeNotEqualTo(Date value) {
            addCriterion("read_time <>", value, "readTime");
            return (Criteria) this;
        }

        public Criteria andReadTimeGreaterThan(Date value) {
            addCriterion("read_time >", value, "readTime");
            return (Criteria) this;
        }

        public Criteria andReadTimeGreaterThanOrEqualTo(Date value) {
            addCriterion("read_time >=", value, "readTime");
            return (Criteria) this;
        }

        public Criteria andReadTimeLessThan(Date value) {
            addCriterion("read_time <", value, "readTime");
            return (Criteria) this;
        }

        public Criteria andReadTimeLessThanOrEqualTo(Date value) {
            addCriterion("read_time <=", value, "readTime");
            return (Criteria) this;
        }

        public Criteria andReadTimeIn(List<Date> values) {
            addCriterion("read_time in", values, "readTime");
            return (Criteria) this;
        }

        public Criteria andReadTimeNotIn(List<Date> values) {
            addCriterion("read_time not in", values, "readTime");
            return (Criteria) this;
        }

        public Criteria andReadTimeBetween(Date value1, Date value2) {
            addCriterion("read_time between", value1, value2, "readTime");
            return (Criteria) this;
        }

        public Criteria andReadTimeNotBetween(Date value1, Date value2) {
            addCriterion("read_time not between", value1, value2, "readTime");
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