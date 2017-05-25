/*
Navicat MySQL Data Transfer

Source Server         : mylove1621
Source Server Version : 50713
Source Host           : 127.0.0.1:3306
Source Database       : stuexasys

Target Server Type    : MYSQL
Target Server Version : 50713
File Encoding         : 65001

Date: 2017-05-25 18:50:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for com_clazz_l_student
-- ----------------------------
DROP TABLE IF EXISTS `com_clazz_l_student`;
CREATE TABLE `com_clazz_l_student` (
  `specialtyId` char(6) NOT NULL COMMENT '班级id',
  `studentId` char(9) NOT NULL COMMENT '学生id',
  PRIMARY KEY (`specialtyId`,`studentId`),
  KEY `studentId` (`studentId`),
  KEY `specialtyId` (`specialtyId`),
  CONSTRAINT `com_clazz_l_student_fk1` FOREIGN KEY (`studentId`) REFERENCES `com_student` (`studentId`) ON DELETE CASCADE,
  CONSTRAINT `com_clazz_l_student_fk2` FOREIGN KEY (`specialtyId`) REFERENCES `com_specialty` (`specialtyId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='教师与课程,班级关联表';

-- ----------------------------
-- Records of com_clazz_l_student
-- ----------------------------

-- ----------------------------
-- Table structure for com_course
-- ----------------------------
DROP TABLE IF EXISTS `com_course`;
CREATE TABLE `com_course` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `courseId` char(8) NOT NULL COMMENT '课程id',
  `name` char(50) NOT NULL COMMENT '课程名称',
  `period` tinyint(6) DEFAULT NULL COMMENT '学时',
  `credit` tinyint(6) DEFAULT NULL COMMENT '学分',
  PRIMARY KEY (`id`),
  UNIQUE KEY `com_course` (`courseId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='课程表';

-- ----------------------------
-- Records of com_course
-- ----------------------------
INSERT INTO `com_course` VALUES ('1', '10000000', '数据结构0', '12', '2');
INSERT INTO `com_course` VALUES ('2', '10000001', '数据结构1', '12', '2');
INSERT INTO `com_course` VALUES ('3', '10000002', '数据结构2', '12', '2');
INSERT INTO `com_course` VALUES ('4', '10000003', '数据结构3', '12', '2');
INSERT INTO `com_course` VALUES ('5', '10000004', '数据结构4', '12', '2');
INSERT INTO `com_course` VALUES ('6', '10000005', '数据结构5', '12', '2');
INSERT INTO `com_course` VALUES ('7', '10000006', '数据结构6', '12', '2');
INSERT INTO `com_course` VALUES ('8', '10000007', '数据结构7', '12', '2');

-- ----------------------------
-- Table structure for com_examinfo
-- ----------------------------
DROP TABLE IF EXISTS `com_examinfo`;
CREATE TABLE `com_examinfo` (
  `specialtyId` char(6) NOT NULL COMMENT '班级id',
  `courseId` char(8) NOT NULL COMMENT '课程id',
  `content1` char(50) DEFAULT NULL COMMENT '考察章节一',
  `date1` date DEFAULT NULL COMMENT '考察时间一',
  `sign1` tinyint(4) DEFAULT '0' COMMENT '考察1，0为关闭，1为开启',
  `content2` char(50) DEFAULT NULL COMMENT '考察章节二',
  `date2` date DEFAULT NULL COMMENT '考察时间二',
  `sign2` tinyint(4) DEFAULT '0' COMMENT '考察2，0为关闭，1为开启',
  `content3` char(50) DEFAULT NULL COMMENT '考察章节三',
  `date3` date DEFAULT NULL COMMENT '考察时间三',
  `sign3` tinyint(4) DEFAULT '0' COMMENT '考察3，0为关闭，1为开启',
  `content4` char(50) DEFAULT NULL COMMENT '附加题考察',
  `date4` date DEFAULT NULL COMMENT '附加题考察时间',
  `sign4` tinyint(4) DEFAULT '0' COMMENT '考察4，0为关闭，1为开启',
  `started` tinyint(6) NOT NULL DEFAULT '0' COMMENT '考试是否开启，0未开启，1开启',
  PRIMARY KEY (`specialtyId`,`courseId`),
  KEY `courseId` (`courseId`),
  KEY `specialtyId` (`specialtyId`),
  CONSTRAINT `com_examinfo_fk_1` FOREIGN KEY (`specialtyId`) REFERENCES `com_specialty` (`specialtyId`) ON DELETE CASCADE,
  CONSTRAINT `com_examinfo_fk_2` FOREIGN KEY (`courseId`) REFERENCES `com_course` (`courseId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='考试信息表';

-- ----------------------------
-- Records of com_examinfo
-- ----------------------------

-- ----------------------------
-- Table structure for com_grade
-- ----------------------------
DROP TABLE IF EXISTS `com_grade`;
CREATE TABLE `com_grade` (
  `studentId` char(9) NOT NULL COMMENT '学号',
  `courseId` char(8) NOT NULL COMMENT '课程id',
  `grade1` tinyint(6) DEFAULT NULL COMMENT '成绩一',
  `grade2` tinyint(6) DEFAULT NULL COMMENT '成绩二',
  `grade3` tinyint(6) DEFAULT NULL COMMENT '成绩三',
  `grade4` tinyint(6) DEFAULT NULL COMMENT '附加题',
  PRIMARY KEY (`studentId`,`courseId`),
  KEY `studentId` (`studentId`),
  KEY `courseId` (`courseId`),
  CONSTRAINT `com_grade_fk_1` FOREIGN KEY (`studentId`) REFERENCES `com_student` (`studentId`) ON DELETE CASCADE,
  CONSTRAINT `com_grade_fk_2` FOREIGN KEY (`courseId`) REFERENCES `com_course` (`courseId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='成绩表';

-- ----------------------------
-- Records of com_grade
-- ----------------------------

-- ----------------------------
-- Table structure for com_manager
-- ----------------------------
DROP TABLE IF EXISTS `com_manager`;
CREATE TABLE `com_manager` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `managerId` char(6) NOT NULL COMMENT '管理员id',
  `password` char(50) NOT NULL COMMENT '登录密码',
  `name` char(50) DEFAULT '管理员' COMMENT '姓名',
  `logintime` datetime DEFAULT NULL COMMENT '登录时间',
  `ip` char(15) DEFAULT NULL COMMENT '登录ip',
  PRIMARY KEY (`id`),
  UNIQUE KEY `managerId` (`managerId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- ----------------------------
-- Records of com_manager
-- ----------------------------
INSERT INTO `com_manager` VALUES ('1', 'root', '12345', '杨徐越', '2017-05-24 19:29:51', '127.0.0.1');

-- ----------------------------
-- Table structure for com_manager_l_role
-- ----------------------------
DROP TABLE IF EXISTS `com_manager_l_role`;
CREATE TABLE `com_manager_l_role` (
  `managerId` smallint(6) NOT NULL COMMENT '管理员id',
  `roleId` smallint(6) NOT NULL COMMENT '角色id',
  PRIMARY KEY (`managerId`,`roleId`),
  KEY `roleId` (`roleId`),
  KEY `managerId` (`managerId`),
  CONSTRAINT `com_manager_l_role_fk1` FOREIGN KEY (`managerId`) REFERENCES `com_manager` (`id`) ON DELETE CASCADE,
  CONSTRAINT `com_manager_l_role_fk2` FOREIGN KEY (`roleId`) REFERENCES `com_role` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员与角色关联表';

-- ----------------------------
-- Records of com_manager_l_role
-- ----------------------------
INSERT INTO `com_manager_l_role` VALUES ('1', '1');

-- ----------------------------
-- Table structure for com_resource
-- ----------------------------
DROP TABLE IF EXISTS `com_resource`;
CREATE TABLE `com_resource` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) NOT NULL COMMENT '资源名称',
  `remark` varchar(250) DEFAULT NULL COMMENT '备注',
  `permission` varchar(250) NOT NULL COMMENT 'permission许可编码',
  `url` varchar(250) DEFAULT NULL COMMENT '资源地址',
  PRIMARY KEY (`id`),
  UNIQUE KEY `permission` (`permission`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资源表';

-- ----------------------------
-- Records of com_resource
-- ----------------------------

-- ----------------------------
-- Table structure for com_role
-- ----------------------------
DROP TABLE IF EXISTS `com_role`;
CREATE TABLE `com_role` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) NOT NULL COMMENT '角色名称',
  `remark` varchar(250) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of com_role
-- ----------------------------
INSERT INTO `com_role` VALUES ('1', 'admin', '超级管理员');
INSERT INTO `com_role` VALUES ('2', '教师', '管理员');

-- ----------------------------
-- Table structure for com_role_l_resource
-- ----------------------------
DROP TABLE IF EXISTS `com_role_l_resource`;
CREATE TABLE `com_role_l_resource` (
  `roleId` smallint(6) NOT NULL COMMENT '角色id',
  `resourceId` smallint(6) NOT NULL COMMENT '资源id',
  PRIMARY KEY (`roleId`,`resourceId`),
  KEY `resourceId` (`resourceId`),
  KEY `roleId` (`roleId`),
  CONSTRAINT `com_role_l_resource_fk1` FOREIGN KEY (`roleId`) REFERENCES `com_role` (`id`) ON DELETE CASCADE,
  CONSTRAINT `com_role_l_resource_fk2` FOREIGN KEY (`resourceId`) REFERENCES `com_resource` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色与资源管理表';

-- ----------------------------
-- Records of com_role_l_resource
-- ----------------------------

-- ----------------------------
-- Table structure for com_single_question
-- ----------------------------
DROP TABLE IF EXISTS `com_single_question`;
CREATE TABLE `com_single_question` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `courseId` char(8) NOT NULL COMMENT '课程id',
  `section` char(10) NOT NULL COMMENT '章节',
  `levels` tinyint(6) NOT NULL COMMENT '难度等级',
  `name` char(255) NOT NULL COMMENT '题目正文',
  `que1` char(255) NOT NULL COMMENT '选项1',
  `que2` char(255) NOT NULL COMMENT '选项2',
  `que3` char(255) NOT NULL COMMENT '选项3',
  `que4` char(255) NOT NULL COMMENT '选项4',
  `result` char(1) NOT NULL COMMENT '答案',
  PRIMARY KEY (`id`),
  KEY `courseId` (`courseId`),
  CONSTRAINT `com_single_question_fk` FOREIGN KEY (`courseId`) REFERENCES `com_course` (`courseId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='单选题表';

-- ----------------------------
-- Records of com_single_question
-- ----------------------------

-- ----------------------------
-- Table structure for com_specialty
-- ----------------------------
DROP TABLE IF EXISTS `com_specialty`;
CREATE TABLE `com_specialty` (
  `id` tinyint(6) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `specialtyId` char(6) NOT NULL COMMENT '专业id',
  `name` char(50) NOT NULL COMMENT '专业名称',
  PRIMARY KEY (`id`),
  UNIQUE KEY `com_specialty` (`specialtyId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='专业表';

-- ----------------------------
-- Records of com_specialty
-- ----------------------------
INSERT INTO `com_specialty` VALUES ('1', '140400', '计算机0班');
INSERT INTO `com_specialty` VALUES ('2', '140401', '计算机1班');
INSERT INTO `com_specialty` VALUES ('3', '140402', '计算机2班');
INSERT INTO `com_specialty` VALUES ('4', '140403', '计算机3班');
INSERT INTO `com_specialty` VALUES ('5', '140404', '计算机4班');
INSERT INTO `com_specialty` VALUES ('6', '140405', '计算机5班');

-- ----------------------------
-- Table structure for com_student
-- ----------------------------
DROP TABLE IF EXISTS `com_student`;
CREATE TABLE `com_student` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `studentId` char(9) NOT NULL COMMENT '学号',
  `password` char(50) NOT NULL COMMENT '登录密码',
  `name` char(50) DEFAULT '辽工学子' COMMENT '姓名',
  `specialtyId` char(6) NOT NULL COMMENT '班级id',
  `gender` char(2) DEFAULT NULL COMMENT '性别',
  `cellphone` char(11) DEFAULT NULL COMMENT '手机号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `com_student` (`studentId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='学生表';

-- ----------------------------
-- Records of com_student
-- ----------------------------
INSERT INTO `com_student` VALUES ('1', '140401049', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '01', null, null);

-- ----------------------------
-- Table structure for com_teacher
-- ----------------------------
DROP TABLE IF EXISTS `com_teacher`;
CREATE TABLE `com_teacher` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `teacherId` char(6) NOT NULL COMMENT '教师id',
  `password` char(50) NOT NULL COMMENT '登录密码',
  `name` char(50) DEFAULT '辽工教师' COMMENT '姓名',
  `gender` char(2) DEFAULT NULL COMMENT '性别',
  `position` char(50) DEFAULT NULL COMMENT '职务',
  `office` char(50) DEFAULT NULL COMMENT '教研室',
  `logintime` datetime DEFAULT NULL COMMENT '登录时间',
  `ip` char(15) DEFAULT NULL COMMENT '登录ip',
  PRIMARY KEY (`id`),
  UNIQUE KEY `com_teacher` (`teacherId`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='教师表';

-- ----------------------------
-- Records of com_teacher
-- ----------------------------
INSERT INTO `com_teacher` VALUES ('18', '140400', '827ccb0eea8a706c4c34a16891f84e7b', '辽工教师', null, null, null, null, null);
INSERT INTO `com_teacher` VALUES ('19', '140401', '827ccb0eea8a706c4c34a16891f84e7b', '辽工教师', null, null, null, null, null);
INSERT INTO `com_teacher` VALUES ('20', '140402', '827ccb0eea8a706c4c34a16891f84e7b', '辽工教师', null, null, null, null, null);

-- ----------------------------
-- Table structure for com_teacher_l_course
-- ----------------------------
DROP TABLE IF EXISTS `com_teacher_l_course`;
CREATE TABLE `com_teacher_l_course` (
  `teacherId` char(6) NOT NULL COMMENT '教师id',
  `courseId` char(8) NOT NULL COMMENT '课程id',
  `specialtyId` char(6) NOT NULL COMMENT '专业id',
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
-- Records of com_teacher_l_course
-- ----------------------------
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000000', '140400', '2017-05-17', '2017-05-23');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000000', '140401', '2017-05-17', '2017-05-23');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000000', '140403', '2017-05-09', '2017-05-31');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000000', '140404', '2017-05-23', '2017-05-30');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000001', '140403', '2017-05-23', '2017-05-23');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000003', '140403', '2017-05-23', '2017-05-23');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000004', '140405', '2017-05-23', '2017-05-31');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000005', '140400', '2017-05-23', '2017-05-23');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000005', '140401', '2017-05-23', '2017-05-23');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000005', '140402', '2017-05-23', '2017-05-31');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000005', '140403', '2017-05-23', '2017-05-31');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000005', '140405', '2017-05-23', '2017-05-23');

-- ----------------------------
-- Table structure for com_teacher_l_role
-- ----------------------------
DROP TABLE IF EXISTS `com_teacher_l_role`;
CREATE TABLE `com_teacher_l_role` (
  `teacherId` smallint(6) NOT NULL COMMENT '教师id',
  `roleId` smallint(6) NOT NULL COMMENT '角色id',
  PRIMARY KEY (`teacherId`,`roleId`),
  KEY `roleId` (`roleId`),
  KEY `teacherId` (`teacherId`),
  CONSTRAINT `com_user_l_role_fk1` FOREIGN KEY (`teacherId`) REFERENCES `com_teacher` (`id`) ON DELETE CASCADE,
  CONSTRAINT `com_user_l_role_fk2` FOREIGN KEY (`roleId`) REFERENCES `com_role` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='教师与角色关联表';

-- ----------------------------
-- Records of com_teacher_l_role
-- ----------------------------

-- ----------------------------
-- Table structure for com_tf_question
-- ----------------------------
DROP TABLE IF EXISTS `com_tf_question`;
CREATE TABLE `com_tf_question` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `courseId` char(8) NOT NULL COMMENT '课程id',
  `section` char(10) NOT NULL COMMENT '章节',
  `levels` tinyint(6) NOT NULL COMMENT '难度等级',
  `name` char(255) NOT NULL COMMENT '题目正文',
  `result` tinyint(6) NOT NULL COMMENT '答案',
  PRIMARY KEY (`id`),
  KEY `courseId` (`courseId`),
  CONSTRAINT `com_tf_question_fk` FOREIGN KEY (`courseId`) REFERENCES `com_course` (`courseId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='判断题表';

-- ----------------------------
-- Records of com_tf_question
-- ----------------------------
