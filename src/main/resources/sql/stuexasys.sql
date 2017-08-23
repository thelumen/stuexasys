/*
Navicat MySQL Data Transfer

Source Server         : mylove1621
Source Server Version : 50713
Source Host           : 127.0.0.1:3306
Source Database       : stuexasys

Target Server Type    : MYSQL
Target Server Version : 50713
File Encoding         : 65001

Date: 2017-08-23 22:54:43
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='附加题表';

-- ----------------------------
-- Records of com_another_question
-- ----------------------------
INSERT INTO `com_another_question` VALUES ('1', '10000000', '111', '111');
INSERT INTO `com_another_question` VALUES ('2', '10000000', '222', '222');
INSERT INTO `com_another_question` VALUES ('3', '10000000', '333', '333');
INSERT INTO `com_another_question` VALUES ('4', '10000001', '1111', '1111');
INSERT INTO `com_another_question` VALUES ('5', '10000001', '2222', '2222');
INSERT INTO `com_another_question` VALUES ('6', '10000002', '3333', '3333');
INSERT INTO `com_another_question` VALUES ('8', '10000000', '325235', '5321451');
INSERT INTO `com_another_question` VALUES ('9', '10000000', '325235', '5321451');
INSERT INTO `com_another_question` VALUES ('10', '10000001', '325235', '5321451');
INSERT INTO `com_another_question` VALUES ('11', '10000000', '325325342', '652436246');
INSERT INTO `com_another_question` VALUES ('12', '10000000', '23月45', '32465423624');
INSERT INTO `com_another_question` VALUES ('13', '10000000', '韩国人头合同人它已经热压机', '济仁堂脚疼监听耳机特优级特优级体育');

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
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='考试信息表';

-- ----------------------------
-- Records of com_examinfo
-- ----------------------------
INSERT INTO `com_examinfo` VALUES ('10', '140402', '10000000', '1,4,6', '2047-06-03', '0', '3,5,6,7', '2017-08-01', '1', '4,5,6', '2044-07-03', '0', '2040-07-05', '0', '0', '0');
INSERT INTO `com_examinfo` VALUES ('12', '140401', '10000000', '1,5,6,7', null, '1', null, null, '0', null, null, '0', null, '0', '1', '0');
INSERT INTO `com_examinfo` VALUES ('13', '140400', '10000000', null, null, '0', null, null, '1', null, null, '0', null, '0', '0', '0');
INSERT INTO `com_examinfo` VALUES ('15', '140405', '10000001', null, null, '1', null, null, '0', null, null, '0', null, '0', '0', '0');

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
-- Records of com_grade
-- ----------------------------
INSERT INTO `com_grade` VALUES ('140400000', '10000000', '68', '73', '71', '20', '43');
INSERT INTO `com_grade` VALUES ('140400000', '10000001', '35', '71', '99', '93', '85');
INSERT INTO `com_grade` VALUES ('140400000', '10000002', '21', '57', '99', '43', null);
INSERT INTO `com_grade` VALUES ('140400000', '10000003', '53', '74', '94', '81', null);
INSERT INTO `com_grade` VALUES ('140400000', '10000004', '35', '40', '16', '6', null);
INSERT INTO `com_grade` VALUES ('140400000', '10000005', '27', '7', '2', '85', null);
INSERT INTO `com_grade` VALUES ('140400000', '10000006', '91', '72', '33', '43', null);
INSERT INTO `com_grade` VALUES ('140400000', '10000007', '75', '90', '91', '81', null);
INSERT INTO `com_grade` VALUES ('140400001', '10000000', '0', '92', '71', '100', '45');
INSERT INTO `com_grade` VALUES ('140400001', '10000001', '10', '79', '39', '37', '43');
INSERT INTO `com_grade` VALUES ('140400001', '10000002', '98', '26', '90', '0', null);
INSERT INTO `com_grade` VALUES ('140400001', '10000003', '17', '10', '76', '87', null);
INSERT INTO `com_grade` VALUES ('140400001', '10000004', '33', '56', '29', '43', null);
INSERT INTO `com_grade` VALUES ('140400001', '10000005', '4', '49', '28', '95', null);
INSERT INTO `com_grade` VALUES ('140400001', '10000006', '91', '66', '83', '26', null);
INSERT INTO `com_grade` VALUES ('140400001', '10000007', '49', '62', '89', '32', null);
INSERT INTO `com_grade` VALUES ('140400002', '10000000', '95', '3', '69', '100', '58');
INSERT INTO `com_grade` VALUES ('140400002', '10000001', '38', '43', '24', '26', '30');
INSERT INTO `com_grade` VALUES ('140400002', '10000002', '69', '2', '84', '49', null);
INSERT INTO `com_grade` VALUES ('140400002', '10000003', '53', '39', '24', '38', null);
INSERT INTO `com_grade` VALUES ('140400002', '10000004', '72', '77', '91', '82', null);
INSERT INTO `com_grade` VALUES ('140400002', '10000005', '27', '80', '37', '61', null);
INSERT INTO `com_grade` VALUES ('140400002', '10000006', '42', '99', '24', '59', null);
INSERT INTO `com_grade` VALUES ('140400002', '10000007', '22', '56', '63', '28', null);
INSERT INTO `com_grade` VALUES ('140400003', '10000000', '88', '82', '68', '13', '75');
INSERT INTO `com_grade` VALUES ('140400003', '10000001', '62', '56', '44', '23', '40');
INSERT INTO `com_grade` VALUES ('140400003', '10000002', '18', '25', '49', '41', null);
INSERT INTO `com_grade` VALUES ('140400003', '10000003', '1', '37', '65', '1', null);
INSERT INTO `com_grade` VALUES ('140400003', '10000004', '41', '82', '47', '13', null);
INSERT INTO `com_grade` VALUES ('140400003', '10000005', '28', '37', '0', '64', null);
INSERT INTO `com_grade` VALUES ('140400003', '10000006', '45', '49', '92', '35', null);
INSERT INTO `com_grade` VALUES ('140400003', '10000007', '12', '13', '69', '28', null);
INSERT INTO `com_grade` VALUES ('140400004', '10000000', '19', '95', '59', '60', '57');
INSERT INTO `com_grade` VALUES ('140400004', '10000001', '71', '69', '79', '72', '73');
INSERT INTO `com_grade` VALUES ('140400004', '10000002', '51', '41', '37', '8', null);
INSERT INTO `com_grade` VALUES ('140400004', '10000003', '64', '83', '34', '84', null);
INSERT INTO `com_grade` VALUES ('140400004', '10000004', '90', '93', '59', '48', null);
INSERT INTO `com_grade` VALUES ('140400004', '10000005', '62', '22', '90', '1', null);
INSERT INTO `com_grade` VALUES ('140400004', '10000006', '59', '1', '0', '74', null);
INSERT INTO `com_grade` VALUES ('140400004', '10000007', '75', '28', '28', '79', null);
INSERT INTO `com_grade` VALUES ('140400005', '10000000', '25', '44', '26', '35', '33');
INSERT INTO `com_grade` VALUES ('140400005', '10000001', '93', '95', '24', '39', '51');
INSERT INTO `com_grade` VALUES ('140400005', '10000002', '65', '7', '14', '80', null);
INSERT INTO `com_grade` VALUES ('140400005', '10000003', '82', '79', '23', '65', null);
INSERT INTO `com_grade` VALUES ('140400005', '10000004', '37', '3', '12', '59', null);
INSERT INTO `com_grade` VALUES ('140400005', '10000005', '84', '83', '94', '86', null);
INSERT INTO `com_grade` VALUES ('140400005', '10000006', '26', '16', '21', '18', null);
INSERT INTO `com_grade` VALUES ('140400005', '10000007', '52', '88', '84', '16', null);
INSERT INTO `com_grade` VALUES ('140400006', '10000000', '31', '73', '52', '14', '39');
INSERT INTO `com_grade` VALUES ('140400006', '10000001', '39', '14', '35', '10', '21');
INSERT INTO `com_grade` VALUES ('140400006', '10000002', '14', '21', '55', '54', null);
INSERT INTO `com_grade` VALUES ('140400006', '10000003', '96', '8', '25', '51', null);
INSERT INTO `com_grade` VALUES ('140400006', '10000004', '24', '32', '34', '36', null);
INSERT INTO `com_grade` VALUES ('140400006', '10000005', '16', '9', '63', '85', null);
INSERT INTO `com_grade` VALUES ('140400006', '10000006', '93', '58', '31', '93', null);
INSERT INTO `com_grade` VALUES ('140400006', '10000007', '1', '20', '25', '47', null);
INSERT INTO `com_grade` VALUES ('140400007', '10000000', '37', '34', '62', '73', '58');
INSERT INTO `com_grade` VALUES ('140400007', '10000001', '94', '48', '81', '81', '76');
INSERT INTO `com_grade` VALUES ('140400007', '10000002', '88', '73', '27', '9', null);
INSERT INTO `com_grade` VALUES ('140400007', '10000003', '9', '95', '15', '28', null);
INSERT INTO `com_grade` VALUES ('140400007', '10000004', '87', '96', '47', '21', null);
INSERT INTO `com_grade` VALUES ('140400007', '10000005', '74', '74', '13', '70', null);
INSERT INTO `com_grade` VALUES ('140400007', '10000006', '37', '63', '85', '67', null);
INSERT INTO `com_grade` VALUES ('140400007', '10000007', '2', '82', '47', '97', null);
INSERT INTO `com_grade` VALUES ('140400008', '10000000', '96', '98', '33', '4', '41');
INSERT INTO `com_grade` VALUES ('140400008', '10000001', '86', '1', '52', '40', '40');
INSERT INTO `com_grade` VALUES ('140400008', '10000002', '23', '61', '34', '12', null);
INSERT INTO `com_grade` VALUES ('140400008', '10000003', '18', '13', '74', '83', null);
INSERT INTO `com_grade` VALUES ('140400008', '10000004', '95', '87', '42', '28', null);
INSERT INTO `com_grade` VALUES ('140400008', '10000005', '13', '49', '53', '61', null);
INSERT INTO `com_grade` VALUES ('140400008', '10000006', '53', '98', '85', '39', null);
INSERT INTO `com_grade` VALUES ('140400008', '10000007', '34', '63', '13', '6', null);
INSERT INTO `com_grade` VALUES ('140400009', '10000000', '21', '6', '85', '32', '42');
INSERT INTO `com_grade` VALUES ('140400009', '10000001', '39', '95', '49', '84', '71');
INSERT INTO `com_grade` VALUES ('140400009', '10000002', '75', '96', '78', '11', null);
INSERT INTO `com_grade` VALUES ('140400009', '10000003', '93', '4', '20', '30', null);
INSERT INTO `com_grade` VALUES ('140400009', '10000004', '49', '28', '94', '26', null);
INSERT INTO `com_grade` VALUES ('140400009', '10000005', '74', '69', '2', '73', null);
INSERT INTO `com_grade` VALUES ('140400009', '10000006', '2', '0', '73', '0', null);
INSERT INTO `com_grade` VALUES ('140400009', '10000007', '80', '18', '63', '51', null);
INSERT INTO `com_grade` VALUES ('140401010', '10000000', '93', '94', '79', '52', '89');
INSERT INTO `com_grade` VALUES ('140401010', '10000001', '89', '27', '91', '77', null);
INSERT INTO `com_grade` VALUES ('140401010', '10000002', '80', '44', '50', '19', null);
INSERT INTO `com_grade` VALUES ('140401010', '10000003', '52', '34', '76', '90', null);
INSERT INTO `com_grade` VALUES ('140401010', '10000004', '46', '46', '8', '42', null);
INSERT INTO `com_grade` VALUES ('140401010', '10000005', '45', '1', '59', '45', null);
INSERT INTO `com_grade` VALUES ('140401010', '10000006', '77', '70', '50', '69', null);
INSERT INTO `com_grade` VALUES ('140401010', '10000007', '53', '94', '79', '21', null);
INSERT INTO `com_grade` VALUES ('140401011', '10000000', '98', '26', '96', '97', '61');
INSERT INTO `com_grade` VALUES ('140401011', '10000001', '31', '75', '86', '77', null);
INSERT INTO `com_grade` VALUES ('140401011', '10000002', '86', '6', '10', '46', null);
INSERT INTO `com_grade` VALUES ('140401011', '10000003', '50', '23', '90', '50', null);
INSERT INTO `com_grade` VALUES ('140401011', '10000004', '30', '75', '51', '53', null);
INSERT INTO `com_grade` VALUES ('140401011', '10000005', '92', '13', '1', '22', null);
INSERT INTO `com_grade` VALUES ('140401011', '10000006', '57', '87', '50', '90', null);
INSERT INTO `com_grade` VALUES ('140401011', '10000007', '8', '25', '16', '30', null);
INSERT INTO `com_grade` VALUES ('140401012', '10000000', '98', '88', '76', '81', '86');
INSERT INTO `com_grade` VALUES ('140401012', '10000001', '94', '86', '47', '84', null);
INSERT INTO `com_grade` VALUES ('140401012', '10000002', '60', '81', '94', '19', null);
INSERT INTO `com_grade` VALUES ('140401012', '10000003', '74', '15', '63', '91', null);
INSERT INTO `com_grade` VALUES ('140401012', '10000004', '53', '53', '36', '9', null);
INSERT INTO `com_grade` VALUES ('140401012', '10000005', '65', '96', '11', '46', null);
INSERT INTO `com_grade` VALUES ('140401012', '10000006', '66', '93', '86', '32', null);
INSERT INTO `com_grade` VALUES ('140401012', '10000007', '7', '8', '1', '35', null);
INSERT INTO `com_grade` VALUES ('140401013', '10000000', '27', '77', '3', '33', '45');
INSERT INTO `com_grade` VALUES ('140401013', '10000001', '52', '58', '70', '89', null);
INSERT INTO `com_grade` VALUES ('140401013', '10000002', '64', '44', '36', '67', null);
INSERT INTO `com_grade` VALUES ('140401013', '10000003', '61', '41', '4', '91', null);
INSERT INTO `com_grade` VALUES ('140401013', '10000004', '13', '20', '14', '24', null);
INSERT INTO `com_grade` VALUES ('140401013', '10000005', '84', '97', '5', '59', null);
INSERT INTO `com_grade` VALUES ('140401013', '10000006', '39', '66', '57', '6', null);
INSERT INTO `com_grade` VALUES ('140401013', '10000007', '90', '60', '47', '25', null);
INSERT INTO `com_grade` VALUES ('140401014', '10000000', '7', '31', '52', '89', '33');
INSERT INTO `com_grade` VALUES ('140401014', '10000001', '14', '89', '71', '92', null);
INSERT INTO `com_grade` VALUES ('140401014', '10000002', '51', '11', '59', '91', null);
INSERT INTO `com_grade` VALUES ('140401014', '10000003', '40', '60', '37', '54', null);
INSERT INTO `com_grade` VALUES ('140401014', '10000004', '13', '68', '78', '25', null);
INSERT INTO `com_grade` VALUES ('140401014', '10000005', '80', '84', '55', '10', null);
INSERT INTO `com_grade` VALUES ('140401014', '10000006', '42', '55', '13', '16', null);
INSERT INTO `com_grade` VALUES ('140401014', '10000007', '5', '76', '22', '5', null);
INSERT INTO `com_grade` VALUES ('140401015', '10000000', '8', '81', '32', '99', '52');
INSERT INTO `com_grade` VALUES ('140401015', '10000001', '26', '48', '34', '77', null);
INSERT INTO `com_grade` VALUES ('140401015', '10000002', '49', '59', '23', '2', null);
INSERT INTO `com_grade` VALUES ('140401015', '10000003', '60', '23', '61', '57', null);
INSERT INTO `com_grade` VALUES ('140401015', '10000004', '15', '2', '89', '30', null);
INSERT INTO `com_grade` VALUES ('140401015', '10000005', '86', '49', '28', '55', null);
INSERT INTO `com_grade` VALUES ('140401015', '10000006', '19', '27', '76', '63', null);
INSERT INTO `com_grade` VALUES ('140401015', '10000007', '47', '73', '43', '13', null);
INSERT INTO `com_grade` VALUES ('140401016', '10000000', '89', '24', '58', '30', '47');
INSERT INTO `com_grade` VALUES ('140401016', '10000001', '44', '71', '49', '6', null);
INSERT INTO `com_grade` VALUES ('140401016', '10000002', '85', '50', '15', '92', null);
INSERT INTO `com_grade` VALUES ('140401016', '10000003', '4', '99', '21', '64', null);
INSERT INTO `com_grade` VALUES ('140401016', '10000004', '91', '32', '39', '44', null);
INSERT INTO `com_grade` VALUES ('140401016', '10000005', '93', '59', '96', '36', null);
INSERT INTO `com_grade` VALUES ('140401016', '10000006', '42', '69', '75', '66', null);
INSERT INTO `com_grade` VALUES ('140401016', '10000007', '12', '11', '16', '33', null);
INSERT INTO `com_grade` VALUES ('140401017', '10000000', '41', '25', '7', '97', '23');
INSERT INTO `com_grade` VALUES ('140401017', '10000001', '78', '27', '76', '67', null);
INSERT INTO `com_grade` VALUES ('140401017', '10000002', '60', '1', '74', '49', null);
INSERT INTO `com_grade` VALUES ('140401017', '10000003', '43', '71', '36', '39', null);
INSERT INTO `com_grade` VALUES ('140401017', '10000004', '37', '54', '75', '46', null);
INSERT INTO `com_grade` VALUES ('140401017', '10000005', '13', '92', '49', '7', null);
INSERT INTO `com_grade` VALUES ('140401017', '10000006', '40', '91', '55', '48', null);
INSERT INTO `com_grade` VALUES ('140401017', '10000007', '15', '33', '83', '42', null);
INSERT INTO `com_grade` VALUES ('140401018', '10000000', '90', '56', '42', '95', '59');
INSERT INTO `com_grade` VALUES ('140401018', '10000001', '63', '40', '65', '96', null);
INSERT INTO `com_grade` VALUES ('140401018', '10000002', '95', '23', '28', '38', null);
INSERT INTO `com_grade` VALUES ('140401018', '10000003', '85', '71', '22', '98', null);
INSERT INTO `com_grade` VALUES ('140401018', '10000004', '62', '64', '67', '29', null);
INSERT INTO `com_grade` VALUES ('140401018', '10000005', '76', '43', '99', '11', null);
INSERT INTO `com_grade` VALUES ('140401018', '10000006', '78', '22', '34', '5', null);
INSERT INTO `com_grade` VALUES ('140401018', '10000007', '56', '39', '55', '57', null);
INSERT INTO `com_grade` VALUES ('140401019', '10000000', '19', '61', '54', '15', '51');
INSERT INTO `com_grade` VALUES ('140401019', '10000001', '61', '86', '26', '47', null);
INSERT INTO `com_grade` VALUES ('140401019', '10000002', '48', '98', '85', '41', null);
INSERT INTO `com_grade` VALUES ('140401019', '10000003', '49', '72', '84', '13', null);
INSERT INTO `com_grade` VALUES ('140401019', '10000004', '84', '47', '33', '9', null);
INSERT INTO `com_grade` VALUES ('140401019', '10000005', '24', '86', '75', '39', null);
INSERT INTO `com_grade` VALUES ('140401019', '10000006', '51', '84', '12', '82', null);
INSERT INTO `com_grade` VALUES ('140401019', '10000007', '38', '55', '13', '12', null);
INSERT INTO `com_grade` VALUES ('140402020', '10000000', '56', '29', '27', '31', '42');
INSERT INTO `com_grade` VALUES ('140402020', '10000001', '39', '83', '69', '23', null);
INSERT INTO `com_grade` VALUES ('140402020', '10000002', '62', '30', '11', '51', null);
INSERT INTO `com_grade` VALUES ('140402020', '10000003', '6', '10', '45', '70', null);
INSERT INTO `com_grade` VALUES ('140402020', '10000004', '99', '48', '16', '11', null);
INSERT INTO `com_grade` VALUES ('140402020', '10000005', '64', '41', '81', '60', null);
INSERT INTO `com_grade` VALUES ('140402020', '10000006', '97', '62', '72', '73', null);
INSERT INTO `com_grade` VALUES ('140402020', '10000007', '16', '1', '12', '75', null);
INSERT INTO `com_grade` VALUES ('140402021', '10000000', '96', '20', '39', '86', '62');
INSERT INTO `com_grade` VALUES ('140402021', '10000001', '88', '20', '56', '45', null);
INSERT INTO `com_grade` VALUES ('140402021', '10000002', '14', '53', '61', '10', null);
INSERT INTO `com_grade` VALUES ('140402021', '10000003', '81', '13', '81', '21', null);
INSERT INTO `com_grade` VALUES ('140402021', '10000004', '89', '37', '95', '63', null);
INSERT INTO `com_grade` VALUES ('140402021', '10000005', '57', '46', '53', '53', null);
INSERT INTO `com_grade` VALUES ('140402021', '10000006', '51', '37', '72', '31', null);
INSERT INTO `com_grade` VALUES ('140402021', '10000007', '43', '0', '37', '84', null);
INSERT INTO `com_grade` VALUES ('140402022', '10000000', '45', '42', '66', '54', '48');
INSERT INTO `com_grade` VALUES ('140402022', '10000001', '50', '63', '12', '41', null);
INSERT INTO `com_grade` VALUES ('140402022', '10000002', '98', '18', '11', '23', null);
INSERT INTO `com_grade` VALUES ('140402022', '10000003', '11', '82', '19', '81', null);
INSERT INTO `com_grade` VALUES ('140402022', '10000004', '79', '84', '90', '97', null);
INSERT INTO `com_grade` VALUES ('140402022', '10000005', '11', '90', '55', '16', null);
INSERT INTO `com_grade` VALUES ('140402022', '10000006', '43', '11', '22', '56', null);
INSERT INTO `com_grade` VALUES ('140402022', '10000007', '42', '93', '56', '31', null);
INSERT INTO `com_grade` VALUES ('140402023', '10000000', '39', '65', '37', '64', '46');
INSERT INTO `com_grade` VALUES ('140402023', '10000001', '80', '62', '59', '81', null);
INSERT INTO `com_grade` VALUES ('140402023', '10000002', '50', '81', '36', '46', null);
INSERT INTO `com_grade` VALUES ('140402023', '10000003', '45', '40', '25', '89', null);
INSERT INTO `com_grade` VALUES ('140402023', '10000004', '59', '80', '73', '80', null);
INSERT INTO `com_grade` VALUES ('140402023', '10000005', '95', '10', '19', '6', null);
INSERT INTO `com_grade` VALUES ('140402023', '10000006', '85', '35', '94', '75', null);
INSERT INTO `com_grade` VALUES ('140402023', '10000007', '68', '30', '63', '90', null);
INSERT INTO `com_grade` VALUES ('140402024', '10000000', '19', '34', '42', '57', '28');
INSERT INTO `com_grade` VALUES ('140402024', '10000001', '76', '58', '25', '92', null);
INSERT INTO `com_grade` VALUES ('140402024', '10000002', '2', '83', '68', '15', null);
INSERT INTO `com_grade` VALUES ('140402024', '10000003', '30', '3', '7', '88', null);
INSERT INTO `com_grade` VALUES ('140402024', '10000004', '18', '21', '91', '23', null);
INSERT INTO `com_grade` VALUES ('140402024', '10000005', '49', '56', '7', '55', null);
INSERT INTO `com_grade` VALUES ('140402024', '10000006', '2', '8', '54', '89', null);
INSERT INTO `com_grade` VALUES ('140402024', '10000007', '43', '26', '24', '83', null);
INSERT INTO `com_grade` VALUES ('140402025', '10000000', '51', '62', '17', '77', '48');
INSERT INTO `com_grade` VALUES ('140402025', '10000001', '26', '89', '39', '75', null);
INSERT INTO `com_grade` VALUES ('140402025', '10000002', '57', '67', '7', '10', null);
INSERT INTO `com_grade` VALUES ('140402025', '10000003', '23', '97', '43', '94', null);
INSERT INTO `com_grade` VALUES ('140402025', '10000004', '23', '57', '73', '28', null);
INSERT INTO `com_grade` VALUES ('140402025', '10000005', '89', '90', '51', '10', null);
INSERT INTO `com_grade` VALUES ('140402025', '10000006', '48', '8', '1', '97', null);
INSERT INTO `com_grade` VALUES ('140402025', '10000007', '58', '56', '27', '57', null);
INSERT INTO `com_grade` VALUES ('140402026', '10000000', '59', '24', '38', '2', '44');
INSERT INTO `com_grade` VALUES ('140402026', '10000001', '45', '11', '65', '67', null);
INSERT INTO `com_grade` VALUES ('140402026', '10000002', '93', '12', '97', '63', null);
INSERT INTO `com_grade` VALUES ('140402026', '10000003', '59', '52', '26', '70', null);
INSERT INTO `com_grade` VALUES ('140402026', '10000004', '57', '83', '55', '66', null);
INSERT INTO `com_grade` VALUES ('140402026', '10000005', '39', '63', '18', '46', null);
INSERT INTO `com_grade` VALUES ('140402026', '10000006', '67', '6', '62', '45', null);
INSERT INTO `com_grade` VALUES ('140402026', '10000007', '35', '59', '75', '23', null);
INSERT INTO `com_grade` VALUES ('140402027', '10000000', '38', '55', '56', '27', '47');
INSERT INTO `com_grade` VALUES ('140402027', '10000001', '15', '37', '85', '50', null);
INSERT INTO `com_grade` VALUES ('140402027', '10000002', '32', '42', '95', '86', null);
INSERT INTO `com_grade` VALUES ('140402027', '10000003', '41', '73', '72', '99', null);
INSERT INTO `com_grade` VALUES ('140402027', '10000004', '67', '21', '29', '32', null);
INSERT INTO `com_grade` VALUES ('140402027', '10000005', '77', '33', '91', '83', null);
INSERT INTO `com_grade` VALUES ('140402027', '10000006', '1', '28', '10', '59', null);
INSERT INTO `com_grade` VALUES ('140402027', '10000007', '78', '91', '89', '44', null);
INSERT INTO `com_grade` VALUES ('140402028', '10000000', '52', '7', '94', '59', '47');
INSERT INTO `com_grade` VALUES ('140402028', '10000001', '32', '24', '44', '8', null);
INSERT INTO `com_grade` VALUES ('140402028', '10000002', '75', '36', '95', '57', null);
INSERT INTO `com_grade` VALUES ('140402028', '10000003', '57', '49', '92', '72', null);
INSERT INTO `com_grade` VALUES ('140402028', '10000004', '46', '66', '23', '49', null);
INSERT INTO `com_grade` VALUES ('140402028', '10000005', '99', '67', '53', '10', null);
INSERT INTO `com_grade` VALUES ('140402028', '10000006', '77', '82', '67', '47', null);
INSERT INTO `com_grade` VALUES ('140402028', '10000007', '35', '31', '65', '37', null);
INSERT INTO `com_grade` VALUES ('140402029', '10000000', '54', '66', '48', '46', '56');
INSERT INTO `com_grade` VALUES ('140402029', '10000001', '82', '85', '29', '71', null);
INSERT INTO `com_grade` VALUES ('140402029', '10000002', '36', '75', '82', '48', null);
INSERT INTO `com_grade` VALUES ('140402029', '10000003', '54', '31', '10', '5', null);
INSERT INTO `com_grade` VALUES ('140402029', '10000004', '69', '80', '6', '57', null);
INSERT INTO `com_grade` VALUES ('140402029', '10000005', '61', '76', '28', '95', null);
INSERT INTO `com_grade` VALUES ('140402029', '10000006', '97', '56', '39', '59', null);
INSERT INTO `com_grade` VALUES ('140402029', '10000007', '5', '14', '72', '71', null);
INSERT INTO `com_grade` VALUES ('140403030', '10000000', '17', '67', '29', '23', '62');
INSERT INTO `com_grade` VALUES ('140403030', '10000001', '33', '93', '15', '78', '87');
INSERT INTO `com_grade` VALUES ('140403030', '10000002', '26', '59', '51', '41', null);
INSERT INTO `com_grade` VALUES ('140403030', '10000003', '95', '55', '60', '34', null);
INSERT INTO `com_grade` VALUES ('140403030', '10000004', '10', '63', '86', '93', null);
INSERT INTO `com_grade` VALUES ('140403030', '10000005', '49', '78', '96', '98', null);
INSERT INTO `com_grade` VALUES ('140403030', '10000006', '96', '52', '7', '59', null);
INSERT INTO `com_grade` VALUES ('140403030', '10000007', '37', '10', '94', '5', null);
INSERT INTO `com_grade` VALUES ('140403031', '10000000', '39', '61', '62', '15', '59');
INSERT INTO `com_grade` VALUES ('140403031', '10000001', '72', '17', '94', '96', '23');
INSERT INTO `com_grade` VALUES ('140403031', '10000002', '93', '51', '93', '88', null);
INSERT INTO `com_grade` VALUES ('140403031', '10000003', '90', '12', '65', '94', null);
INSERT INTO `com_grade` VALUES ('140403031', '10000004', '70', '51', '38', '15', null);
INSERT INTO `com_grade` VALUES ('140403031', '10000005', '36', '70', '66', '84', null);
INSERT INTO `com_grade` VALUES ('140403031', '10000006', '70', '63', '33', '7', null);
INSERT INTO `com_grade` VALUES ('140403031', '10000007', '79', '97', '91', '87', null);
INSERT INTO `com_grade` VALUES ('140403032', '10000000', '77', '35', '79', '24', '39');
INSERT INTO `com_grade` VALUES ('140403032', '10000001', '75', '65', '79', '17', '66');
INSERT INTO `com_grade` VALUES ('140403032', '10000002', '86', '87', '24', '26', null);
INSERT INTO `com_grade` VALUES ('140403032', '10000003', '98', '34', '36', '44', null);
INSERT INTO `com_grade` VALUES ('140403032', '10000004', '2', '37', '27', '17', null);
INSERT INTO `com_grade` VALUES ('140403032', '10000005', '26', '25', '93', '23', null);
INSERT INTO `com_grade` VALUES ('140403032', '10000006', '48', '67', '74', '50', null);
INSERT INTO `com_grade` VALUES ('140403032', '10000007', '27', '21', '14', '99', null);
INSERT INTO `com_grade` VALUES ('140403033', '10000000', '37', '49', '44', '3', '48');
INSERT INTO `com_grade` VALUES ('140403033', '10000001', '38', '67', '1', '35', '64');
INSERT INTO `com_grade` VALUES ('140403033', '10000002', '64', '73', '28', '39', null);
INSERT INTO `com_grade` VALUES ('140403033', '10000003', '13', '28', '40', '63', null);
INSERT INTO `com_grade` VALUES ('140403033', '10000004', '58', '58', '7', '50', null);
INSERT INTO `com_grade` VALUES ('140403033', '10000005', '80', '9', '25', '47', null);
INSERT INTO `com_grade` VALUES ('140403033', '10000006', '42', '98', '17', '58', null);
INSERT INTO `com_grade` VALUES ('140403033', '10000007', '39', '48', '91', '96', null);
INSERT INTO `com_grade` VALUES ('140403034', '10000000', '16', '7', '4', '25', '8');
INSERT INTO `com_grade` VALUES ('140403034', '10000001', '28', '81', '42', '63', '76');
INSERT INTO `com_grade` VALUES ('140403034', '10000002', '3', '67', '23', '14', null);
INSERT INTO `com_grade` VALUES ('140403034', '10000003', '61', '65', '77', '85', null);
INSERT INTO `com_grade` VALUES ('140403034', '10000004', '55', '75', '5', '82', null);
INSERT INTO `com_grade` VALUES ('140403034', '10000005', '37', '3', '16', '6', null);
INSERT INTO `com_grade` VALUES ('140403034', '10000006', '22', '51', '46', '40', null);
INSERT INTO `com_grade` VALUES ('140403034', '10000007', '98', '27', '4', '10', null);
INSERT INTO `com_grade` VALUES ('140403035', '10000000', '68', '10', '1', '11', '16');
INSERT INTO `com_grade` VALUES ('140403035', '10000001', '2', '89', '77', '45', '80');
INSERT INTO `com_grade` VALUES ('140403035', '10000002', '13', '7', '40', '71', null);
INSERT INTO `com_grade` VALUES ('140403035', '10000003', '96', '87', '20', '70', null);
INSERT INTO `com_grade` VALUES ('140403035', '10000004', '37', '69', '68', '77', null);
INSERT INTO `com_grade` VALUES ('140403035', '10000005', '44', '89', '34', '13', null);
INSERT INTO `com_grade` VALUES ('140403035', '10000006', '43', '1', '0', '72', null);
INSERT INTO `com_grade` VALUES ('140403035', '10000007', '78', '86', '92', '49', null);
INSERT INTO `com_grade` VALUES ('140403036', '10000000', '52', '81', '51', '47', '78');
INSERT INTO `com_grade` VALUES ('140403036', '10000001', '31', '22', '47', '7', '23');
INSERT INTO `com_grade` VALUES ('140403036', '10000002', '60', '5', '91', '98', null);
INSERT INTO `com_grade` VALUES ('140403036', '10000003', '49', '1', '99', '44', null);
INSERT INTO `com_grade` VALUES ('140403036', '10000004', '5', '55', '92', '30', null);
INSERT INTO `com_grade` VALUES ('140403036', '10000005', '56', '38', '1', '28', null);
INSERT INTO `com_grade` VALUES ('140403036', '10000006', '10', '19', '95', '58', null);
INSERT INTO `com_grade` VALUES ('140403036', '10000007', '85', '72', '46', '21', null);
INSERT INTO `com_grade` VALUES ('140403037', '10000000', '77', '64', '91', '93', '65');
INSERT INTO `com_grade` VALUES ('140403037', '10000001', '46', '26', '94', '8', '28');
INSERT INTO `com_grade` VALUES ('140403037', '10000002', '51', '66', '40', '65', null);
INSERT INTO `com_grade` VALUES ('140403037', '10000003', '27', '27', '73', '43', null);
INSERT INTO `com_grade` VALUES ('140403037', '10000004', '13', '80', '83', '84', null);
INSERT INTO `com_grade` VALUES ('140403037', '10000005', '15', '79', '37', '74', null);
INSERT INTO `com_grade` VALUES ('140403037', '10000006', '59', '72', '72', '17', null);
INSERT INTO `com_grade` VALUES ('140403037', '10000007', '83', '33', '8', '61', null);
INSERT INTO `com_grade` VALUES ('140403038', '10000000', '16', '0', '71', '81', '2');
INSERT INTO `com_grade` VALUES ('140403038', '10000001', '57', '77', '26', '10', '75');
INSERT INTO `com_grade` VALUES ('140403038', '10000002', '79', '36', '79', '62', null);
INSERT INTO `com_grade` VALUES ('140403038', '10000003', '97', '14', '67', '15', null);
INSERT INTO `com_grade` VALUES ('140403038', '10000004', '43', '41', '40', '61', null);
INSERT INTO `com_grade` VALUES ('140403038', '10000005', '90', '90', '85', '95', null);
INSERT INTO `com_grade` VALUES ('140403038', '10000006', '47', '57', '85', '82', null);
INSERT INTO `com_grade` VALUES ('140403038', '10000007', '33', '16', '54', '12', null);
INSERT INTO `com_grade` VALUES ('140403039', '10000000', '96', '30', '6', '9', '37');
INSERT INTO `com_grade` VALUES ('140403039', '10000001', '34', '75', '21', '67', '71');
INSERT INTO `com_grade` VALUES ('140403039', '10000002', '17', '97', '68', '79', null);
INSERT INTO `com_grade` VALUES ('140403039', '10000003', '61', '33', '69', '28', null);
INSERT INTO `com_grade` VALUES ('140403039', '10000004', '21', '7', '20', '92', null);
INSERT INTO `com_grade` VALUES ('140403039', '10000005', '29', '89', '95', '18', null);
INSERT INTO `com_grade` VALUES ('140403039', '10000006', '41', '41', '56', '16', null);
INSERT INTO `com_grade` VALUES ('140403039', '10000007', '49', '9', '91', '28', null);
INSERT INTO `com_grade` VALUES ('140404040', '10000000', '38', '90', '32', '83', null);
INSERT INTO `com_grade` VALUES ('140404040', '10000001', '60', '94', '79', '8', null);
INSERT INTO `com_grade` VALUES ('140404040', '10000002', '94', '61', '70', '97', null);
INSERT INTO `com_grade` VALUES ('140404040', '10000003', '63', '75', '34', '15', null);
INSERT INTO `com_grade` VALUES ('140404040', '10000004', '11', '77', '37', '56', null);
INSERT INTO `com_grade` VALUES ('140404040', '10000005', '80', '34', '51', '48', null);
INSERT INTO `com_grade` VALUES ('140404040', '10000006', '58', '75', '92', '46', null);
INSERT INTO `com_grade` VALUES ('140404040', '10000007', '55', '20', '54', '58', null);
INSERT INTO `com_grade` VALUES ('140404041', '10000000', '83', '38', '32', '37', null);
INSERT INTO `com_grade` VALUES ('140404041', '10000001', '64', '47', '71', '15', null);
INSERT INTO `com_grade` VALUES ('140404041', '10000002', '55', '14', '44', '63', null);
INSERT INTO `com_grade` VALUES ('140404041', '10000003', '24', '73', '77', '69', null);
INSERT INTO `com_grade` VALUES ('140404041', '10000004', '69', '27', '20', '55', null);
INSERT INTO `com_grade` VALUES ('140404041', '10000005', '64', '49', '73', '85', null);
INSERT INTO `com_grade` VALUES ('140404041', '10000006', '44', '6', '34', '13', null);
INSERT INTO `com_grade` VALUES ('140404041', '10000007', '77', '41', '14', '30', null);
INSERT INTO `com_grade` VALUES ('140404042', '10000000', '64', '42', '93', '46', null);
INSERT INTO `com_grade` VALUES ('140404042', '10000001', '94', '97', '75', '68', null);
INSERT INTO `com_grade` VALUES ('140404042', '10000002', '29', '58', '89', '34', null);
INSERT INTO `com_grade` VALUES ('140404042', '10000003', '19', '53', '57', '82', null);
INSERT INTO `com_grade` VALUES ('140404042', '10000004', '68', '36', '95', '42', null);
INSERT INTO `com_grade` VALUES ('140404042', '10000005', '85', '30', '81', '91', null);
INSERT INTO `com_grade` VALUES ('140404042', '10000006', '40', '50', '97', '17', null);
INSERT INTO `com_grade` VALUES ('140404042', '10000007', '65', '46', '8', '51', null);
INSERT INTO `com_grade` VALUES ('140404043', '10000000', '33', '87', '18', '21', null);
INSERT INTO `com_grade` VALUES ('140404043', '10000001', '99', '81', '85', '60', null);
INSERT INTO `com_grade` VALUES ('140404043', '10000002', '76', '93', '11', '88', null);
INSERT INTO `com_grade` VALUES ('140404043', '10000003', '17', '88', '93', '48', null);
INSERT INTO `com_grade` VALUES ('140404043', '10000004', '82', '88', '55', '55', null);
INSERT INTO `com_grade` VALUES ('140404043', '10000005', '33', '56', '41', '61', null);
INSERT INTO `com_grade` VALUES ('140404043', '10000006', '91', '33', '37', '2', null);
INSERT INTO `com_grade` VALUES ('140404043', '10000007', '7', '45', '94', '59', null);
INSERT INTO `com_grade` VALUES ('140404044', '10000000', '60', '78', '0', '8', null);
INSERT INTO `com_grade` VALUES ('140404044', '10000001', '97', '65', '0', '81', null);
INSERT INTO `com_grade` VALUES ('140404044', '10000002', '16', '59', '94', '26', null);
INSERT INTO `com_grade` VALUES ('140404044', '10000003', '74', '32', '98', '48', null);
INSERT INTO `com_grade` VALUES ('140404044', '10000004', '64', '59', '59', '38', null);
INSERT INTO `com_grade` VALUES ('140404044', '10000005', '81', '58', '46', '11', null);
INSERT INTO `com_grade` VALUES ('140404044', '10000006', '27', '39', '48', '90', null);
INSERT INTO `com_grade` VALUES ('140404044', '10000007', '69', '1', '19', '65', null);
INSERT INTO `com_grade` VALUES ('140404045', '10000000', '63', '68', '93', '63', null);
INSERT INTO `com_grade` VALUES ('140404045', '10000001', '34', '81', '71', '32', null);
INSERT INTO `com_grade` VALUES ('140404045', '10000002', '12', '32', '27', '97', null);
INSERT INTO `com_grade` VALUES ('140404045', '10000003', '65', '97', '15', '34', null);
INSERT INTO `com_grade` VALUES ('140404045', '10000004', '63', '83', '16', '89', null);
INSERT INTO `com_grade` VALUES ('140404045', '10000005', '60', '40', '20', '55', null);
INSERT INTO `com_grade` VALUES ('140404045', '10000006', '64', '33', '69', '46', null);
INSERT INTO `com_grade` VALUES ('140404045', '10000007', '34', '34', '29', '12', null);
INSERT INTO `com_grade` VALUES ('140404046', '10000000', '71', '93', '33', '33', null);
INSERT INTO `com_grade` VALUES ('140404046', '10000001', '70', '16', '31', '7', null);
INSERT INTO `com_grade` VALUES ('140404046', '10000002', '57', '29', '49', '45', null);
INSERT INTO `com_grade` VALUES ('140404046', '10000003', '63', '85', '93', '83', null);
INSERT INTO `com_grade` VALUES ('140404046', '10000004', '19', '84', '42', '46', null);
INSERT INTO `com_grade` VALUES ('140404046', '10000005', '85', '65', '3', '14', null);
INSERT INTO `com_grade` VALUES ('140404046', '10000006', '21', '11', '87', '54', null);
INSERT INTO `com_grade` VALUES ('140404046', '10000007', '62', '39', '83', '51', null);
INSERT INTO `com_grade` VALUES ('140404047', '10000000', '24', '96', '95', '78', null);
INSERT INTO `com_grade` VALUES ('140404047', '10000001', '3', '51', '3', '74', null);
INSERT INTO `com_grade` VALUES ('140404047', '10000002', '21', '20', '58', '1', null);
INSERT INTO `com_grade` VALUES ('140404047', '10000003', '25', '21', '73', '13', null);
INSERT INTO `com_grade` VALUES ('140404047', '10000004', '7', '49', '4', '87', null);
INSERT INTO `com_grade` VALUES ('140404047', '10000005', '17', '48', '65', '44', null);
INSERT INTO `com_grade` VALUES ('140404047', '10000006', '68', '64', '29', '91', null);
INSERT INTO `com_grade` VALUES ('140404047', '10000007', '19', '44', '77', '27', null);
INSERT INTO `com_grade` VALUES ('140404048', '10000000', '47', '66', '31', '67', null);
INSERT INTO `com_grade` VALUES ('140404048', '10000001', '3', '33', '3', '6', null);
INSERT INTO `com_grade` VALUES ('140404048', '10000002', '3', '98', '20', '83', null);
INSERT INTO `com_grade` VALUES ('140404048', '10000003', '43', '53', '55', '57', null);
INSERT INTO `com_grade` VALUES ('140404048', '10000004', '1', '51', '27', '74', null);
INSERT INTO `com_grade` VALUES ('140404048', '10000005', '58', '70', '59', '97', null);
INSERT INTO `com_grade` VALUES ('140404048', '10000006', '88', '22', '84', '18', null);
INSERT INTO `com_grade` VALUES ('140404048', '10000007', '68', '73', '62', '7', null);
INSERT INTO `com_grade` VALUES ('140404049', '10000000', '1', '11', '26', '55', null);
INSERT INTO `com_grade` VALUES ('140404049', '10000001', '18', '69', '29', '48', null);
INSERT INTO `com_grade` VALUES ('140404049', '10000002', '84', '93', '85', '59', null);
INSERT INTO `com_grade` VALUES ('140404049', '10000003', '50', '40', '58', '99', null);
INSERT INTO `com_grade` VALUES ('140404049', '10000004', '45', '43', '25', '92', null);
INSERT INTO `com_grade` VALUES ('140404049', '10000005', '39', '71', '58', '73', null);
INSERT INTO `com_grade` VALUES ('140404049', '10000006', '39', '13', '18', '30', null);
INSERT INTO `com_grade` VALUES ('140404049', '10000007', '80', '14', '26', '55', null);
INSERT INTO `com_grade` VALUES ('140405050', '10000000', '62', '79', '48', '79', null);
INSERT INTO `com_grade` VALUES ('140405050', '10000001', '24', '33', '80', '16', '24');
INSERT INTO `com_grade` VALUES ('140405050', '10000002', '95', '31', '50', '62', null);
INSERT INTO `com_grade` VALUES ('140405050', '10000003', '84', '11', '28', '82', null);
INSERT INTO `com_grade` VALUES ('140405050', '10000004', '15', '25', '78', '1', null);
INSERT INTO `com_grade` VALUES ('140405050', '10000005', '71', '16', '45', '31', null);
INSERT INTO `com_grade` VALUES ('140405050', '10000006', '40', '69', '30', '8', null);
INSERT INTO `com_grade` VALUES ('140405050', '10000007', '5', '92', '92', '89', null);
INSERT INTO `com_grade` VALUES ('140405051', '10000000', '83', '55', '37', '7', null);
INSERT INTO `com_grade` VALUES ('140405051', '10000001', '3', '18', '70', '58', '3');
INSERT INTO `com_grade` VALUES ('140405051', '10000002', '98', '53', '39', '24', null);
INSERT INTO `com_grade` VALUES ('140405051', '10000003', '56', '23', '32', '50', null);
INSERT INTO `com_grade` VALUES ('140405051', '10000004', '83', '99', '2', '93', null);
INSERT INTO `com_grade` VALUES ('140405051', '10000005', '62', '46', '51', '40', null);
INSERT INTO `com_grade` VALUES ('140405051', '10000006', '73', '71', '63', '98', null);
INSERT INTO `com_grade` VALUES ('140405051', '10000007', '31', '39', '24', '2', null);
INSERT INTO `com_grade` VALUES ('140405052', '10000000', '68', '0', '29', '22', null);
INSERT INTO `com_grade` VALUES ('140405052', '10000001', '77', '69', '72', '61', '77');
INSERT INTO `com_grade` VALUES ('140405052', '10000002', '16', '29', '86', '90', null);
INSERT INTO `com_grade` VALUES ('140405052', '10000003', '55', '25', '24', '13', null);
INSERT INTO `com_grade` VALUES ('140405052', '10000004', '83', '88', '67', '18', null);
INSERT INTO `com_grade` VALUES ('140405052', '10000005', '23', '67', '99', '43', null);
INSERT INTO `com_grade` VALUES ('140405052', '10000006', '66', '56', '75', '77', null);
INSERT INTO `com_grade` VALUES ('140405052', '10000007', '82', '78', '51', '41', null);
INSERT INTO `com_grade` VALUES ('140405053', '10000000', '25', '26', '97', '1', null);
INSERT INTO `com_grade` VALUES ('140405053', '10000001', '69', '66', '88', '48', '69');
INSERT INTO `com_grade` VALUES ('140405053', '10000002', '81', '81', '9', '57', null);
INSERT INTO `com_grade` VALUES ('140405053', '10000003', '54', '96', '6', '33', null);
INSERT INTO `com_grade` VALUES ('140405053', '10000004', '77', '77', '54', '88', null);
INSERT INTO `com_grade` VALUES ('140405053', '10000005', '37', '3', '87', '20', null);
INSERT INTO `com_grade` VALUES ('140405053', '10000006', '97', '98', '98', '77', null);
INSERT INTO `com_grade` VALUES ('140405053', '10000007', '15', '76', '57', '76', null);
INSERT INTO `com_grade` VALUES ('140405054', '10000000', '73', '98', '13', '62', null);
INSERT INTO `com_grade` VALUES ('140405054', '10000001', '43', '97', '40', '8', '44');
INSERT INTO `com_grade` VALUES ('140405054', '10000002', '28', '20', '85', '37', null);
INSERT INTO `com_grade` VALUES ('140405054', '10000003', '25', '38', '90', '28', null);
INSERT INTO `com_grade` VALUES ('140405054', '10000004', '71', '85', '98', '8', null);
INSERT INTO `com_grade` VALUES ('140405054', '10000005', '55', '79', '34', '90', null);
INSERT INTO `com_grade` VALUES ('140405054', '10000006', '84', '68', '21', '75', null);
INSERT INTO `com_grade` VALUES ('140405054', '10000007', '43', '49', '62', '59', null);
INSERT INTO `com_grade` VALUES ('140405055', '10000000', '40', '64', '9', '2', null);
INSERT INTO `com_grade` VALUES ('140405055', '10000001', '30', '67', '57', '54', '30');
INSERT INTO `com_grade` VALUES ('140405055', '10000002', '18', '87', '92', '27', null);
INSERT INTO `com_grade` VALUES ('140405055', '10000003', '34', '47', '2', '24', null);
INSERT INTO `com_grade` VALUES ('140405055', '10000004', '66', '49', '11', '31', null);
INSERT INTO `com_grade` VALUES ('140405055', '10000005', '24', '51', '93', '85', null);
INSERT INTO `com_grade` VALUES ('140405055', '10000006', '24', '32', '78', '60', null);
INSERT INTO `com_grade` VALUES ('140405055', '10000007', '30', '98', '6', '26', null);
INSERT INTO `com_grade` VALUES ('140405056', '10000000', '38', '13', '95', '90', null);
INSERT INTO `com_grade` VALUES ('140405056', '10000001', '80', '71', '91', '5', '80');
INSERT INTO `com_grade` VALUES ('140405056', '10000002', '93', '47', '13', '93', null);
INSERT INTO `com_grade` VALUES ('140405056', '10000003', '38', '24', '16', '13', null);
INSERT INTO `com_grade` VALUES ('140405056', '10000004', '71', '16', '87', '53', null);
INSERT INTO `com_grade` VALUES ('140405056', '10000005', '99', '8', '80', '82', null);
INSERT INTO `com_grade` VALUES ('140405056', '10000006', '9', '60', '99', '83', null);
INSERT INTO `com_grade` VALUES ('140405056', '10000007', '25', '97', '91', '24', null);
INSERT INTO `com_grade` VALUES ('140405057', '10000000', '85', '27', '86', '64', null);
INSERT INTO `com_grade` VALUES ('140405057', '10000001', '70', '15', '77', '88', '69');
INSERT INTO `com_grade` VALUES ('140405057', '10000002', '15', '46', '91', '38', null);
INSERT INTO `com_grade` VALUES ('140405057', '10000003', '28', '87', '65', '26', null);
INSERT INTO `com_grade` VALUES ('140405057', '10000004', '35', '91', '64', '78', null);
INSERT INTO `com_grade` VALUES ('140405057', '10000005', '63', '27', '4', '38', null);
INSERT INTO `com_grade` VALUES ('140405057', '10000006', '51', '10', '9', '4', null);
INSERT INTO `com_grade` VALUES ('140405057', '10000007', '52', '5', '28', '67', null);
INSERT INTO `com_grade` VALUES ('140405058', '10000000', '24', '93', '8', '2', null);
INSERT INTO `com_grade` VALUES ('140405058', '10000001', '30', '42', '58', '58', '30');
INSERT INTO `com_grade` VALUES ('140405058', '10000002', '17', '90', '9', '42', null);
INSERT INTO `com_grade` VALUES ('140405058', '10000003', '37', '7', '54', '24', null);
INSERT INTO `com_grade` VALUES ('140405058', '10000004', '66', '22', '38', '83', null);
INSERT INTO `com_grade` VALUES ('140405058', '10000005', '38', '30', '85', '8', null);
INSERT INTO `com_grade` VALUES ('140405058', '10000006', '79', '80', '94', '7', null);
INSERT INTO `com_grade` VALUES ('140405058', '10000007', '90', '91', '69', '73', null);
INSERT INTO `com_grade` VALUES ('140405059', '10000000', '26', '64', '79', '60', null);
INSERT INTO `com_grade` VALUES ('140405059', '10000001', '6', '83', '5', '9', '7');
INSERT INTO `com_grade` VALUES ('140405059', '10000002', '66', '42', '60', '83', null);
INSERT INTO `com_grade` VALUES ('140405059', '10000003', '69', '99', '68', '41', null);
INSERT INTO `com_grade` VALUES ('140405059', '10000004', '98', '71', '65', '37', null);
INSERT INTO `com_grade` VALUES ('140405059', '10000005', '83', '37', '92', '77', null);
INSERT INTO `com_grade` VALUES ('140405059', '10000006', '89', '83', '31', '53', null);
INSERT INTO `com_grade` VALUES ('140405059', '10000007', '11', '40', '24', '7', null);

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

-- ----------------------------
-- Records of com_manager
-- ----------------------------
INSERT INTO `com_manager` VALUES ('1', '20170520', 'f379eaf3c831b04de153469d1bec345e', 'yang', '2017-05-24 19:29:51', '127.0.0.1');
INSERT INTO `com_manager` VALUES ('2', '19950221', '363a0175d3d0ffe7c4b46d326360b71f', '杨徐越', null, null);

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
  CONSTRAINT `com_manager_l_role_fk1` FOREIGN KEY (`managerId`) REFERENCES `com_manager` (`id`) ON DELETE CASCADE,
  CONSTRAINT `com_manager_l_role_fk2` FOREIGN KEY (`roleId`) REFERENCES `com_role` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员与角色关联表';

-- ----------------------------
-- Records of com_manager_l_role
-- ----------------------------
INSERT INTO `com_manager_l_role` VALUES ('2', '1');
INSERT INTO `com_manager_l_role` VALUES ('1', '2');

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
-- Records of com_resource
-- ----------------------------
INSERT INTO `com_resource` VALUES ('1', 'admin', '超级管理员', 'shiro:sys:admin', '/manager/main/mainProxy');
INSERT INTO `com_resource` VALUES ('2', 'manager', '普通管理员', 'shiro:sys:manager', '/manager/main/mainProxy');
INSERT INTO `com_resource` VALUES ('3', 'teacher', '教师', 'shiro:sys:teacher', '/teacher/main/mainProxy');
INSERT INTO `com_resource` VALUES ('4', 'student', '学生', 'shiro:sys:student', '/student/main/mainProxy');

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
-- Records of com_role
-- ----------------------------
INSERT INTO `com_role` VALUES ('1', 'admin', '超级管理员');
INSERT INTO `com_role` VALUES ('2', 'manager', '普通管理员');
INSERT INTO `com_role` VALUES ('3', 'teacher', '教师');
INSERT INTO `com_role` VALUES ('4', 'student', '学生');

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
-- Records of com_role_l_resource
-- ----------------------------
INSERT INTO `com_role_l_resource` VALUES ('1', '1');
INSERT INTO `com_role_l_resource` VALUES ('1', '2');
INSERT INTO `com_role_l_resource` VALUES ('2', '2');
INSERT INTO `com_role_l_resource` VALUES ('3', '3');
INSERT INTO `com_role_l_resource` VALUES ('4', '4');

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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='单选题表';

-- ----------------------------
-- Records of com_single_question
-- ----------------------------
INSERT INTO `com_single_question` VALUES ('1', '10000000', '第一章', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `com_single_question` VALUES ('2', '10000000', '第二章', '2', '2', '2', '2', '2', '2', '2');
INSERT INTO `com_single_question` VALUES ('3', '10000000', '第三章', '3', '3', '3', '3', '3', '3', '3');
INSERT INTO `com_single_question` VALUES ('4', '10000000', '第四章', '4', '4', '4', '4', '4', '4', '4');
INSERT INTO `com_single_question` VALUES ('5', '10000000', '第五章', '5', '5', '5', '5', '5', '5', '5');
INSERT INTO `com_single_question` VALUES ('6', '10000000', '第六章', '6', '6', '6', '6', '6', '6', '6');
INSERT INTO `com_single_question` VALUES ('7', '10000000', '第七章', '7', '7', '7', '7', '7', '7', '7');
INSERT INTO `com_single_question` VALUES ('8', '10000001', '第一章', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO `com_single_question` VALUES ('9', '10000001', '第二章', '2', '2', '2', '2', '2', '2', '2');
INSERT INTO `com_single_question` VALUES ('10', '10000001', '第六章', '3', '3', '3', '3', '3', '3', '3');
INSERT INTO `com_single_question` VALUES ('11', '10000001', '第四章', '4', '4', '4', '4', '4', '4', '4');
INSERT INTO `com_single_question` VALUES ('12', '10000001', '第五章', '5', '5', '5', '5', '5', '5', '5');
INSERT INTO `com_single_question` VALUES ('13', '10000001', '第三章', '6', '6', '6', '6', '6', '6', '6');
INSERT INTO `com_single_question` VALUES ('15', '10000000', '第一章', '0', '123', '143', '213413', '534265', '32623', 'A');
INSERT INTO `com_single_question` VALUES ('16', '10000000', '第一章', '1', '2423453', '45426', '3456425', '153145', '13613', 'A');
INSERT INTO `com_single_question` VALUES ('17', '10000000', '第一章', '2', '235413253', '4253246', '45267', '43575', '674568', 'A');
INSERT INTO `com_single_question` VALUES ('18', '10000000', '第一章', '2', '235413253', '4253246', '45267', '43575', '674568', 'A');
INSERT INTO `com_single_question` VALUES ('19', '10000001', '第一章', '1', '345324563', '6246', '4257', '4357536', '7563486478', 'A');
INSERT INTO `com_single_question` VALUES ('20', '10000000', '第一章', '1', '214214231', '42135', '13245314', '65346', '45267245', 'A');
INSERT INTO `com_single_question` VALUES ('21', '10000000', '第六章', '1', '3453245324', '534264523', '64533', '7567', '6548678', 'A');
INSERT INTO `com_single_question` VALUES ('22', '10000000', '第四章', '3', '杨徐越', '5432453426', '53246456', '457', '54675467', 'A');

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
-- Records of com_student
-- ----------------------------
INSERT INTO `com_student` VALUES ('67', '140400000', '827ccb0eea8a706c4c34a16891f84e7b', '杨', '140400', '男', null, null);
INSERT INTO `com_student` VALUES ('68', '140400001', '827ccb0eea8a706c4c34a16891f84e7b', '徐', '140400', '男', null, null);
INSERT INTO `com_student` VALUES ('69', '140400002', '827ccb0eea8a706c4c34a16891f84e7b', '越', '140400', '男', null, null);
INSERT INTO `com_student` VALUES ('70', '140400003', '827ccb0eea8a706c4c34a16891f84e7b', '天才', '140400', '男', null, null);
INSERT INTO `com_student` VALUES ('71', '140400004', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140400', '男', null, null);
INSERT INTO `com_student` VALUES ('72', '140400005', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140400', '男', null, null);
INSERT INTO `com_student` VALUES ('73', '140400006', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140400', '男', null, null);
INSERT INTO `com_student` VALUES ('74', '140400007', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140400', '男', null, null);
INSERT INTO `com_student` VALUES ('75', '140400008', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140400', '男', null, null);
INSERT INTO `com_student` VALUES ('76', '140400009', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140400', '男', null, null);
INSERT INTO `com_student` VALUES ('77', '140401010', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140401', '男', null, null);
INSERT INTO `com_student` VALUES ('78', '140401011', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140401', '男', null, null);
INSERT INTO `com_student` VALUES ('79', '140401012', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140401', '男', null, null);
INSERT INTO `com_student` VALUES ('80', '140401013', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140401', '男', null, null);
INSERT INTO `com_student` VALUES ('81', '140401014', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140401', '男', null, null);
INSERT INTO `com_student` VALUES ('82', '140401015', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140401', '男', null, null);
INSERT INTO `com_student` VALUES ('83', '140401016', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140401', '男', null, null);
INSERT INTO `com_student` VALUES ('84', '140401017', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140401', '男', null, null);
INSERT INTO `com_student` VALUES ('85', '140401018', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140401', '男', null, null);
INSERT INTO `com_student` VALUES ('86', '140401019', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140401', '男', null, null);
INSERT INTO `com_student` VALUES ('87', '140402020', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140402', '男', null, null);
INSERT INTO `com_student` VALUES ('88', '140402021', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140402', '男', null, null);
INSERT INTO `com_student` VALUES ('89', '140402022', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140402', '男', null, null);
INSERT INTO `com_student` VALUES ('90', '140402023', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140402', '男', null, null);
INSERT INTO `com_student` VALUES ('91', '140402024', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140402', '男', null, null);
INSERT INTO `com_student` VALUES ('92', '140402025', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140402', '男', null, null);
INSERT INTO `com_student` VALUES ('93', '140402026', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140402', '男', null, null);
INSERT INTO `com_student` VALUES ('94', '140402027', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140402', '男', null, null);
INSERT INTO `com_student` VALUES ('95', '140402028', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140402', '男', null, null);
INSERT INTO `com_student` VALUES ('96', '140402029', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140402', '男', null, null);
INSERT INTO `com_student` VALUES ('97', '140403030', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140403', '男', null, null);
INSERT INTO `com_student` VALUES ('98', '140403031', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140403', '男', null, null);
INSERT INTO `com_student` VALUES ('99', '140403032', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140403', '男', null, null);
INSERT INTO `com_student` VALUES ('100', '140403033', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140403', '男', null, null);
INSERT INTO `com_student` VALUES ('101', '140403034', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140403', '男', null, null);
INSERT INTO `com_student` VALUES ('102', '140403035', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140403', '男', null, null);
INSERT INTO `com_student` VALUES ('103', '140403036', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140403', '男', null, null);
INSERT INTO `com_student` VALUES ('104', '140403037', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140403', '男', null, null);
INSERT INTO `com_student` VALUES ('105', '140403038', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140403', '男', null, null);
INSERT INTO `com_student` VALUES ('106', '140403039', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140403', '男', null, null);
INSERT INTO `com_student` VALUES ('107', '140404040', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140404', '男', null, null);
INSERT INTO `com_student` VALUES ('108', '140404041', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140404', '男', null, null);
INSERT INTO `com_student` VALUES ('109', '140404042', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140404', '男', null, null);
INSERT INTO `com_student` VALUES ('110', '140404043', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140404', '男', null, null);
INSERT INTO `com_student` VALUES ('111', '140404044', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140404', '男', null, null);
INSERT INTO `com_student` VALUES ('112', '140404045', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140404', '男', null, null);
INSERT INTO `com_student` VALUES ('113', '140404046', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140404', '男', null, null);
INSERT INTO `com_student` VALUES ('114', '140404047', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140404', '男', null, null);
INSERT INTO `com_student` VALUES ('115', '140404048', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140404', '男', null, null);
INSERT INTO `com_student` VALUES ('116', '140404049', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140404', '男', null, null);
INSERT INTO `com_student` VALUES ('117', '140405050', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140405', '男', null, null);
INSERT INTO `com_student` VALUES ('118', '140405051', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140405', '男', null, null);
INSERT INTO `com_student` VALUES ('119', '140405052', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140405', '男', null, null);
INSERT INTO `com_student` VALUES ('120', '140405053', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140405', '男', null, null);
INSERT INTO `com_student` VALUES ('121', '140405054', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140405', '男', null, null);
INSERT INTO `com_student` VALUES ('122', '140405055', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140405', '男', null, null);
INSERT INTO `com_student` VALUES ('123', '140405056', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140405', '男', null, null);
INSERT INTO `com_student` VALUES ('124', '140405057', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140405', '男', null, null);
INSERT INTO `com_student` VALUES ('125', '140405058', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140405', '男', null, null);
INSERT INTO `com_student` VALUES ('126', '140405059', '827ccb0eea8a706c4c34a16891f84e7b', '辽工学子', '140405', '男', null, null);

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
-- Records of com_student_l_another_question
-- ----------------------------
INSERT INTO `com_student_l_another_question` VALUES ('1', '140400000', '10000000', '112423515');
INSERT INTO `com_student_l_another_question` VALUES ('2', '140400001', '10000000', '14251353');
INSERT INTO `com_student_l_another_question` VALUES ('3', '140400002', '10000000', '2352364316');
INSERT INTO `com_student_l_another_question` VALUES ('4', '140400003', '10000000', '6265464');
INSERT INTO `com_student_l_another_question` VALUES ('5', '140400004', '10000000', '24624624');
INSERT INTO `com_student_l_another_question` VALUES ('6', '140401011', '10000001', '737437452');

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
-- Records of com_studnet_l_role
-- ----------------------------
INSERT INTO `com_studnet_l_role` VALUES ('140400000', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140400001', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140400002', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140400003', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140400004', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140400005', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140400006', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140400007', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140400008', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140400009', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140401010', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140401011', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140401012', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140401013', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140401014', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140401015', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140401016', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140401017', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140401018', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140401019', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140402020', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140402021', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140402022', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140402023', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140402024', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140402025', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140402026', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140402027', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140402028', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140402029', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140403030', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140403031', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140403032', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140403033', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140403034', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140403035', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140403036', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140403037', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140403038', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140403039', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140404040', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140404041', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140404042', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140404043', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140404044', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140404045', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140404046', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140404047', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140404048', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140404049', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140405050', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140405051', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140405052', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140405053', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140405054', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140405055', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140405056', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140405057', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140405058', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140405059', '4');

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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='教师表';

-- ----------------------------
-- Records of com_teacher
-- ----------------------------
INSERT INTO `com_teacher` VALUES ('18', '140400', '363a0175d3d0ffe7c4b46d326360b71f', 'yangxuyue', '', '', '北三', null, null);
INSERT INTO `com_teacher` VALUES ('19', '140401', '363a0175d3d0ffe7c4b46d326360b71f', 'yang', null, null, null, null, null);
INSERT INTO `com_teacher` VALUES ('20', '140402', '363a0175d3d0ffe7c4b46d326360b71f', '辽工教师', null, null, null, null, null);

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
-- Records of com_teacher_l_course
-- ----------------------------
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000000', '140400', '2017-08-22', '2017-08-31');
INSERT INTO `com_teacher_l_course` VALUES ('140400', '10000000', '140401', '2017-08-22', '2017-08-31');

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
  CONSTRAINT `com_user_l_role_fk1` FOREIGN KEY (`teacherId`) REFERENCES `com_teacher` (`id`) ON DELETE CASCADE,
  CONSTRAINT `com_user_l_role_fk2` FOREIGN KEY (`roleId`) REFERENCES `com_role` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='教师与角色关联表';

-- ----------------------------
-- Records of com_teacher_l_role
-- ----------------------------
INSERT INTO `com_teacher_l_role` VALUES ('18', '3');
INSERT INTO `com_teacher_l_role` VALUES ('19', '3');
INSERT INTO `com_teacher_l_role` VALUES ('20', '3');

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='判断题表';

-- ----------------------------
-- Records of com_tf_question
-- ----------------------------
INSERT INTO `com_tf_question` VALUES ('1', '10000000', '第一章', '1', '35324654236', '1');
INSERT INTO `com_tf_question` VALUES ('2', '10000000', '第一章', '1', '35324654236342624364265', '1');
INSERT INTO `com_tf_question` VALUES ('3', '10000000', '第一章', '1', '235324532', '1');
INSERT INTO `com_tf_question` VALUES ('4', '10000000', '第五章', '3', '4553', '1');
