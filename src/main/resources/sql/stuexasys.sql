/*
Navicat MySQL Data Transfer

Source Server         : mylove1621
Source Server Version : 50713
Source Host           : 127.0.0.1:3306
Source Database       : stuexasys

Target Server Type    : MYSQL
Target Server Version : 50713
File Encoding         : 65001

Date: 2017-09-08 18:06:52
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for com_another_question
-- ----------------------------
DROP TABLE IF EXISTS `com_another_question`;
CREATE TABLE `com_another_question` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `courseId` int(8) NOT NULL COMMENT '课程id',
  `content` varchar(255) DEFAULT NULL COMMENT '内容',
  `result` varchar(255) DEFAULT NULL COMMENT '标准答案',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='附加题表';

-- ----------------------------
-- Table structure for com_course
-- ----------------------------
DROP TABLE IF EXISTS `com_course`;
CREATE TABLE `com_course` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `courseId` int(8) NOT NULL COMMENT '课程id',
  `name` varchar(50) NOT NULL COMMENT '课程名称',
  `period` int(2) DEFAULT NULL COMMENT '学时',
  `credit` int(2) DEFAULT NULL COMMENT '学分',
  PRIMARY KEY (`id`),
  UNIQUE KEY `com_course` (`courseId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='课程表';

-- ----------------------------
-- Table structure for com_examinfo
-- ----------------------------
DROP TABLE IF EXISTS `com_examinfo`;
CREATE TABLE `com_examinfo` (
  `id` int(9) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `teacherId` int(6) NOT NULL COMMENT '教师id',
  `specialtyId` int(6) NOT NULL COMMENT '班级id',
  `courseId` int(8) NOT NULL COMMENT '课程id',
  `content1` varchar(50) DEFAULT NULL COMMENT '考察章节一',
  `date1` date DEFAULT NULL COMMENT '考察时间一',
  `sign1` int(1) DEFAULT NULL COMMENT '考察1，0为关闭，1为开启',
  `content2` varchar(50) DEFAULT NULL COMMENT '考察章节二',
  `date2` date DEFAULT NULL COMMENT '考察时间二',
  `sign2` int(1) DEFAULT NULL COMMENT '考察2，0为关闭，1为开启',
  `content3` varchar(50) DEFAULT NULL COMMENT '考察章节三',
  `date3` date DEFAULT NULL COMMENT '考察时间三',
  `sign3` int(1) DEFAULT NULL COMMENT '考察3，0为关闭，1为开启',
  `date4` date DEFAULT NULL COMMENT '附加题考察时间',
  `sign4` int(1) DEFAULT NULL COMMENT '考察4，0为关闭，1为开启',
  `test` int(1) DEFAULT NULL COMMENT '是否可以测试，0不可，1可以',
  `started` int(1) DEFAULT NULL COMMENT '考试是否开启，0未开启，1开启',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='考试信息表';

-- ----------------------------
-- Table structure for com_grade
-- ----------------------------
DROP TABLE IF EXISTS `com_grade`;
CREATE TABLE `com_grade` (
  `studentId` int(9) NOT NULL COMMENT '学号',
  `courseId` int(8) NOT NULL COMMENT '课程id',
  `grade1` int(3) DEFAULT NULL COMMENT '成绩一',
  `grade2` int(3) DEFAULT NULL COMMENT '成绩二',
  `grade3` int(3) DEFAULT NULL COMMENT '成绩三',
  `grade4` int(3) DEFAULT NULL COMMENT '附加题',
  `total` int(3) DEFAULT NULL COMMENT '总成绩',
  PRIMARY KEY (`studentId`,`courseId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='成绩表';

-- ----------------------------
-- Table structure for com_manager
-- ----------------------------
DROP TABLE IF EXISTS `com_manager`;
CREATE TABLE `com_manager` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `managerId` int(6) NOT NULL COMMENT '管理员id',
  `password` varchar(50) NOT NULL COMMENT '登录密码',
  `name` varchar(50) DEFAULT '管理员' COMMENT '姓名',
  `logintime` datetime DEFAULT NULL COMMENT '登录时间',
  `ip` varchar(15) DEFAULT NULL COMMENT '登录ip',
  PRIMARY KEY (`id`),
  UNIQUE KEY `managerId` (`managerId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='管理员表';

INSERT INTO `stuexasys`.`com_manager` (`id`, `managerId`, `password`, `name`, `logintime`, `ip`) VALUES ('1', '20170520', '363a0175d3d0ffe7c4b46d326360b71f', 'yang', '2017-05-24 19:29:51', '127.0.0.1');


-- ----------------------------
-- Table structure for com_manager_l_role
-- ----------------------------
DROP TABLE IF EXISTS `com_manager_l_role`;
CREATE TABLE `com_manager_l_role` (
  `managerId` int(6) NOT NULL COMMENT '管理员id',
  `roleId` int(6) NOT NULL COMMENT '角色id',
  PRIMARY KEY (`managerId`,`roleId`),
  KEY `roleId` (`roleId`),
  KEY `managerId` (`managerId`),
  CONSTRAINT `com_manager_l_role_fk1` FOREIGN KEY (`managerId`) REFERENCES `com_manager` (`managerId`) ON DELETE CASCADE,
  CONSTRAINT `com_manager_l_role_fk2` FOREIGN KEY (`roleId`) REFERENCES `com_role` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员与角色关联表';

-- ----------------------------
-- Table structure for com_resource
-- ----------------------------
DROP TABLE IF EXISTS `com_resource`;
CREATE TABLE `com_resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) NOT NULL COMMENT '资源名称',
  `remark` varchar(50) DEFAULT NULL COMMENT '备注',
  `permission` varchar(50) NOT NULL COMMENT 'permission许可编码',
  `url` varchar(50) DEFAULT NULL COMMENT '资源地址',
  PRIMARY KEY (`id`),
  UNIQUE KEY `permission` (`permission`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='资源表';

-- ----------------------------
-- Table structure for com_role
-- ----------------------------
DROP TABLE IF EXISTS `com_role`;
CREATE TABLE `com_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) NOT NULL COMMENT '角色名称',
  `remark` varchar(250) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Table structure for com_role_l_resource
-- ----------------------------
DROP TABLE IF EXISTS `com_role_l_resource`;
CREATE TABLE `com_role_l_resource` (
  `roleId` int(11) NOT NULL COMMENT '角色id',
  `resourceId` int(11) NOT NULL COMMENT '资源id',
  PRIMARY KEY (`roleId`,`resourceId`),
  KEY `resourceId` (`resourceId`),
  KEY `roleId` (`roleId`),
  CONSTRAINT `com_role_l_resource_fk1` FOREIGN KEY (`roleId`) REFERENCES `com_role` (`id`) ON DELETE CASCADE,
  CONSTRAINT `com_role_l_resource_fk2` FOREIGN KEY (`resourceId`) REFERENCES `com_resource` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色与资源管理表';

-- ----------------------------
-- Table structure for com_single_question
-- ----------------------------
DROP TABLE IF EXISTS `com_single_question`;
CREATE TABLE `com_single_question` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `courseId` int(8) NOT NULL COMMENT '课程id',
  `section` varchar(50) NOT NULL COMMENT '章节',
  `levels` int(1) NOT NULL COMMENT '难度等级',
  `content` varchar(255) NOT NULL COMMENT '题目正文',
  `que1` varchar(255) NOT NULL COMMENT '选项1',
  `que2` varchar(255) NOT NULL COMMENT '选项2',
  `que3` varchar(255) NOT NULL COMMENT '选项3',
  `que4` varchar(255) NOT NULL COMMENT '选项4',
  `result` char(1) NOT NULL COMMENT '答案',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='单选题表';

-- ----------------------------
-- Table structure for com_specialty
-- ----------------------------
DROP TABLE IF EXISTS `com_specialty`;
CREATE TABLE `com_specialty` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `specialtyId` int(6) NOT NULL COMMENT '专业id',
  `name` varchar(50) NOT NULL COMMENT '专业名称',
  PRIMARY KEY (`id`),
  UNIQUE KEY `com_specialty` (`specialtyId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='专业表';

-- ----------------------------
-- Table structure for com_student
-- ----------------------------
DROP TABLE IF EXISTS `com_student`;
CREATE TABLE `com_student` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `studentId` int(11) NOT NULL COMMENT '学号',
  `password` varchar(50) NOT NULL COMMENT '登录密码',
  `name` varchar(50) DEFAULT '辽工学子' COMMENT '姓名',
  `specialtyId` int(6) NOT NULL COMMENT '班级id',
  `gender` char(2) DEFAULT NULL COMMENT '性别',
  `cellphone` varchar(11) DEFAULT NULL COMMENT '手机号',
  `email` varchar(20) DEFAULT NULL COMMENT '手机号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `com_student` (`studentId`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8 COMMENT='学生表';

-- ----------------------------
-- Table structure for com_student_l_another_question
-- ----------------------------
DROP TABLE IF EXISTS `com_student_l_another_question`;
CREATE TABLE `com_student_l_another_question` (
  `id` bigint(11) NOT NULL COMMENT '主键',
  `studentId` int(9) NOT NULL COMMENT '学生id',
  `courseId` int(8) NOT NULL COMMENT '课程id',
  `result` varchar(255) DEFAULT NULL COMMENT '学生答案',
  PRIMARY KEY (`studentId`,`courseId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='学生附加题答题内容存储表';

-- ----------------------------
-- Table structure for com_studnet_l_role
-- ----------------------------
DROP TABLE IF EXISTS `com_studnet_l_role`;
CREATE TABLE `com_studnet_l_role` (
  `studentId` int(11) NOT NULL,
  `roleId` int(11) NOT NULL,
  PRIMARY KEY (`studentId`,`roleId`),
  KEY `roleId` (`roleId`),
  CONSTRAINT `com_studnet_l_role_ibfk_1` FOREIGN KEY (`studentId`) REFERENCES `com_student` (`studentId`) ON DELETE CASCADE,
  CONSTRAINT `com_studnet_l_role_ibfk_2` FOREIGN KEY (`roleId`) REFERENCES `com_role` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='学生角色连接表';

-- ----------------------------
-- Table structure for com_teacher
-- ----------------------------
DROP TABLE IF EXISTS `com_teacher`;
CREATE TABLE `com_teacher` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `teacherId` int(6) NOT NULL COMMENT '教师id',
  `password` varchar(50) NOT NULL COMMENT '登录密码',
  `name` varchar(50) DEFAULT '辽工教师' COMMENT '姓名',
  `gender` char(2) DEFAULT NULL COMMENT '性别',
  `position` varchar(50) DEFAULT NULL COMMENT '职务',
  `office` varchar(50) DEFAULT NULL COMMENT '教研室',
  `logintime` datetime DEFAULT NULL COMMENT '登录时间',
  `ip` char(15) DEFAULT NULL COMMENT '登录ip',
  PRIMARY KEY (`id`),
  UNIQUE KEY `com_teacher` (`teacherId`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COMMENT='教师表';

-- ----------------------------
-- Table structure for com_teacher_l_course
-- ----------------------------
DROP TABLE IF EXISTS `com_teacher_l_course`;
CREATE TABLE `com_teacher_l_course` (
  `teacherId` int(6) NOT NULL COMMENT '教师id',
  `courseId` int(8) NOT NULL COMMENT '课程id',
  `specialtyId` int(6) NOT NULL COMMENT '专业id',
  `starttime` date NOT NULL COMMENT '课程开始时间',
  `endtime` date NOT NULL COMMENT '课程结束时间',
  PRIMARY KEY (`teacherId`,`courseId`,`specialtyId`),
  KEY `courseId` (`courseId`),
  KEY `teacherId` (`teacherId`),
  KEY `specialtyId` (`specialtyId`),
  CONSTRAINT `com_teacher_l_course_fk1` FOREIGN KEY (`teacherId`) REFERENCES `com_teacher` (`teacherId`) ON DELETE CASCADE,
  CONSTRAINT `com_teacher_l_course_fk2` FOREIGN KEY (`courseId`) REFERENCES `com_course` (`courseId`) ON DELETE CASCADE,
  CONSTRAINT `com_teacher_l_course_fk3` FOREIGN KEY (`specialtyId`) REFERENCES `com_specialty` (`specialtyId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='教师与课程,班级关联表';

-- ----------------------------
-- Table structure for com_teacher_l_role
-- ----------------------------
DROP TABLE IF EXISTS `com_teacher_l_role`;
CREATE TABLE `com_teacher_l_role` (
  `teacherId` int(6) NOT NULL COMMENT '教师id',
  `roleId` int(11) NOT NULL COMMENT '角色id',
  PRIMARY KEY (`teacherId`,`roleId`),
  KEY `roleId` (`roleId`),
  KEY `teacherId` (`teacherId`),
  CONSTRAINT `com_teacher_l_role_fk1` FOREIGN KEY (`teacherId`) REFERENCES `com_teacher` (`teacherId`) ON DELETE CASCADE,
  CONSTRAINT `com_user_l_role_fk2` FOREIGN KEY (`roleId`) REFERENCES `com_role` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='教师与角色关联表';

-- ----------------------------
-- Table structure for com_tf_question
-- ----------------------------
DROP TABLE IF EXISTS `com_tf_question`;
CREATE TABLE `com_tf_question` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `courseId` int(8) NOT NULL COMMENT '课程id',
  `section` varchar(10) NOT NULL COMMENT '章节',
  `levels` int(1) NOT NULL COMMENT '难度等级',
  `content` varchar(255) NOT NULL COMMENT '题目正文',
  `result` int(1) NOT NULL COMMENT '答案',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='判断题表';
