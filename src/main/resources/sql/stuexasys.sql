/*
Navicat MySQL Data Transfer

Source Server         : mylove1621
Source Server Version : 50713
Source Host           : 127.0.0.1:3306
Source Database       : stuexasys

Target Server Type    : MYSQL
Target Server Version : 50713
File Encoding         : 65001

Date: 2017-05-28 11:59:01
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
INSERT INTO `com_clazz_l_student` VALUES ('140400', '140400000');
INSERT INTO `com_clazz_l_student` VALUES ('140400', '140400001');
INSERT INTO `com_clazz_l_student` VALUES ('140400', '140400003');
INSERT INTO `com_clazz_l_student` VALUES ('140400', '140401049');
INSERT INTO `com_clazz_l_student` VALUES ('140401', '140400000');
INSERT INTO `com_clazz_l_student` VALUES ('140401', '140401049');

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
  `total` tinyint(6) DEFAULT NULL COMMENT '总成绩',
  PRIMARY KEY (`studentId`,`courseId`),
  KEY `studentId` (`studentId`),
  KEY `courseId` (`courseId`),
  CONSTRAINT `com_grade_fk_1` FOREIGN KEY (`studentId`) REFERENCES `com_student` (`studentId`) ON DELETE CASCADE,
  CONSTRAINT `com_grade_fk_2` FOREIGN KEY (`courseId`) REFERENCES `com_course` (`courseId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='成绩表';

-- ----------------------------
-- Records of com_grade
-- ----------------------------
INSERT INTO `com_grade` VALUES ('140400000', '10000000', '40', '40', '40', '40', '100');
INSERT INTO `com_grade` VALUES ('140400000', '10000001', '79', '79', '79', '79', null);
INSERT INTO `com_grade` VALUES ('140400000', '10000002', '34', '34', '34', '34', null);
INSERT INTO `com_grade` VALUES ('140400000', '10000003', '82', '82', '82', '82', null);
INSERT INTO `com_grade` VALUES ('140400000', '10000004', '58', '58', '58', '58', null);
INSERT INTO `com_grade` VALUES ('140400000', '10000005', '70', '70', '70', '70', null);
INSERT INTO `com_grade` VALUES ('140400000', '10000006', '4', '4', '4', '4', null);
INSERT INTO `com_grade` VALUES ('140400000', '10000007', '52', '52', '52', '52', null);
INSERT INTO `com_grade` VALUES ('140400001', '10000000', '4', '4', '4', '4', null);
INSERT INTO `com_grade` VALUES ('140400001', '10000001', '25', '25', '25', '25', null);
INSERT INTO `com_grade` VALUES ('140400001', '10000002', '9', '9', '9', '9', null);
INSERT INTO `com_grade` VALUES ('140400001', '10000003', '96', '96', '96', '96', null);
INSERT INTO `com_grade` VALUES ('140400001', '10000004', '22', '22', '22', '22', null);
INSERT INTO `com_grade` VALUES ('140400001', '10000005', '33', '33', '33', '33', null);
INSERT INTO `com_grade` VALUES ('140400001', '10000006', '45', '45', '45', '45', null);
INSERT INTO `com_grade` VALUES ('140400001', '10000007', '97', '97', '97', '97', null);
INSERT INTO `com_grade` VALUES ('140400002', '10000000', '56', '56', '56', '56', null);
INSERT INTO `com_grade` VALUES ('140400002', '10000001', '42', '42', '42', '42', null);
INSERT INTO `com_grade` VALUES ('140400002', '10000002', '3', '3', '3', '3', null);
INSERT INTO `com_grade` VALUES ('140400002', '10000003', '39', '39', '39', '39', null);
INSERT INTO `com_grade` VALUES ('140400002', '10000004', '56', '56', '56', '56', null);
INSERT INTO `com_grade` VALUES ('140400002', '10000005', '63', '63', '63', '63', null);
INSERT INTO `com_grade` VALUES ('140400002', '10000006', '74', '74', '74', '74', null);
INSERT INTO `com_grade` VALUES ('140400002', '10000007', '64', '64', '64', '64', null);
INSERT INTO `com_grade` VALUES ('140400003', '10000000', '96', '96', '96', '96', null);
INSERT INTO `com_grade` VALUES ('140400003', '10000001', '22', '22', '22', '22', null);
INSERT INTO `com_grade` VALUES ('140400003', '10000002', '75', '75', '75', '75', null);
INSERT INTO `com_grade` VALUES ('140400003', '10000003', '5', '5', '5', '5', null);
INSERT INTO `com_grade` VALUES ('140400003', '10000004', '83', '83', '83', '83', null);
INSERT INTO `com_grade` VALUES ('140400003', '10000005', '58', '58', '58', '58', null);
INSERT INTO `com_grade` VALUES ('140400003', '10000006', '91', '91', '91', '91', null);
INSERT INTO `com_grade` VALUES ('140400003', '10000007', '96', '96', '96', '96', null);
INSERT INTO `com_grade` VALUES ('140400004', '10000000', '46', '46', '46', '46', null);
INSERT INTO `com_grade` VALUES ('140400004', '10000001', '3', '3', '3', '3', null);
INSERT INTO `com_grade` VALUES ('140400004', '10000002', '25', '25', '25', '25', null);
INSERT INTO `com_grade` VALUES ('140400004', '10000003', '75', '75', '75', '75', null);
INSERT INTO `com_grade` VALUES ('140400004', '10000004', '2', '2', '2', '2', null);
INSERT INTO `com_grade` VALUES ('140400004', '10000005', '54', '54', '54', '54', null);
INSERT INTO `com_grade` VALUES ('140400004', '10000006', '17', '17', '17', '17', null);
INSERT INTO `com_grade` VALUES ('140400004', '10000007', '30', '30', '30', '30', null);
INSERT INTO `com_grade` VALUES ('140400005', '10000000', '52', '52', '52', '52', null);
INSERT INTO `com_grade` VALUES ('140400005', '10000001', '51', '51', '51', '51', null);
INSERT INTO `com_grade` VALUES ('140400005', '10000002', '23', '23', '23', '23', null);
INSERT INTO `com_grade` VALUES ('140400005', '10000003', '63', '63', '63', '63', null);
INSERT INTO `com_grade` VALUES ('140400005', '10000004', '61', '61', '61', '61', null);
INSERT INTO `com_grade` VALUES ('140400005', '10000005', '37', '37', '37', '37', null);
INSERT INTO `com_grade` VALUES ('140400005', '10000006', '81', '81', '81', '81', null);
INSERT INTO `com_grade` VALUES ('140400005', '10000007', '24', '24', '24', '24', null);
INSERT INTO `com_grade` VALUES ('140400006', '10000000', '38', '38', '38', '38', null);
INSERT INTO `com_grade` VALUES ('140400006', '10000001', '66', '66', '66', '66', null);
INSERT INTO `com_grade` VALUES ('140400006', '10000002', '16', '16', '16', '16', null);
INSERT INTO `com_grade` VALUES ('140400006', '10000003', '19', '19', '19', '19', null);
INSERT INTO `com_grade` VALUES ('140400006', '10000004', '36', '36', '36', '36', null);
INSERT INTO `com_grade` VALUES ('140400006', '10000005', '17', '17', '17', '17', null);
INSERT INTO `com_grade` VALUES ('140400006', '10000006', '21', '21', '21', '21', null);
INSERT INTO `com_grade` VALUES ('140400006', '10000007', '26', '26', '26', '26', null);
INSERT INTO `com_grade` VALUES ('140400007', '10000000', '66', '66', '66', '66', null);
INSERT INTO `com_grade` VALUES ('140400007', '10000001', '59', '59', '59', '59', null);
INSERT INTO `com_grade` VALUES ('140400007', '10000002', '36', '36', '36', '36', null);
INSERT INTO `com_grade` VALUES ('140400007', '10000003', '63', '63', '63', '63', null);
INSERT INTO `com_grade` VALUES ('140400007', '10000004', '41', '41', '41', '41', null);
INSERT INTO `com_grade` VALUES ('140400007', '10000005', '72', '72', '72', '72', null);
INSERT INTO `com_grade` VALUES ('140400007', '10000006', '35', '35', '35', '35', null);
INSERT INTO `com_grade` VALUES ('140400007', '10000007', '32', '32', '32', '32', null);
INSERT INTO `com_grade` VALUES ('140400008', '10000000', '33', '33', '33', '33', null);
INSERT INTO `com_grade` VALUES ('140400008', '10000001', '46', '46', '46', '46', null);
INSERT INTO `com_grade` VALUES ('140400008', '10000002', '76', '76', '76', '76', null);
INSERT INTO `com_grade` VALUES ('140400008', '10000003', '80', '80', '80', '80', null);
INSERT INTO `com_grade` VALUES ('140400008', '10000004', '74', '74', '74', '74', null);
INSERT INTO `com_grade` VALUES ('140400008', '10000005', '90', '90', '90', '90', null);
INSERT INTO `com_grade` VALUES ('140400008', '10000006', '98', '98', '98', '98', null);
INSERT INTO `com_grade` VALUES ('140400008', '10000007', '68', '68', '68', '68', null);
INSERT INTO `com_grade` VALUES ('140400009', '10000000', '72', '72', '72', '72', null);
INSERT INTO `com_grade` VALUES ('140400009', '10000001', '99', '99', '99', '99', null);
INSERT INTO `com_grade` VALUES ('140400009', '10000002', '44', '44', '44', '44', null);
INSERT INTO `com_grade` VALUES ('140400009', '10000003', '23', '23', '23', '23', null);
INSERT INTO `com_grade` VALUES ('140400009', '10000004', '48', '48', '48', '48', null);
INSERT INTO `com_grade` VALUES ('140400009', '10000005', '37', '37', '37', '37', null);
INSERT INTO `com_grade` VALUES ('140400009', '10000006', '79', '79', '79', '79', null);
INSERT INTO `com_grade` VALUES ('140400009', '10000007', '90', '90', '90', '90', null);
INSERT INTO `com_grade` VALUES ('140401010', '10000000', '58', '58', '58', '58', null);
INSERT INTO `com_grade` VALUES ('140401010', '10000001', '57', '57', '57', '57', null);
INSERT INTO `com_grade` VALUES ('140401010', '10000002', '0', '0', '0', '0', null);
INSERT INTO `com_grade` VALUES ('140401010', '10000003', '51', '51', '51', '51', null);
INSERT INTO `com_grade` VALUES ('140401010', '10000004', '99', '99', '99', '99', null);
INSERT INTO `com_grade` VALUES ('140401010', '10000005', '25', '25', '25', '25', null);
INSERT INTO `com_grade` VALUES ('140401010', '10000006', '83', '83', '83', '83', null);
INSERT INTO `com_grade` VALUES ('140401010', '10000007', '36', '36', '36', '36', null);
INSERT INTO `com_grade` VALUES ('140401011', '10000000', '16', '16', '16', '16', null);
INSERT INTO `com_grade` VALUES ('140401011', '10000001', '12', '12', '12', '12', null);
INSERT INTO `com_grade` VALUES ('140401011', '10000002', '26', '26', '26', '26', null);
INSERT INTO `com_grade` VALUES ('140401011', '10000003', '65', '65', '65', '65', null);
INSERT INTO `com_grade` VALUES ('140401011', '10000004', '21', '21', '21', '21', null);
INSERT INTO `com_grade` VALUES ('140401011', '10000005', '82', '82', '82', '82', null);
INSERT INTO `com_grade` VALUES ('140401011', '10000006', '14', '14', '14', '14', null);
INSERT INTO `com_grade` VALUES ('140401011', '10000007', '57', '57', '57', '57', null);
INSERT INTO `com_grade` VALUES ('140401012', '10000000', '27', '27', '27', '27', null);
INSERT INTO `com_grade` VALUES ('140401012', '10000001', '81', '81', '81', '81', null);
INSERT INTO `com_grade` VALUES ('140401012', '10000002', '24', '24', '24', '24', null);
INSERT INTO `com_grade` VALUES ('140401012', '10000003', '37', '37', '37', '37', null);
INSERT INTO `com_grade` VALUES ('140401012', '10000004', '37', '37', '37', '37', null);
INSERT INTO `com_grade` VALUES ('140401012', '10000005', '5', '5', '5', '5', null);
INSERT INTO `com_grade` VALUES ('140401012', '10000006', '62', '62', '62', '62', null);
INSERT INTO `com_grade` VALUES ('140401012', '10000007', '11', '11', '11', '11', null);
INSERT INTO `com_grade` VALUES ('140401013', '10000000', '18', '18', '18', '18', null);
INSERT INTO `com_grade` VALUES ('140401013', '10000001', '24', '24', '24', '24', null);
INSERT INTO `com_grade` VALUES ('140401013', '10000002', '95', '95', '95', '95', null);
INSERT INTO `com_grade` VALUES ('140401013', '10000003', '99', '99', '99', '99', null);
INSERT INTO `com_grade` VALUES ('140401013', '10000004', '48', '48', '48', '48', null);
INSERT INTO `com_grade` VALUES ('140401013', '10000005', '49', '49', '49', '49', null);
INSERT INTO `com_grade` VALUES ('140401013', '10000006', '35', '35', '35', '35', null);
INSERT INTO `com_grade` VALUES ('140401013', '10000007', '49', '49', '49', '49', null);
INSERT INTO `com_grade` VALUES ('140401014', '10000000', '34', '34', '34', '34', null);
INSERT INTO `com_grade` VALUES ('140401014', '10000001', '84', '84', '84', '84', null);
INSERT INTO `com_grade` VALUES ('140401014', '10000002', '62', '62', '62', '62', null);
INSERT INTO `com_grade` VALUES ('140401014', '10000003', '71', '71', '71', '71', null);
INSERT INTO `com_grade` VALUES ('140401014', '10000004', '48', '48', '48', '48', null);
INSERT INTO `com_grade` VALUES ('140401014', '10000005', '93', '93', '93', '93', null);
INSERT INTO `com_grade` VALUES ('140401014', '10000006', '67', '67', '67', '67', null);
INSERT INTO `com_grade` VALUES ('140401014', '10000007', '87', '87', '87', '87', null);
INSERT INTO `com_grade` VALUES ('140401015', '10000000', '88', '88', '88', '88', null);
INSERT INTO `com_grade` VALUES ('140401015', '10000001', '17', '17', '17', '17', null);
INSERT INTO `com_grade` VALUES ('140401015', '10000002', '44', '44', '44', '44', null);
INSERT INTO `com_grade` VALUES ('140401015', '10000003', '84', '84', '84', '84', null);
INSERT INTO `com_grade` VALUES ('140401015', '10000004', '66', '66', '66', '66', null);
INSERT INTO `com_grade` VALUES ('140401015', '10000005', '40', '40', '40', '40', null);
INSERT INTO `com_grade` VALUES ('140401015', '10000006', '15', '15', '15', '15', null);
INSERT INTO `com_grade` VALUES ('140401015', '10000007', '53', '53', '53', '53', null);
INSERT INTO `com_grade` VALUES ('140401016', '10000000', '48', '48', '48', '48', null);
INSERT INTO `com_grade` VALUES ('140401016', '10000001', '9', '9', '9', '9', null);
INSERT INTO `com_grade` VALUES ('140401016', '10000002', '69', '69', '69', '69', null);
INSERT INTO `com_grade` VALUES ('140401016', '10000003', '47', '47', '47', '47', null);
INSERT INTO `com_grade` VALUES ('140401016', '10000004', '8', '8', '8', '8', null);
INSERT INTO `com_grade` VALUES ('140401016', '10000005', '36', '36', '36', '36', null);
INSERT INTO `com_grade` VALUES ('140401016', '10000006', '88', '88', '88', '88', null);
INSERT INTO `com_grade` VALUES ('140401016', '10000007', '82', '82', '82', '82', null);
INSERT INTO `com_grade` VALUES ('140401017', '10000000', '60', '60', '60', '60', null);
INSERT INTO `com_grade` VALUES ('140401017', '10000001', '41', '41', '41', '41', null);
INSERT INTO `com_grade` VALUES ('140401017', '10000002', '73', '73', '73', '73', null);
INSERT INTO `com_grade` VALUES ('140401017', '10000003', '15', '15', '15', '15', null);
INSERT INTO `com_grade` VALUES ('140401017', '10000004', '30', '30', '30', '30', null);
INSERT INTO `com_grade` VALUES ('140401017', '10000005', '12', '12', '12', '12', null);
INSERT INTO `com_grade` VALUES ('140401017', '10000006', '45', '45', '45', '45', null);
INSERT INTO `com_grade` VALUES ('140401017', '10000007', '63', '63', '63', '63', null);
INSERT INTO `com_grade` VALUES ('140401018', '10000000', '78', '78', '78', '78', null);
INSERT INTO `com_grade` VALUES ('140401018', '10000001', '59', '59', '59', '59', null);
INSERT INTO `com_grade` VALUES ('140401018', '10000002', '29', '29', '29', '29', null);
INSERT INTO `com_grade` VALUES ('140401018', '10000003', '88', '88', '88', '88', null);
INSERT INTO `com_grade` VALUES ('140401018', '10000004', '41', '41', '41', '41', null);
INSERT INTO `com_grade` VALUES ('140401018', '10000005', '51', '51', '51', '51', null);
INSERT INTO `com_grade` VALUES ('140401018', '10000006', '94', '94', '94', '94', null);
INSERT INTO `com_grade` VALUES ('140401018', '10000007', '67', '67', '67', '67', null);
INSERT INTO `com_grade` VALUES ('140401019', '10000000', '50', '50', '50', '50', null);
INSERT INTO `com_grade` VALUES ('140401019', '10000001', '64', '64', '64', '64', null);
INSERT INTO `com_grade` VALUES ('140401019', '10000002', '67', '67', '67', '67', null);
INSERT INTO `com_grade` VALUES ('140401019', '10000003', '36', '36', '36', '36', null);
INSERT INTO `com_grade` VALUES ('140401019', '10000004', '19', '19', '19', '19', null);
INSERT INTO `com_grade` VALUES ('140401019', '10000005', '95', '95', '95', '95', null);
INSERT INTO `com_grade` VALUES ('140401019', '10000006', '9', '9', '9', '9', null);
INSERT INTO `com_grade` VALUES ('140401019', '10000007', '23', '23', '23', '23', null);
INSERT INTO `com_grade` VALUES ('140402020', '10000000', '26', '26', '26', '26', null);
INSERT INTO `com_grade` VALUES ('140402020', '10000001', '38', '38', '38', '38', null);
INSERT INTO `com_grade` VALUES ('140402020', '10000002', '69', '69', '69', '69', null);
INSERT INTO `com_grade` VALUES ('140402020', '10000003', '17', '17', '17', '17', null);
INSERT INTO `com_grade` VALUES ('140402020', '10000004', '27', '27', '27', '27', null);
INSERT INTO `com_grade` VALUES ('140402020', '10000005', '55', '55', '55', '55', null);
INSERT INTO `com_grade` VALUES ('140402020', '10000006', '61', '61', '61', '61', null);
INSERT INTO `com_grade` VALUES ('140402020', '10000007', '87', '87', '87', '87', null);
INSERT INTO `com_grade` VALUES ('140402021', '10000000', '36', '36', '36', '36', null);
INSERT INTO `com_grade` VALUES ('140402021', '10000001', '81', '81', '81', '81', null);
INSERT INTO `com_grade` VALUES ('140402021', '10000002', '55', '55', '55', '55', null);
INSERT INTO `com_grade` VALUES ('140402021', '10000003', '13', '13', '13', '13', null);
INSERT INTO `com_grade` VALUES ('140402021', '10000004', '28', '28', '28', '28', null);
INSERT INTO `com_grade` VALUES ('140402021', '10000005', '47', '47', '47', '47', null);
INSERT INTO `com_grade` VALUES ('140402021', '10000006', '26', '26', '26', '26', null);
INSERT INTO `com_grade` VALUES ('140402021', '10000007', '13', '13', '13', '13', null);
INSERT INTO `com_grade` VALUES ('140402022', '10000000', '64', '64', '64', '64', null);
INSERT INTO `com_grade` VALUES ('140402022', '10000001', '38', '38', '38', '38', null);
INSERT INTO `com_grade` VALUES ('140402022', '10000002', '37', '37', '37', '37', null);
INSERT INTO `com_grade` VALUES ('140402022', '10000003', '12', '12', '12', '12', null);
INSERT INTO `com_grade` VALUES ('140402022', '10000004', '15', '15', '15', '15', null);
INSERT INTO `com_grade` VALUES ('140402022', '10000005', '12', '12', '12', '12', null);
INSERT INTO `com_grade` VALUES ('140402022', '10000006', '52', '52', '52', '52', null);
INSERT INTO `com_grade` VALUES ('140402022', '10000007', '41', '41', '41', '41', null);
INSERT INTO `com_grade` VALUES ('140402023', '10000000', '41', '41', '41', '41', null);
INSERT INTO `com_grade` VALUES ('140402023', '10000001', '19', '19', '19', '19', null);
INSERT INTO `com_grade` VALUES ('140402023', '10000002', '91', '91', '91', '91', null);
INSERT INTO `com_grade` VALUES ('140402023', '10000003', '92', '92', '92', '92', null);
INSERT INTO `com_grade` VALUES ('140402023', '10000004', '61', '61', '61', '61', null);
INSERT INTO `com_grade` VALUES ('140402023', '10000005', '8', '8', '8', '8', null);
INSERT INTO `com_grade` VALUES ('140402023', '10000006', '0', '0', '0', '0', null);
INSERT INTO `com_grade` VALUES ('140402023', '10000007', '10', '10', '10', '10', null);
INSERT INTO `com_grade` VALUES ('140402024', '10000000', '80', '80', '80', '80', null);
INSERT INTO `com_grade` VALUES ('140402024', '10000001', '69', '69', '69', '69', null);
INSERT INTO `com_grade` VALUES ('140402024', '10000002', '94', '94', '94', '94', null);
INSERT INTO `com_grade` VALUES ('140402024', '10000003', '41', '41', '41', '41', null);
INSERT INTO `com_grade` VALUES ('140402024', '10000004', '92', '92', '92', '92', null);
INSERT INTO `com_grade` VALUES ('140402024', '10000005', '23', '23', '23', '23', null);
INSERT INTO `com_grade` VALUES ('140402024', '10000006', '91', '91', '91', '91', null);
INSERT INTO `com_grade` VALUES ('140402024', '10000007', '44', '44', '44', '44', null);
INSERT INTO `com_grade` VALUES ('140402025', '10000000', '41', '41', '41', '41', null);
INSERT INTO `com_grade` VALUES ('140402025', '10000001', '29', '29', '29', '29', null);
INSERT INTO `com_grade` VALUES ('140402025', '10000002', '39', '39', '39', '39', null);
INSERT INTO `com_grade` VALUES ('140402025', '10000003', '36', '36', '36', '36', null);
INSERT INTO `com_grade` VALUES ('140402025', '10000004', '30', '30', '30', '30', null);
INSERT INTO `com_grade` VALUES ('140402025', '10000005', '99', '99', '99', '99', null);
INSERT INTO `com_grade` VALUES ('140402025', '10000006', '54', '54', '54', '54', null);
INSERT INTO `com_grade` VALUES ('140402025', '10000007', '97', '97', '97', '97', null);
INSERT INTO `com_grade` VALUES ('140402026', '10000000', '90', '90', '90', '90', null);
INSERT INTO `com_grade` VALUES ('140402026', '10000001', '71', '71', '71', '71', null);
INSERT INTO `com_grade` VALUES ('140402026', '10000002', '16', '16', '16', '16', null);
INSERT INTO `com_grade` VALUES ('140402026', '10000003', '34', '34', '34', '34', null);
INSERT INTO `com_grade` VALUES ('140402026', '10000004', '99', '99', '99', '99', null);
INSERT INTO `com_grade` VALUES ('140402026', '10000005', '71', '71', '71', '71', null);
INSERT INTO `com_grade` VALUES ('140402026', '10000006', '36', '36', '36', '36', null);
INSERT INTO `com_grade` VALUES ('140402026', '10000007', '87', '87', '87', '87', null);
INSERT INTO `com_grade` VALUES ('140402027', '10000000', '59', '59', '59', '59', null);
INSERT INTO `com_grade` VALUES ('140402027', '10000001', '37', '37', '37', '37', null);
INSERT INTO `com_grade` VALUES ('140402027', '10000002', '29', '29', '29', '29', null);
INSERT INTO `com_grade` VALUES ('140402027', '10000003', '7', '7', '7', '7', null);
INSERT INTO `com_grade` VALUES ('140402027', '10000004', '14', '14', '14', '14', null);
INSERT INTO `com_grade` VALUES ('140402027', '10000005', '85', '85', '85', '85', null);
INSERT INTO `com_grade` VALUES ('140402027', '10000006', '27', '27', '27', '27', null);
INSERT INTO `com_grade` VALUES ('140402027', '10000007', '28', '28', '28', '28', null);
INSERT INTO `com_grade` VALUES ('140402028', '10000000', '15', '15', '15', '15', null);
INSERT INTO `com_grade` VALUES ('140402028', '10000001', '68', '68', '68', '68', null);
INSERT INTO `com_grade` VALUES ('140402028', '10000002', '0', '0', '0', '0', null);
INSERT INTO `com_grade` VALUES ('140402028', '10000003', '29', '29', '29', '29', null);
INSERT INTO `com_grade` VALUES ('140402028', '10000004', '5', '5', '5', '5', null);
INSERT INTO `com_grade` VALUES ('140402028', '10000005', '1', '1', '1', '1', null);
INSERT INTO `com_grade` VALUES ('140402028', '10000006', '37', '37', '37', '37', null);
INSERT INTO `com_grade` VALUES ('140402028', '10000007', '75', '75', '75', '75', null);
INSERT INTO `com_grade` VALUES ('140402029', '10000000', '88', '88', '88', '88', null);
INSERT INTO `com_grade` VALUES ('140402029', '10000001', '92', '92', '92', '92', null);
INSERT INTO `com_grade` VALUES ('140402029', '10000002', '59', '59', '59', '59', null);
INSERT INTO `com_grade` VALUES ('140402029', '10000003', '51', '51', '51', '51', null);
INSERT INTO `com_grade` VALUES ('140402029', '10000004', '50', '50', '50', '50', null);
INSERT INTO `com_grade` VALUES ('140402029', '10000005', '8', '8', '8', '8', null);
INSERT INTO `com_grade` VALUES ('140402029', '10000006', '89', '89', '89', '89', null);
INSERT INTO `com_grade` VALUES ('140402029', '10000007', '50', '50', '50', '50', null);
INSERT INTO `com_grade` VALUES ('140403030', '10000000', '68', '68', '68', '68', null);
INSERT INTO `com_grade` VALUES ('140403030', '10000001', '40', '40', '40', '40', null);
INSERT INTO `com_grade` VALUES ('140403030', '10000002', '19', '19', '19', '19', null);
INSERT INTO `com_grade` VALUES ('140403030', '10000003', '86', '86', '86', '86', null);
INSERT INTO `com_grade` VALUES ('140403030', '10000004', '62', '62', '62', '62', null);
INSERT INTO `com_grade` VALUES ('140403030', '10000005', '99', '99', '99', '99', null);
INSERT INTO `com_grade` VALUES ('140403030', '10000006', '27', '27', '27', '27', null);
INSERT INTO `com_grade` VALUES ('140403030', '10000007', '7', '7', '7', '7', null);
INSERT INTO `com_grade` VALUES ('140403031', '10000000', '66', '66', '66', '66', null);
INSERT INTO `com_grade` VALUES ('140403031', '10000001', '44', '44', '44', '44', null);
INSERT INTO `com_grade` VALUES ('140403031', '10000002', '11', '11', '11', '11', null);
INSERT INTO `com_grade` VALUES ('140403031', '10000003', '94', '94', '94', '94', null);
INSERT INTO `com_grade` VALUES ('140403031', '10000004', '44', '44', '44', '44', null);
INSERT INTO `com_grade` VALUES ('140403031', '10000005', '48', '48', '48', '48', null);
INSERT INTO `com_grade` VALUES ('140403031', '10000006', '68', '68', '68', '68', null);
INSERT INTO `com_grade` VALUES ('140403031', '10000007', '45', '45', '45', '45', null);
INSERT INTO `com_grade` VALUES ('140403032', '10000000', '88', '88', '88', '88', null);
INSERT INTO `com_grade` VALUES ('140403032', '10000001', '34', '34', '34', '34', null);
INSERT INTO `com_grade` VALUES ('140403032', '10000002', '74', '74', '74', '74', null);
INSERT INTO `com_grade` VALUES ('140403032', '10000003', '71', '71', '71', '71', null);
INSERT INTO `com_grade` VALUES ('140403032', '10000004', '2', '2', '2', '2', null);
INSERT INTO `com_grade` VALUES ('140403032', '10000005', '88', '88', '88', '88', null);
INSERT INTO `com_grade` VALUES ('140403032', '10000006', '3', '3', '3', '3', null);
INSERT INTO `com_grade` VALUES ('140403032', '10000007', '16', '16', '16', '16', null);
INSERT INTO `com_grade` VALUES ('140403033', '10000000', '8', '8', '8', '8', null);
INSERT INTO `com_grade` VALUES ('140403033', '10000001', '42', '42', '42', '42', null);
INSERT INTO `com_grade` VALUES ('140403033', '10000002', '38', '38', '38', '38', null);
INSERT INTO `com_grade` VALUES ('140403033', '10000003', '48', '48', '48', '48', null);
INSERT INTO `com_grade` VALUES ('140403033', '10000004', '30', '30', '30', '30', null);
INSERT INTO `com_grade` VALUES ('140403033', '10000005', '63', '63', '63', '63', null);
INSERT INTO `com_grade` VALUES ('140403033', '10000006', '27', '27', '27', '27', null);
INSERT INTO `com_grade` VALUES ('140403033', '10000007', '52', '52', '52', '52', null);
INSERT INTO `com_grade` VALUES ('140403034', '10000000', '28', '28', '28', '28', null);
INSERT INTO `com_grade` VALUES ('140403034', '10000001', '35', '35', '35', '35', null);
INSERT INTO `com_grade` VALUES ('140403034', '10000002', '40', '40', '40', '40', null);
INSERT INTO `com_grade` VALUES ('140403034', '10000003', '53', '53', '53', '53', null);
INSERT INTO `com_grade` VALUES ('140403034', '10000004', '69', '69', '69', '69', null);
INSERT INTO `com_grade` VALUES ('140403034', '10000005', '78', '78', '78', '78', null);
INSERT INTO `com_grade` VALUES ('140403034', '10000006', '68', '68', '68', '68', null);
INSERT INTO `com_grade` VALUES ('140403034', '10000007', '99', '99', '99', '99', null);
INSERT INTO `com_grade` VALUES ('140403035', '10000000', '41', '41', '41', '41', null);
INSERT INTO `com_grade` VALUES ('140403035', '10000001', '16', '16', '16', '16', null);
INSERT INTO `com_grade` VALUES ('140403035', '10000002', '40', '40', '40', '40', null);
INSERT INTO `com_grade` VALUES ('140403035', '10000003', '10', '10', '10', '10', null);
INSERT INTO `com_grade` VALUES ('140403035', '10000004', '20', '20', '20', '20', null);
INSERT INTO `com_grade` VALUES ('140403035', '10000005', '30', '30', '30', '30', null);
INSERT INTO `com_grade` VALUES ('140403035', '10000006', '5', '5', '5', '5', null);
INSERT INTO `com_grade` VALUES ('140403035', '10000007', '70', '70', '70', '70', null);
INSERT INTO `com_grade` VALUES ('140403036', '10000000', '89', '89', '89', '89', null);
INSERT INTO `com_grade` VALUES ('140403036', '10000001', '56', '56', '56', '56', null);
INSERT INTO `com_grade` VALUES ('140403036', '10000002', '94', '94', '94', '94', null);
INSERT INTO `com_grade` VALUES ('140403036', '10000003', '57', '57', '57', '57', null);
INSERT INTO `com_grade` VALUES ('140403036', '10000004', '82', '82', '82', '82', null);
INSERT INTO `com_grade` VALUES ('140403036', '10000005', '16', '16', '16', '16', null);
INSERT INTO `com_grade` VALUES ('140403036', '10000006', '60', '60', '60', '60', null);
INSERT INTO `com_grade` VALUES ('140403036', '10000007', '97', '97', '97', '97', null);
INSERT INTO `com_grade` VALUES ('140403037', '10000000', '26', '26', '26', '26', null);
INSERT INTO `com_grade` VALUES ('140403037', '10000001', '0', '0', '0', '0', null);
INSERT INTO `com_grade` VALUES ('140403037', '10000002', '13', '13', '13', '13', null);
INSERT INTO `com_grade` VALUES ('140403037', '10000003', '71', '71', '71', '71', null);
INSERT INTO `com_grade` VALUES ('140403037', '10000004', '17', '17', '17', '17', null);
INSERT INTO `com_grade` VALUES ('140403037', '10000005', '83', '83', '83', '83', null);
INSERT INTO `com_grade` VALUES ('140403037', '10000006', '35', '35', '35', '35', null);
INSERT INTO `com_grade` VALUES ('140403037', '10000007', '59', '59', '59', '59', null);
INSERT INTO `com_grade` VALUES ('140403038', '10000000', '43', '43', '43', '43', null);
INSERT INTO `com_grade` VALUES ('140403038', '10000001', '38', '38', '38', '38', null);
INSERT INTO `com_grade` VALUES ('140403038', '10000002', '80', '80', '80', '80', null);
INSERT INTO `com_grade` VALUES ('140403038', '10000003', '73', '73', '73', '73', null);
INSERT INTO `com_grade` VALUES ('140403038', '10000004', '66', '66', '66', '66', null);
INSERT INTO `com_grade` VALUES ('140403038', '10000005', '32', '32', '32', '32', null);
INSERT INTO `com_grade` VALUES ('140403038', '10000006', '83', '83', '83', '83', null);
INSERT INTO `com_grade` VALUES ('140403038', '10000007', '8', '8', '8', '8', null);
INSERT INTO `com_grade` VALUES ('140403039', '10000000', '41', '41', '41', '41', null);
INSERT INTO `com_grade` VALUES ('140403039', '10000001', '14', '14', '14', '14', null);
INSERT INTO `com_grade` VALUES ('140403039', '10000002', '61', '61', '61', '61', null);
INSERT INTO `com_grade` VALUES ('140403039', '10000003', '95', '95', '95', '95', null);
INSERT INTO `com_grade` VALUES ('140403039', '10000004', '81', '81', '81', '81', null);
INSERT INTO `com_grade` VALUES ('140403039', '10000005', '11', '11', '11', '11', null);
INSERT INTO `com_grade` VALUES ('140403039', '10000006', '90', '90', '90', '90', null);
INSERT INTO `com_grade` VALUES ('140403039', '10000007', '93', '93', '93', '93', null);
INSERT INTO `com_grade` VALUES ('140404040', '10000000', '94', '94', '94', '94', null);
INSERT INTO `com_grade` VALUES ('140404040', '10000001', '66', '66', '66', '66', null);
INSERT INTO `com_grade` VALUES ('140404040', '10000002', '54', '54', '54', '54', null);
INSERT INTO `com_grade` VALUES ('140404040', '10000003', '17', '17', '17', '17', null);
INSERT INTO `com_grade` VALUES ('140404040', '10000004', '16', '16', '16', '16', null);
INSERT INTO `com_grade` VALUES ('140404040', '10000005', '76', '76', '76', '76', null);
INSERT INTO `com_grade` VALUES ('140404040', '10000006', '20', '20', '20', '20', null);
INSERT INTO `com_grade` VALUES ('140404040', '10000007', '38', '38', '38', '38', null);
INSERT INTO `com_grade` VALUES ('140404041', '10000000', '67', '67', '67', '67', null);
INSERT INTO `com_grade` VALUES ('140404041', '10000001', '88', '88', '88', '88', null);
INSERT INTO `com_grade` VALUES ('140404041', '10000002', '97', '97', '97', '97', null);
INSERT INTO `com_grade` VALUES ('140404041', '10000003', '24', '24', '24', '24', null);
INSERT INTO `com_grade` VALUES ('140404041', '10000004', '79', '79', '79', '79', null);
INSERT INTO `com_grade` VALUES ('140404041', '10000005', '78', '78', '78', '78', null);
INSERT INTO `com_grade` VALUES ('140404041', '10000006', '14', '14', '14', '14', null);
INSERT INTO `com_grade` VALUES ('140404041', '10000007', '20', '20', '20', '20', null);
INSERT INTO `com_grade` VALUES ('140404042', '10000000', '67', '67', '67', '67', null);
INSERT INTO `com_grade` VALUES ('140404042', '10000001', '29', '29', '29', '29', null);
INSERT INTO `com_grade` VALUES ('140404042', '10000002', '98', '98', '98', '98', null);
INSERT INTO `com_grade` VALUES ('140404042', '10000003', '81', '81', '81', '81', null);
INSERT INTO `com_grade` VALUES ('140404042', '10000004', '63', '63', '63', '63', null);
INSERT INTO `com_grade` VALUES ('140404042', '10000005', '96', '96', '96', '96', null);
INSERT INTO `com_grade` VALUES ('140404042', '10000006', '85', '85', '85', '85', null);
INSERT INTO `com_grade` VALUES ('140404042', '10000007', '27', '27', '27', '27', null);
INSERT INTO `com_grade` VALUES ('140404043', '10000000', '11', '11', '11', '11', null);
INSERT INTO `com_grade` VALUES ('140404043', '10000001', '26', '26', '26', '26', null);
INSERT INTO `com_grade` VALUES ('140404043', '10000002', '72', '72', '72', '72', null);
INSERT INTO `com_grade` VALUES ('140404043', '10000003', '13', '13', '13', '13', null);
INSERT INTO `com_grade` VALUES ('140404043', '10000004', '54', '54', '54', '54', null);
INSERT INTO `com_grade` VALUES ('140404043', '10000005', '63', '63', '63', '63', null);
INSERT INTO `com_grade` VALUES ('140404043', '10000006', '65', '65', '65', '65', null);
INSERT INTO `com_grade` VALUES ('140404043', '10000007', '41', '41', '41', '41', null);
INSERT INTO `com_grade` VALUES ('140404044', '10000000', '32', '32', '32', '32', null);
INSERT INTO `com_grade` VALUES ('140404044', '10000001', '81', '81', '81', '81', null);
INSERT INTO `com_grade` VALUES ('140404044', '10000002', '12', '12', '12', '12', null);
INSERT INTO `com_grade` VALUES ('140404044', '10000003', '33', '33', '33', '33', null);
INSERT INTO `com_grade` VALUES ('140404044', '10000004', '68', '68', '68', '68', null);
INSERT INTO `com_grade` VALUES ('140404044', '10000005', '99', '99', '99', '99', null);
INSERT INTO `com_grade` VALUES ('140404044', '10000006', '43', '43', '43', '43', null);
INSERT INTO `com_grade` VALUES ('140404044', '10000007', '9', '9', '9', '9', null);
INSERT INTO `com_grade` VALUES ('140404045', '10000000', '40', '40', '40', '40', null);
INSERT INTO `com_grade` VALUES ('140404045', '10000001', '18', '18', '18', '18', null);
INSERT INTO `com_grade` VALUES ('140404045', '10000002', '12', '12', '12', '12', null);
INSERT INTO `com_grade` VALUES ('140404045', '10000003', '14', '14', '14', '14', null);
INSERT INTO `com_grade` VALUES ('140404045', '10000004', '92', '92', '92', '92', null);
INSERT INTO `com_grade` VALUES ('140404045', '10000005', '43', '43', '43', '43', null);
INSERT INTO `com_grade` VALUES ('140404045', '10000006', '40', '40', '40', '40', null);
INSERT INTO `com_grade` VALUES ('140404045', '10000007', '21', '21', '21', '21', null);
INSERT INTO `com_grade` VALUES ('140404046', '10000000', '95', '95', '95', '95', null);
INSERT INTO `com_grade` VALUES ('140404046', '10000001', '2', '2', '2', '2', null);
INSERT INTO `com_grade` VALUES ('140404046', '10000002', '12', '12', '12', '12', null);
INSERT INTO `com_grade` VALUES ('140404046', '10000003', '46', '46', '46', '46', null);
INSERT INTO `com_grade` VALUES ('140404046', '10000004', '60', '60', '60', '60', null);
INSERT INTO `com_grade` VALUES ('140404046', '10000005', '83', '83', '83', '83', null);
INSERT INTO `com_grade` VALUES ('140404046', '10000006', '26', '26', '26', '26', null);
INSERT INTO `com_grade` VALUES ('140404046', '10000007', '84', '84', '84', '84', null);
INSERT INTO `com_grade` VALUES ('140404047', '10000000', '14', '14', '14', '14', null);
INSERT INTO `com_grade` VALUES ('140404047', '10000001', '64', '64', '64', '64', null);
INSERT INTO `com_grade` VALUES ('140404047', '10000002', '47', '47', '47', '47', null);
INSERT INTO `com_grade` VALUES ('140404047', '10000003', '52', '52', '52', '52', null);
INSERT INTO `com_grade` VALUES ('140404047', '10000004', '78', '78', '78', '78', null);
INSERT INTO `com_grade` VALUES ('140404047', '10000005', '56', '56', '56', '56', null);
INSERT INTO `com_grade` VALUES ('140404047', '10000006', '92', '92', '92', '92', null);
INSERT INTO `com_grade` VALUES ('140404047', '10000007', '75', '75', '75', '75', null);
INSERT INTO `com_grade` VALUES ('140404048', '10000000', '17', '17', '17', '17', null);
INSERT INTO `com_grade` VALUES ('140404048', '10000001', '45', '45', '45', '45', null);
INSERT INTO `com_grade` VALUES ('140404048', '10000002', '1', '1', '1', '1', null);
INSERT INTO `com_grade` VALUES ('140404048', '10000003', '66', '66', '66', '66', null);
INSERT INTO `com_grade` VALUES ('140404048', '10000004', '87', '87', '87', '87', null);
INSERT INTO `com_grade` VALUES ('140404048', '10000005', '61', '61', '61', '61', null);
INSERT INTO `com_grade` VALUES ('140404048', '10000006', '97', '97', '97', '97', null);
INSERT INTO `com_grade` VALUES ('140404048', '10000007', '16', '16', '16', '16', null);
INSERT INTO `com_grade` VALUES ('140404049', '10000000', '57', '57', '57', '57', null);
INSERT INTO `com_grade` VALUES ('140404049', '10000001', '62', '62', '62', '62', null);
INSERT INTO `com_grade` VALUES ('140404049', '10000002', '64', '64', '64', '64', null);
INSERT INTO `com_grade` VALUES ('140404049', '10000003', '70', '70', '70', '70', null);
INSERT INTO `com_grade` VALUES ('140404049', '10000004', '62', '62', '62', '62', null);
INSERT INTO `com_grade` VALUES ('140404049', '10000005', '30', '30', '30', '30', null);
INSERT INTO `com_grade` VALUES ('140404049', '10000006', '41', '41', '41', '41', null);
INSERT INTO `com_grade` VALUES ('140404049', '10000007', '8', '8', '8', '8', null);
INSERT INTO `com_grade` VALUES ('140405050', '10000000', '35', '35', '35', '35', null);
INSERT INTO `com_grade` VALUES ('140405050', '10000001', '16', '16', '16', '16', null);
INSERT INTO `com_grade` VALUES ('140405050', '10000002', '86', '86', '86', '86', null);
INSERT INTO `com_grade` VALUES ('140405050', '10000003', '51', '51', '51', '51', null);
INSERT INTO `com_grade` VALUES ('140405050', '10000004', '63', '63', '63', '63', null);
INSERT INTO `com_grade` VALUES ('140405050', '10000005', '85', '85', '85', '85', null);
INSERT INTO `com_grade` VALUES ('140405050', '10000006', '50', '50', '50', '50', null);
INSERT INTO `com_grade` VALUES ('140405050', '10000007', '84', '84', '84', '84', null);
INSERT INTO `com_grade` VALUES ('140405051', '10000000', '95', '95', '95', '95', null);
INSERT INTO `com_grade` VALUES ('140405051', '10000001', '67', '67', '67', '67', null);
INSERT INTO `com_grade` VALUES ('140405051', '10000002', '18', '18', '18', '18', null);
INSERT INTO `com_grade` VALUES ('140405051', '10000003', '29', '29', '29', '29', null);
INSERT INTO `com_grade` VALUES ('140405051', '10000004', '86', '86', '86', '86', null);
INSERT INTO `com_grade` VALUES ('140405051', '10000005', '58', '58', '58', '58', null);
INSERT INTO `com_grade` VALUES ('140405051', '10000006', '37', '37', '37', '37', null);
INSERT INTO `com_grade` VALUES ('140405051', '10000007', '99', '99', '99', '99', null);
INSERT INTO `com_grade` VALUES ('140405052', '10000000', '8', '8', '8', '8', null);
INSERT INTO `com_grade` VALUES ('140405052', '10000001', '47', '47', '47', '47', null);
INSERT INTO `com_grade` VALUES ('140405052', '10000002', '60', '60', '60', '60', null);
INSERT INTO `com_grade` VALUES ('140405052', '10000003', '45', '45', '45', '45', null);
INSERT INTO `com_grade` VALUES ('140405052', '10000004', '13', '13', '13', '13', null);
INSERT INTO `com_grade` VALUES ('140405052', '10000005', '56', '56', '56', '56', null);
INSERT INTO `com_grade` VALUES ('140405052', '10000006', '52', '52', '52', '52', null);
INSERT INTO `com_grade` VALUES ('140405052', '10000007', '49', '49', '49', '49', null);
INSERT INTO `com_grade` VALUES ('140405053', '10000000', '31', '31', '31', '31', null);
INSERT INTO `com_grade` VALUES ('140405053', '10000001', '44', '44', '44', '44', null);
INSERT INTO `com_grade` VALUES ('140405053', '10000002', '88', '88', '88', '88', null);
INSERT INTO `com_grade` VALUES ('140405053', '10000003', '94', '94', '94', '94', null);
INSERT INTO `com_grade` VALUES ('140405053', '10000004', '29', '29', '29', '29', null);
INSERT INTO `com_grade` VALUES ('140405053', '10000005', '49', '49', '49', '49', null);
INSERT INTO `com_grade` VALUES ('140405053', '10000006', '47', '47', '47', '47', null);
INSERT INTO `com_grade` VALUES ('140405053', '10000007', '46', '46', '46', '46', null);
INSERT INTO `com_grade` VALUES ('140405054', '10000000', '8', '8', '8', '8', null);
INSERT INTO `com_grade` VALUES ('140405054', '10000001', '35', '35', '35', '35', null);
INSERT INTO `com_grade` VALUES ('140405054', '10000002', '67', '67', '67', '67', null);
INSERT INTO `com_grade` VALUES ('140405054', '10000003', '60', '60', '60', '60', null);
INSERT INTO `com_grade` VALUES ('140405054', '10000004', '49', '49', '49', '49', null);
INSERT INTO `com_grade` VALUES ('140405054', '10000005', '77', '77', '77', '77', null);
INSERT INTO `com_grade` VALUES ('140405054', '10000006', '71', '71', '71', '71', null);
INSERT INTO `com_grade` VALUES ('140405054', '10000007', '25', '25', '25', '25', null);
INSERT INTO `com_grade` VALUES ('140405055', '10000000', '71', '71', '71', '71', null);
INSERT INTO `com_grade` VALUES ('140405055', '10000001', '52', '52', '52', '52', null);
INSERT INTO `com_grade` VALUES ('140405055', '10000002', '52', '52', '52', '52', null);
INSERT INTO `com_grade` VALUES ('140405055', '10000003', '46', '46', '46', '46', null);
INSERT INTO `com_grade` VALUES ('140405055', '10000004', '89', '89', '89', '89', null);
INSERT INTO `com_grade` VALUES ('140405055', '10000005', '0', '0', '0', '0', null);
INSERT INTO `com_grade` VALUES ('140405055', '10000006', '50', '50', '50', '50', null);
INSERT INTO `com_grade` VALUES ('140405055', '10000007', '27', '27', '27', '27', null);
INSERT INTO `com_grade` VALUES ('140405056', '10000000', '22', '22', '22', '22', null);
INSERT INTO `com_grade` VALUES ('140405056', '10000001', '60', '60', '60', '60', null);
INSERT INTO `com_grade` VALUES ('140405056', '10000002', '32', '32', '32', '32', null);
INSERT INTO `com_grade` VALUES ('140405056', '10000003', '83', '83', '83', '83', null);
INSERT INTO `com_grade` VALUES ('140405056', '10000004', '51', '51', '51', '51', null);
INSERT INTO `com_grade` VALUES ('140405056', '10000005', '83', '83', '83', '83', null);
INSERT INTO `com_grade` VALUES ('140405056', '10000006', '24', '24', '24', '24', null);
INSERT INTO `com_grade` VALUES ('140405056', '10000007', '45', '45', '45', '45', null);
INSERT INTO `com_grade` VALUES ('140405057', '10000000', '98', '98', '98', '98', null);
INSERT INTO `com_grade` VALUES ('140405057', '10000001', '27', '27', '27', '27', null);
INSERT INTO `com_grade` VALUES ('140405057', '10000002', '28', '28', '28', '28', null);
INSERT INTO `com_grade` VALUES ('140405057', '10000003', '89', '89', '89', '89', null);
INSERT INTO `com_grade` VALUES ('140405057', '10000004', '94', '94', '94', '94', null);
INSERT INTO `com_grade` VALUES ('140405057', '10000005', '52', '52', '52', '52', null);
INSERT INTO `com_grade` VALUES ('140405057', '10000006', '76', '76', '76', '76', null);
INSERT INTO `com_grade` VALUES ('140405057', '10000007', '46', '46', '46', '46', null);
INSERT INTO `com_grade` VALUES ('140405058', '10000000', '47', '47', '47', '47', null);
INSERT INTO `com_grade` VALUES ('140405058', '10000001', '19', '19', '19', '19', null);
INSERT INTO `com_grade` VALUES ('140405058', '10000002', '9', '9', '9', '9', null);
INSERT INTO `com_grade` VALUES ('140405058', '10000003', '38', '38', '38', '38', null);
INSERT INTO `com_grade` VALUES ('140405058', '10000004', '12', '12', '12', '12', null);
INSERT INTO `com_grade` VALUES ('140405058', '10000005', '56', '56', '56', '56', null);
INSERT INTO `com_grade` VALUES ('140405058', '10000006', '59', '59', '59', '59', null);
INSERT INTO `com_grade` VALUES ('140405058', '10000007', '75', '75', '75', '75', null);
INSERT INTO `com_grade` VALUES ('140405059', '10000000', '59', '59', '59', '59', null);
INSERT INTO `com_grade` VALUES ('140405059', '10000001', '81', '81', '81', '81', null);
INSERT INTO `com_grade` VALUES ('140405059', '10000002', '94', '94', '94', '94', null);
INSERT INTO `com_grade` VALUES ('140405059', '10000003', '56', '56', '56', '56', null);
INSERT INTO `com_grade` VALUES ('140405059', '10000004', '15', '15', '15', '15', null);
INSERT INTO `com_grade` VALUES ('140405059', '10000005', '41', '41', '41', '41', null);
INSERT INTO `com_grade` VALUES ('140405059', '10000006', '16', '16', '16', '16', null);
INSERT INTO `com_grade` VALUES ('140405059', '10000007', '48', '48', '48', '48', null);

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
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8 COMMENT='学生表';

-- ----------------------------
-- Records of com_student
-- ----------------------------
INSERT INTO `com_student` VALUES ('1', '140401049', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '01', null, null);
INSERT INTO `com_student` VALUES ('7', '140400000', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '0', null, null);
INSERT INTO `com_student` VALUES ('8', '140400001', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '0', null, null);
INSERT INTO `com_student` VALUES ('9', '140400002', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '0', null, null);
INSERT INTO `com_student` VALUES ('10', '140400003', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '0', null, null);
INSERT INTO `com_student` VALUES ('11', '140400004', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '0', null, null);
INSERT INTO `com_student` VALUES ('12', '140400005', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '0', null, null);
INSERT INTO `com_student` VALUES ('13', '140400006', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '0', null, null);
INSERT INTO `com_student` VALUES ('14', '140400007', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '0', null, null);
INSERT INTO `com_student` VALUES ('15', '140400008', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '0', null, null);
INSERT INTO `com_student` VALUES ('16', '140400009', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '0', null, null);
INSERT INTO `com_student` VALUES ('17', '140401010', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '1', null, null);
INSERT INTO `com_student` VALUES ('18', '140401011', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '1', null, null);
INSERT INTO `com_student` VALUES ('19', '140401012', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '1', null, null);
INSERT INTO `com_student` VALUES ('20', '140401013', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '1', null, null);
INSERT INTO `com_student` VALUES ('21', '140401014', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '1', null, null);
INSERT INTO `com_student` VALUES ('22', '140401015', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '1', null, null);
INSERT INTO `com_student` VALUES ('23', '140401016', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '1', null, null);
INSERT INTO `com_student` VALUES ('24', '140401017', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '1', null, null);
INSERT INTO `com_student` VALUES ('25', '140401018', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '1', null, null);
INSERT INTO `com_student` VALUES ('26', '140401019', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '1', null, null);
INSERT INTO `com_student` VALUES ('27', '140402020', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '2', null, null);
INSERT INTO `com_student` VALUES ('28', '140402021', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '2', null, null);
INSERT INTO `com_student` VALUES ('29', '140402022', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '2', null, null);
INSERT INTO `com_student` VALUES ('30', '140402023', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '2', null, null);
INSERT INTO `com_student` VALUES ('31', '140402024', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '2', null, null);
INSERT INTO `com_student` VALUES ('32', '140402025', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '2', null, null);
INSERT INTO `com_student` VALUES ('33', '140402026', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '2', null, null);
INSERT INTO `com_student` VALUES ('34', '140402027', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '2', null, null);
INSERT INTO `com_student` VALUES ('35', '140402028', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '2', null, null);
INSERT INTO `com_student` VALUES ('36', '140402029', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '2', null, null);
INSERT INTO `com_student` VALUES ('37', '140403030', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '3', null, null);
INSERT INTO `com_student` VALUES ('38', '140403031', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '3', null, null);
INSERT INTO `com_student` VALUES ('39', '140403032', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '3', null, null);
INSERT INTO `com_student` VALUES ('40', '140403033', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '3', null, null);
INSERT INTO `com_student` VALUES ('41', '140403034', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '3', null, null);
INSERT INTO `com_student` VALUES ('42', '140403035', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '3', null, null);
INSERT INTO `com_student` VALUES ('43', '140403036', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '3', null, null);
INSERT INTO `com_student` VALUES ('44', '140403037', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '3', null, null);
INSERT INTO `com_student` VALUES ('45', '140403038', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '3', null, null);
INSERT INTO `com_student` VALUES ('46', '140403039', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '3', null, null);
INSERT INTO `com_student` VALUES ('47', '140404040', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '4', null, null);
INSERT INTO `com_student` VALUES ('48', '140404041', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '4', null, null);
INSERT INTO `com_student` VALUES ('49', '140404042', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '4', null, null);
INSERT INTO `com_student` VALUES ('50', '140404043', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '4', null, null);
INSERT INTO `com_student` VALUES ('51', '140404044', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '4', null, null);
INSERT INTO `com_student` VALUES ('52', '140404045', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '4', null, null);
INSERT INTO `com_student` VALUES ('53', '140404046', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '4', null, null);
INSERT INTO `com_student` VALUES ('54', '140404047', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '4', null, null);
INSERT INTO `com_student` VALUES ('55', '140404048', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '4', null, null);
INSERT INTO `com_student` VALUES ('56', '140404049', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '4', null, null);
INSERT INTO `com_student` VALUES ('57', '140405050', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '5', null, null);
INSERT INTO `com_student` VALUES ('58', '140405051', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '5', null, null);
INSERT INTO `com_student` VALUES ('59', '140405052', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '5', null, null);
INSERT INTO `com_student` VALUES ('60', '140405053', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '5', null, null);
INSERT INTO `com_student` VALUES ('61', '140405054', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '5', null, null);
INSERT INTO `com_student` VALUES ('62', '140405055', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '5', null, null);
INSERT INTO `com_student` VALUES ('63', '140405056', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '5', null, null);
INSERT INTO `com_student` VALUES ('64', '140405057', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '5', null, null);
INSERT INTO `com_student` VALUES ('65', '140405058', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '5', null, null);
INSERT INTO `com_student` VALUES ('66', '140405059', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '5', null, null);

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
INSERT INTO `com_teacher` VALUES ('18', '140400', '827ccb0eea8a706c4c34a16891f84e7b', 'yang', null, null, null, null, null);
INSERT INTO `com_teacher` VALUES ('19', '140401', '827ccb0eea8a706c4c34a16891f84e7b', 'yangxuyue', null, null, null, null, null);
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
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000000', '140401', '2017-05-16', '2017-05-31');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000000', '140402', '2017-05-16', '2017-05-31');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000000', '140403', '2017-05-16', '2017-05-31');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000000', '140404', '2017-05-16', '2017-05-31');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000000', '140405', '2017-05-16', '2017-05-31');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000001', '140401', '2017-05-16', '2017-05-31');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000001', '140402', '2017-05-16', '2017-05-31');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000001', '140403', '2017-05-23', '2017-05-23');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000001', '140405', '2017-05-16', '2017-05-31');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000002', '140400', '2017-01-02', '2017-05-15');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000002', '140401', '2017-05-16', '2017-05-31');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000002', '140402', '2017-05-16', '2017-05-31');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000002', '140403', '2017-05-16', '2017-05-31');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000002', '140404', '2017-05-16', '2017-05-31');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000002', '140405', '2017-05-16', '2017-05-31');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000003', '140400', '2017-05-16', '2017-05-31');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000003', '140401', '2017-05-16', '2017-05-31');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000003', '140403', '2017-05-23', '2017-05-23');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000003', '140404', '2017-05-16', '2017-05-31');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000003', '140405', '2017-05-16', '2017-05-31');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000004', '140400', '2017-05-16', '2017-05-31');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000004', '140403', '2017-05-16', '2017-05-31');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000004', '140405', '2017-05-23', '2017-05-31');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000005', '140400', '2017-05-23', '2017-05-23');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000005', '140401', '2017-05-23', '2017-05-23');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000005', '140402', '2017-05-23', '2017-05-31');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000005', '140403', '2017-05-23', '2017-05-31');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000005', '140405', '2017-05-23', '2017-05-23');
INSERT INTO `com_teacher_l_course` VALUES ('140401', '10000000', '140400', '2017-05-01', '2017-05-31');

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
