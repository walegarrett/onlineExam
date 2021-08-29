use exam;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
-- 管理员表
DROP TABLE IF EXISTS `exam_admin`;
-- create table exam_admin(
--     id int(11) not null auto_increment,
--     admin_name varchar(255) COMMENT '管理员用户名',
--     password varchar(255),
--     real_name varchar(255) COMMENT '真实姓名',
--     email varchar(255),
--     phone varchar(255),
--     sex int(11),
--     PRIMARY KEY (id)
-- );
-- 用户表
DROP TABLE IF EXISTS `exam_user`;
create table exam_user(
    id int(11) not null auto_increment,
    user_name varchar(255) COMMENT '用户名',
    password varchar(255),
    real_name varchar(255) COMMENT '真实姓名',
    email varchar(255),
    phone varchar(255),
    sex int(11),
    age int(11),
    role int(11) comment '1. 学生，2. 老师,3. 管理员',
    create_time datetime(0) comment '用户注册时间',
    image_path varchar(255) comment '用户头像地址',
    PRIMARY KEY (id)
);
-- 试卷表
DROP TABLE IF EXISTS `exam_paper`;
create table exam_paper(
    id int(11) not null auto_increment,
    paper_name varchar(255) COMMENT '试卷名',
    total_score int(11) COMMENT '试卷总分',
    create_time datetime(0) comment '发布时间',
    start_time datetime(0) comment '开始时间',
    end_time datetime(0) comment '结束时间',
    duration_time int(0) comment '持续时间',
    question_count int(11) comment '试题数量',
    is_encry int(11) comment '试卷是否加密',
    invi_code varchar(255) comment '答题邀请码',
    creater_id int(11) comment '试卷创建者id',
    PRIMARY KEY (id),
    FOREIGN KEY (creater_id) REFERENCES exam_user (id)
);
-- 试题表
DROP TABLE IF EXISTS `exam_question`;
create table exam_question(
    id int(11) not null auto_increment,
    content text COMMENT '题目描述：包括选项（A,B,C,D,,,）的具体描述',
    answer varchar(500) comment '准确答案',
    type int(11) comment '试题类型：1. 单选，2. 多选，3. 判断，4. 填空，5. 简答',
    create_time datetime(0) comment '创建时间',
    analysis varchar(500) comment '试题解析',
    score int(11) comment '该题分数',
    creater_id int(11) comment '试卷创建者id',
    PRIMARY KEY (id),
    FOREIGN KEY (creater_id) REFERENCES exam_user (id)
);
-- 答题记录表
DROP TABLE IF EXISTS `exam_answer`;
create table exam_answer(
    id int(11) not null auto_increment,
    user_id int(11) comment '答题者id',
    question_id int(11) comment '对应的试题id',
    paper_id int(11) comment '对应的试卷id',
    answer varchar(500) comment '填写的答案',
    score int(11) comment '该题得分',
    comment varchar(255) comment '评语',
    status int(11) comment '是否批改',
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES exam_user (id),
    FOREIGN KEY (question_id) REFERENCES exam_question (id),
    FOREIGN KEY (paper_id) REFERENCES exam_paper (id)
);
-- 考试记录表
DROP TABLE IF EXISTS `exam_info`;
create table exam_info(
    id int(11) not null auto_increment,
    user_id int(11) comment '答题者id',
    paper_id int(11) comment '对应的试卷id',
    submit_time datetime(0) comment '提交试卷时间',
    do_time int(11) comment '答卷耗时',
    score int(11) comment '试卷总分',
    comment varchar(255) comment '评语',
    status int(11) comment '是否批改',
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES exam_user (id),
    FOREIGN KEY (paper_id) REFERENCES exam_paper (id)
);
-- 试卷试题关联表
DROP TABLE IF EXISTS `exam_paper_question`;
create table exam_paper_question(
    id int(11) not null auto_increment,
    paper_id int(11) comment '对应的试卷id',
    question_id int(11) comment '对应的试题id',
    PRIMARY KEY (id),
    FOREIGN KEY (question_id) REFERENCES exam_user (id),
    FOREIGN KEY (paper_id) REFERENCES exam_paper (id)
);
-- ----------------------------
-- 用户发送信息表 exam_message
-- ----------------------------
DROP TABLE IF EXISTS `exam_message`;
CREATE TABLE `exam_message`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '内容',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `send_user_id` int(11) NULL DEFAULT NULL COMMENT '发送者用户ID',
  `send_user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发送者用户名',
  `send_real_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发送者真实姓名',
  `receive_user_count` int(11) NULL DEFAULT NULL COMMENT '接收人数',
  `read_count` int(11) NULL DEFAULT NULL COMMENT '已读人数',
  PRIMARY KEY (`id`) USING BTREE,
  FOREIGN KEY (send_user_id) REFERENCES exam_user (id)
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- 用户接收信息表  exam_message_user
-- ----------------------------
DROP TABLE IF EXISTS `exam_message_user`;
CREATE TABLE `exam_message_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message_id` int(11) NULL DEFAULT NULL COMMENT '消息内容ID',
  `receive_user_id` int(11) NULL DEFAULT NULL COMMENT '接收人ID',
  `receive_user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '接收人用户名',
  `receive_real_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '接收人真实姓名',
  `readed` bit(1) NULL DEFAULT NULL COMMENT '是否已读',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `read_time` datetime(0) NULL DEFAULT NULL COMMENT '阅读时间',
  PRIMARY KEY (`id`) USING BTREE,
  FOREIGN KEY (receive_user_id) REFERENCES exam_user (id)
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for exam_user_event_log用户日志
-- ----------------------------
DROP TABLE IF EXISTS `exam_user_event_log`;
CREATE TABLE `exam_user_event_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `real_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`) USING BTREE,
  FOREIGN KEY (user_id) REFERENCES exam_user (id)
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;
