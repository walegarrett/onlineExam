package com.wale.exam.bean;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class MessageExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public MessageExample() {
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

        public Criteria andTitleIsNull() {
            addCriterion("title is null");
            return (Criteria) this;
        }

        public Criteria andTitleIsNotNull() {
            addCriterion("title is not null");
            return (Criteria) this;
        }

        public Criteria andTitleEqualTo(String value) {
            addCriterion("title =", value, "title");
            return (Criteria) this;
        }

        public Criteria andTitleNotEqualTo(String value) {
            addCriterion("title <>", value, "title");
            return (Criteria) this;
        }

        public Criteria andTitleGreaterThan(String value) {
            addCriterion("title >", value, "title");
            return (Criteria) this;
        }

        public Criteria andTitleGreaterThanOrEqualTo(String value) {
            addCriterion("title >=", value, "title");
            return (Criteria) this;
        }

        public Criteria andTitleLessThan(String value) {
            addCriterion("title <", value, "title");
            return (Criteria) this;
        }

        public Criteria andTitleLessThanOrEqualTo(String value) {
            addCriterion("title <=", value, "title");
            return (Criteria) this;
        }

        public Criteria andTitleLike(String value) {
            addCriterion("title like", value, "title");
            return (Criteria) this;
        }

        public Criteria andTitleNotLike(String value) {
            addCriterion("title not like", value, "title");
            return (Criteria) this;
        }

        public Criteria andTitleIn(List<String> values) {
            addCriterion("title in", values, "title");
            return (Criteria) this;
        }

        public Criteria andTitleNotIn(List<String> values) {
            addCriterion("title not in", values, "title");
            return (Criteria) this;
        }

        public Criteria andTitleBetween(String value1, String value2) {
            addCriterion("title between", value1, value2, "title");
            return (Criteria) this;
        }

        public Criteria andTitleNotBetween(String value1, String value2) {
            addCriterion("title not between", value1, value2, "title");
            return (Criteria) this;
        }

        public Criteria andContentIsNull() {
            addCriterion("content is null");
            return (Criteria) this;
        }

        public Criteria andContentIsNotNull() {
            addCriterion("content is not null");
            return (Criteria) this;
        }

        public Criteria andContentEqualTo(String value) {
            addCriterion("content =", value, "content");
            return (Criteria) this;
        }

        public Criteria andContentNotEqualTo(String value) {
            addCriterion("content <>", value, "content");
            return (Criteria) this;
        }

        public Criteria andContentGreaterThan(String value) {
            addCriterion("content >", value, "content");
            return (Criteria) this;
        }

        public Criteria andContentGreaterThanOrEqualTo(String value) {
            addCriterion("content >=", value, "content");
            return (Criteria) this;
        }

        public Criteria andContentLessThan(String value) {
            addCriterion("content <", value, "content");
            return (Criteria) this;
        }

        public Criteria andContentLessThanOrEqualTo(String value) {
            addCriterion("content <=", value, "content");
            return (Criteria) this;
        }

        public Criteria andContentLike(String value) {
            addCriterion("content like", value, "content");
            return (Criteria) this;
        }

        public Criteria andContentNotLike(String value) {
            addCriterion("content not like", value, "content");
            return (Criteria) this;
        }

        public Criteria andContentIn(List<String> values) {
            addCriterion("content in", values, "content");
            return (Criteria) this;
        }

        public Criteria andContentNotIn(List<String> values) {
            addCriterion("content not in", values, "content");
            return (Criteria) this;
        }

        public Criteria andContentBetween(String value1, String value2) {
            addCriterion("content between", value1, value2, "content");
            return (Criteria) this;
        }

        public Criteria andContentNotBetween(String value1, String value2) {
            addCriterion("content not between", value1, value2, "content");
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

        public Criteria andSendUserIdIsNull() {
            addCriterion("send_user_id is null");
            return (Criteria) this;
        }

        public Criteria andSendUserIdIsNotNull() {
            addCriterion("send_user_id is not null");
            return (Criteria) this;
        }

        public Criteria andSendUserIdEqualTo(Integer value) {
            addCriterion("send_user_id =", value, "sendUserId");
            return (Criteria) this;
        }

        public Criteria andSendUserIdNotEqualTo(Integer value) {
            addCriterion("send_user_id <>", value, "sendUserId");
            return (Criteria) this;
        }

        public Criteria andSendUserIdGreaterThan(Integer value) {
            addCriterion("send_user_id >", value, "sendUserId");
            return (Criteria) this;
        }

        public Criteria andSendUserIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("send_user_id >=", value, "sendUserId");
            return (Criteria) this;
        }

        public Criteria andSendUserIdLessThan(Integer value) {
            addCriterion("send_user_id <", value, "sendUserId");
            return (Criteria) this;
        }

        public Criteria andSendUserIdLessThanOrEqualTo(Integer value) {
            addCriterion("send_user_id <=", value, "sendUserId");
            return (Criteria) this;
        }

        public Criteria andSendUserIdIn(List<Integer> values) {
            addCriterion("send_user_id in", values, "sendUserId");
            return (Criteria) this;
        }

        public Criteria andSendUserIdNotIn(List<Integer> values) {
            addCriterion("send_user_id not in", values, "sendUserId");
            return (Criteria) this;
        }

        public Criteria andSendUserIdBetween(Integer value1, Integer value2) {
            addCriterion("send_user_id between", value1, value2, "sendUserId");
            return (Criteria) this;
        }

        public Criteria andSendUserIdNotBetween(Integer value1, Integer value2) {
            addCriterion("send_user_id not between", value1, value2, "sendUserId");
            return (Criteria) this;
        }

        public Criteria andSendUserNameIsNull() {
            addCriterion("send_user_name is null");
            return (Criteria) this;
        }

        public Criteria andSendUserNameIsNotNull() {
            addCriterion("send_user_name is not null");
            return (Criteria) this;
        }

        public Criteria andSendUserNameEqualTo(String value) {
            addCriterion("send_user_name =", value, "sendUserName");
            return (Criteria) this;
        }

        public Criteria andSendUserNameNotEqualTo(String value) {
            addCriterion("send_user_name <>", value, "sendUserName");
            return (Criteria) this;
        }

        public Criteria andSendUserNameGreaterThan(String value) {
            addCriterion("send_user_name >", value, "sendUserName");
            return (Criteria) this;
        }

        public Criteria andSendUserNameGreaterThanOrEqualTo(String value) {
            addCriterion("send_user_name >=", value, "sendUserName");
            return (Criteria) this;
        }

        public Criteria andSendUserNameLessThan(String value) {
            addCriterion("send_user_name <", value, "sendUserName");
            return (Criteria) this;
        }

        public Criteria andSendUserNameLessThanOrEqualTo(String value) {
            addCriterion("send_user_name <=", value, "sendUserName");
            return (Criteria) this;
        }

        public Criteria andSendUserNameLike(String value) {
            addCriterion("send_user_name like", value, "sendUserName");
            return (Criteria) this;
        }

        public Criteria andSendUserNameNotLike(String value) {
            addCriterion("send_user_name not like", value, "sendUserName");
            return (Criteria) this;
        }

        public Criteria andSendUserNameIn(List<String> values) {
            addCriterion("send_user_name in", values, "sendUserName");
            return (Criteria) this;
        }

        public Criteria andSendUserNameNotIn(List<String> values) {
            addCriterion("send_user_name not in", values, "sendUserName");
            return (Criteria) this;
        }

        public Criteria andSendUserNameBetween(String value1, String value2) {
            addCriterion("send_user_name between", value1, value2, "sendUserName");
            return (Criteria) this;
        }

        public Criteria andSendUserNameNotBetween(String value1, String value2) {
            addCriterion("send_user_name not between", value1, value2, "sendUserName");
            return (Criteria) this;
        }

        public Criteria andSendRealNameIsNull() {
            addCriterion("send_real_name is null");
            return (Criteria) this;
        }

        public Criteria andSendRealNameIsNotNull() {
            addCriterion("send_real_name is not null");
            return (Criteria) this;
        }

        public Criteria andSendRealNameEqualTo(String value) {
            addCriterion("send_real_name =", value, "sendRealName");
            return (Criteria) this;
        }

        public Criteria andSendRealNameNotEqualTo(String value) {
            addCriterion("send_real_name <>", value, "sendRealName");
            return (Criteria) this;
        }

        public Criteria andSendRealNameGreaterThan(String value) {
            addCriterion("send_real_name >", value, "sendRealName");
            return (Criteria) this;
        }

        public Criteria andSendRealNameGreaterThanOrEqualTo(String value) {
            addCriterion("send_real_name >=", value, "sendRealName");
            return (Criteria) this;
        }

        public Criteria andSendRealNameLessThan(String value) {
            addCriterion("send_real_name <", value, "sendRealName");
            return (Criteria) this;
        }

        public Criteria andSendRealNameLessThanOrEqualTo(String value) {
            addCriterion("send_real_name <=", value, "sendRealName");
            return (Criteria) this;
        }

        public Criteria andSendRealNameLike(String value) {
            addCriterion("send_real_name like", value, "sendRealName");
            return (Criteria) this;
        }

        public Criteria andSendRealNameNotLike(String value) {
            addCriterion("send_real_name not like", value, "sendRealName");
            return (Criteria) this;
        }

        public Criteria andSendRealNameIn(List<String> values) {
            addCriterion("send_real_name in", values, "sendRealName");
            return (Criteria) this;
        }

        public Criteria andSendRealNameNotIn(List<String> values) {
            addCriterion("send_real_name not in", values, "sendRealName");
            return (Criteria) this;
        }

        public Criteria andSendRealNameBetween(String value1, String value2) {
            addCriterion("send_real_name between", value1, value2, "sendRealName");
            return (Criteria) this;
        }

        public Criteria andSendRealNameNotBetween(String value1, String value2) {
            addCriterion("send_real_name not between", value1, value2, "sendRealName");
            return (Criteria) this;
        }

        public Criteria andReceiveUserCountIsNull() {
            addCriterion("receive_user_count is null");
            return (Criteria) this;
        }

        public Criteria andReceiveUserCountIsNotNull() {
            addCriterion("receive_user_count is not null");
            return (Criteria) this;
        }

        public Criteria andReceiveUserCountEqualTo(Integer value) {
            addCriterion("receive_user_count =", value, "receiveUserCount");
            return (Criteria) this;
        }

        public Criteria andReceiveUserCountNotEqualTo(Integer value) {
            addCriterion("receive_user_count <>", value, "receiveUserCount");
            return (Criteria) this;
        }

        public Criteria andReceiveUserCountGreaterThan(Integer value) {
            addCriterion("receive_user_count >", value, "receiveUserCount");
            return (Criteria) this;
        }

        public Criteria andReceiveUserCountGreaterThanOrEqualTo(Integer value) {
            addCriterion("receive_user_count >=", value, "receiveUserCount");
            return (Criteria) this;
        }

        public Criteria andReceiveUserCountLessThan(Integer value) {
            addCriterion("receive_user_count <", value, "receiveUserCount");
            return (Criteria) this;
        }

        public Criteria andReceiveUserCountLessThanOrEqualTo(Integer value) {
            addCriterion("receive_user_count <=", value, "receiveUserCount");
            return (Criteria) this;
        }

        public Criteria andReceiveUserCountIn(List<Integer> values) {
            addCriterion("receive_user_count in", values, "receiveUserCount");
            return (Criteria) this;
        }

        public Criteria andReceiveUserCountNotIn(List<Integer> values) {
            addCriterion("receive_user_count not in", values, "receiveUserCount");
            return (Criteria) this;
        }

        public Criteria andReceiveUserCountBetween(Integer value1, Integer value2) {
            addCriterion("receive_user_count between", value1, value2, "receiveUserCount");
            return (Criteria) this;
        }

        public Criteria andReceiveUserCountNotBetween(Integer value1, Integer value2) {
            addCriterion("receive_user_count not between", value1, value2, "receiveUserCount");
            return (Criteria) this;
        }

        public Criteria andReadCountIsNull() {
            addCriterion("read_count is null");
            return (Criteria) this;
        }

        public Criteria andReadCountIsNotNull() {
            addCriterion("read_count is not null");
            return (Criteria) this;
        }

        public Criteria andReadCountEqualTo(Integer value) {
            addCriterion("read_count =", value, "readCount");
            return (Criteria) this;
        }

        public Criteria andReadCountNotEqualTo(Integer value) {
            addCriterion("read_count <>", value, "readCount");
            return (Criteria) this;
        }

        public Criteria andReadCountGreaterThan(Integer value) {
            addCriterion("read_count >", value, "readCount");
            return (Criteria) this;
        }

        public Criteria andReadCountGreaterThanOrEqualTo(Integer value) {
            addCriterion("read_count >=", value, "readCount");
            return (Criteria) this;
        }

        public Criteria andReadCountLessThan(Integer value) {
            addCriterion("read_count <", value, "readCount");
            return (Criteria) this;
        }

        public Criteria andReadCountLessThanOrEqualTo(Integer value) {
            addCriterion("read_count <=", value, "readCount");
            return (Criteria) this;
        }

        public Criteria andReadCountIn(List<Integer> values) {
            addCriterion("read_count in", values, "readCount");
            return (Criteria) this;
        }

        public Criteria andReadCountNotIn(List<Integer> values) {
            addCriterion("read_count not in", values, "readCount");
            return (Criteria) this;
        }

        public Criteria andReadCountBetween(Integer value1, Integer value2) {
            addCriterion("read_count between", value1, value2, "readCount");
            return (Criteria) this;
        }

        public Criteria andReadCountNotBetween(Integer value1, Integer value2) {
            addCriterion("read_count not between", value1, value2, "readCount");
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