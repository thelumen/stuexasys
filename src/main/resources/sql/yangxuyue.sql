/*
Navicat MySQL Data Transfer

Source Server         : mylove1621
Source Server Version : 50713
Source Host           : 127.0.0.1:3306
Source Database       : examination

Target Server Type    : MYSQL
Target Server Version : 50713
File Encoding         : 65001

Date: 2017-12-04 12:04:30
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='附加题表';

-- ----------------------------
-- Records of com_another_question
-- ----------------------------
INSERT INTO `com_another_question` VALUES ('1', '10000000', 'yangyangyang', 'yang');

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
  `chapterNum` int(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `com_course` (`courseId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='课程表';

-- ----------------------------
-- Records of com_course
-- ----------------------------
INSERT INTO `com_course` VALUES ('1', '10000000', '数据结构', '64', '4', '10');
INSERT INTO `com_course` VALUES ('2', '45678945', '数据结构（java版）', '32', '4', '12');

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
  `test` int(1) DEFAULT '0' COMMENT '是否可以测试，0不可，1可以',
  `started` int(1) DEFAULT '0' COMMENT '考试是否开启，0未开启，1开启',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='考试信息表';

-- ----------------------------
-- Records of com_examinfo
-- ----------------------------
INSERT INTO `com_examinfo` VALUES ('4', '120403', '160409', '10000000', '1,2,3,6', '2017-11-06', '0', '7,9', '2017-12-03', '1', null, null, '0', '2017-11-16', '0', '0', '1');
INSERT INTO `com_examinfo` VALUES ('5', '140403', '140402', '10000000', null, null, null, null, null, null, null, null, null, null, null, '1', '0');
INSERT INTO `com_examinfo` VALUES ('6', '140403', '140403', '10000000', '1,2,3', '2017-10-26', '1', null, null, '0', null, null, '0', null, '0', '1', '1');
INSERT INTO `com_examinfo` VALUES ('8', '140403', '140401', '10000000', '1', '2017-10-26', '1', null, null, '0', null, null, '0', null, '0', '1', '0');
INSERT INTO `com_examinfo` VALUES ('9', '100000', '140401', '10000000', null, null, null, null, null, null, null, null, null, null, null, '1', '0');

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
INSERT INTO `com_grade` VALUES ('140401049', '10000000', '60', '60', '60', '60', '68');
INSERT INTO `com_grade` VALUES ('140401050', '10000000', '60', '60', '60', '0', '48');
INSERT INTO `com_grade` VALUES ('140403001', '10000000', '8', null, null, null, null);
INSERT INTO `com_grade` VALUES ('140403002', '10000000', '36', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409001', '10000000', '64', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409002', '10000000', '68', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409003', '10000000', '36', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409004', '10000000', '72', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409005', '10000000', '72', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409006', '10000000', '60', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409007', '10000000', '68', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409008', '10000000', '88', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409009', '10000000', '52', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409010', '10000000', '76', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409011', '10000000', '76', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409012', '10000000', '80', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409013', '10000000', '76', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409014', '10000000', '48', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409015', '10000000', '48', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409016', '10000000', '28', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409017', '10000000', '28', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409018', '10000000', '72', '0', null, null, null);
INSERT INTO `com_grade` VALUES ('160409019', '10000000', '64', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409020', '10000000', '84', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409021', '10000000', '84', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409022', '10000000', '80', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409023', '10000000', '44', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409024', '10000000', '88', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409025', '10000000', '52', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409026', '10000000', '52', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409027', '10000000', '52', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409028', '10000000', '52', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409029', '10000000', '88', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409030', '10000000', '64', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409031', '10000000', '48', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409032', '10000000', '52', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409033', '10000000', '64', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409034', '10000000', '76', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409035', '10000000', '68', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409036', '10000000', '80', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409037', '10000000', '72', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409038', '10000000', '64', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409039', '10000000', '76', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409040', '10000000', '76', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409041', '10000000', '72', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409042', '10000000', '52', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409043', '10000000', '48', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409044', '10000000', '68', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409045', '10000000', '48', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409046', '10000000', '88', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409047', '10000000', '56', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409048', '10000000', '84', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409049', '10000000', '60', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409050', '10000000', '84', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409051', '10000000', '80', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409052', '10000000', '52', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409053', '10000000', '76', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409054', '10000000', '56', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409055', '10000000', '64', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409056', '10000000', '56', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409057', '10000000', '32', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409058', '10000000', '52', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409059', '10000000', '72', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409060', '10000000', '68', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409061', '10000000', '48', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409062', '10000000', '68', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409063', '10000000', '72', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409064', '10000000', '80', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409065', '10000000', '68', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409066', '10000000', '72', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409067', '10000000', '72', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409068', '10000000', '80', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409069', '10000000', '76', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409070', '10000000', '44', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409072', '10000000', '80', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409073', '10000000', '4', null, null, null, null);
INSERT INTO `com_grade` VALUES ('160409074', '10000000', '48', null, null, null, null);

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
INSERT INTO `com_manager` VALUES ('1', '20171001', '9d60dd298073b1e86bb41f66af3ccfea', 'Truth', '2017-05-24 19:29:51', '127.0.0.1');
INSERT INTO `com_manager` VALUES ('2', '20140901', '9d60dd298073b1e86bb41f66af3ccfea', 'Kind', null, null);

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
-- Records of com_manager_l_role
-- ----------------------------
INSERT INTO `com_manager_l_role` VALUES ('20140901', '1');
INSERT INTO `com_manager_l_role` VALUES ('20140901', '2');
INSERT INTO `com_manager_l_role` VALUES ('20171001', '2');
INSERT INTO `com_manager_l_role` VALUES ('20140901', '3');
INSERT INTO `com_manager_l_role` VALUES ('20140901', '4');

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
  `courseId` int(8) NOT NULL COMMENT '课程号',
  `section` varchar(50) NOT NULL COMMENT '章节名称',
  `levels` int(1) NOT NULL COMMENT '难度',
  `content` varchar(255) NOT NULL COMMENT '题目正文',
  `que1` varchar(255) NOT NULL COMMENT '选项A',
  `que2` varchar(255) NOT NULL COMMENT '选项B',
  `que3` varchar(255) NOT NULL COMMENT '选项C',
  `que4` varchar(255) NOT NULL COMMENT '选项D',
  `result` char(1) NOT NULL COMMENT '答案',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=478 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of com_single_question
-- ----------------------------
INSERT INTO `com_single_question` VALUES ('213', '10000000', '第十章', '3', '数据序列（8，9，10，4，5，6，20，1，2）只能是下列排序算法中的(   )的两趟排序后的结果。', '选择排序', '冒泡排序', '插入排序', '堆排序', 'C');
INSERT INTO `com_single_question` VALUES ('214', '10000000', '第十章', '3', '对序列{15，9，7，8，20，-1，4，} 用希尔排序方法排序，经一趟后序列变为{15，-l，4，8，20，9，7}则该次采用的增量是  (    ) 中', '1', '4', '3', '2', 'B');
INSERT INTO `com_single_question` VALUES ('215', '10000000', '第十章', '3', '用直接插入排序方法对下面四个序列进行排序（由小到大），元素比较次数最少的是（  ）。', ' 94,32,40,90,80,46,21,69', '32,40,21,46,69,94,90,80', '21,32,46,40,80,69,90,94', '90,69,80,46,21,32,94,40', 'C');
INSERT INTO `com_single_question` VALUES ('217', '10000000', '第十章', '2', '对一组数据（2，12，16，88，5，10）进行排序，若前三趟排序结果如下：第一趟：2，12，16，5，10，88 第二趟：2，12， 5，10，16，88 第三趟：2，5，10，12，16，88  则采用的排序方法可能是（       ）。', '起泡排序', '希尔排序 ', '归并排序', '基数排序', 'A');
INSERT INTO `com_single_question` VALUES ('218', '10000000', '第十章', '3', '数据序列（2，1，4，9，8，10，6，20）只能是下列排序算法中的(    )的两趟排序后的结果。', '快速排序', ' 冒泡排序', '选择排序', '插入排序', 'A');
INSERT INTO `com_single_question` VALUES ('219', '10000000', '第十章', '1', '若用冒泡排序方法对序列{10,14,26,29,41,52}从大到小排序，需进行 （  ）次比较。', '3', '10', '15', '25', 'C');
INSERT INTO `com_single_question` VALUES ('220', '10000000', '第十章', '2', '有一组数据（15，9，7，8，20，-1，7，4） 用快速排序的划分方法进行一趟划分后数据的排序为 (    )（按递增序）。', '下面的B，C，D都不对', '9，7，8，4，-1，7，15，20', '20，15，8，9，7，-1，4，7', '9，4，7，8，7，-1，15，20', 'A');
INSERT INTO `com_single_question` VALUES ('221', '10000000', '第十章', '3', '对下列关键字序列用快速排序法进行排序时，速度最快的情形是（　  ）。', '{21,25,5,17,9,23,30}', '{25,23,30,17,21,5,9}', '{21,9,17,30,25,23,5}', '{5,9,17,21,23,25,30}', 'A');
INSERT INTO `com_single_question` VALUES ('222', '10000000', '第十章', '1', '设一组初始关键字记录关键字为(20，15，14，18，21，36，40，10)，则以20为基准记录的一趟快 速排序结束后的结果为(   )。', '10，15，14，18，20，36，40，21', '10，15，14，18，20，40，36，21', '10，15，14，20，18，40，36，2l ', '15，10，14，18，20，36，40，21', 'A');
INSERT INTO `com_single_question` VALUES ('223', '10000000', '第十章', '1', '设一组初始记录关键字序列(5，2，6，3，8)，以第一个记录关键字5为基准进行一趟快速排序的结果 为（  ）。', '2，3，5，8，6 ', ' 3，2，5，8，6', '3，2，5，6，8', '2，3，6，5，8 ', 'C');
INSERT INTO `com_single_question` VALUES ('224', '10000000', '第十章', '1', '设一组初始记录关键字序列为(45，80，55，40，42，85)，则以第一个记录关键字45为基准而得到 一趟快速排序的结果是（  ）。', '40，42，45，55，80，83', '42，40，45，80，85，88', ' 42，40，45，55，80，85', '42，40，45，85，55，80', 'C');
INSERT INTO `com_single_question` VALUES ('225', '10000000', '第十章', '3', '设有10000个无序元素，希望用最快的速度挑选出其中前10个最大的元素，下面排序方法最好的是（    ）', '堆排序', '快速排序', '希尔排序', '二路归并排序', 'A');
INSERT INTO `com_single_question` VALUES ('226', '10000000', '第十章', '2', '采用简单选择排序，比较次数与移动次数分别为(    )。', 'O（n）,O(logn)', ' O(logn),0(n*n)', '0(n*n),0(n)', '0(nlogn),0(n)', 'C');
INSERT INTO `com_single_question` VALUES ('227', '10000000', '第十章', '2', '在含有n个关键字的小根堆（堆顶元素最小）中，关键字最大的记录有可能存储在（   ）位置上。', 'ën/2û', 'ën/2û -1 ', '1', 'ën/2û +2 ', 'D');
INSERT INTO `com_single_question` VALUES ('228', '10000000', '第十章', '2', '以下序列不是堆的是(   )。', '(100,85,98,77,80,60,82,40,20,10,66)', '(100,98,85,82,80,77,66,60,40,20,10)', '(10,20,40,60,66,77,80,82,85,98,100)', '(100,85,40,77,80,60,66,98,82,10,20)', 'D');
INSERT INTO `com_single_question` VALUES ('229', '10000000', '第十章', '1', '.堆排序平均执行的时间复杂度和需附加的存储空间复杂度分别是（     ）', 'O（n²）和O（1）', 'O（nlog₂n）和O（1）', 'O（nlog₂n）和O（n）', 'O（n²）和O（n）', 'B');
INSERT INTO `com_single_question` VALUES ('230', '10000000', '第十章', '3', '对n 个记录的文件进行堆排序，最坏情况下的执行时间是多少？（    ）', 'O（log₂n）', 'O（n）', 'O（nlog₂n）', '．O（n*n）', 'A');
INSERT INTO `com_single_question` VALUES ('231', '10000000', '第十章', '2', '设有n个待排序的记录关键字，则在堆排序中需要（ ）个辅助记录单元。', '1 ', 'n', ' nlog₂n', 'n²', 'A');
INSERT INTO `com_single_question` VALUES ('232', '10000000', '第十章', '3', '设有5000个待排序的记录关键字，如果需要用最快的方法选出其中最小的10个记录关键字，则用下 列（  ）方法可以达到此目的。', '快速排序', '堆排序', '归并排序', '插入排序', 'B');
INSERT INTO `com_single_question` VALUES ('233', '10000000', '第十章', '2', '设一组初始记录关键字序列为(50，40，95，20，15，70，60，45)，则以增量d=4的一趟希尔排序 结束后前4条记录关键字为（   ）。', ' 40，15，20，95', ' 40，50，20，95', '15，20，40，45 ', '45，40，15，20', 'B');
INSERT INTO `com_single_question` VALUES ('234', '10000000', '第十章', '2', '关键字序列（90，85，65，56，288，178，99，280），当执行2路归并排序方法，则第一趟排序结束时的关键字状态为（  ）。中', '85，90，56，65，178， 288， 99，280', '56，85，65，90，288，178，99，280', '85，90，65，56，288，178，99，280', '56，90，85， 65，178，280，99，288', 'A');
INSERT INTO `com_single_question` VALUES ('235', '10000000', '第十章', '2', '若要求尽可能快地对序列进行稳定的排序，则应选（ ）', '快速排序', '归并排序', '冒泡排序', '插入排序', 'B');
INSERT INTO `com_single_question` VALUES ('236', '10000000', '第十章', '1', '在排序算法中，每次从未排序的记录中挑出最小（或最大）关键码字的记录，加入到已排序记录的末尾，该排序方法是（    ）。', '选择', '冒泡', '插入', '堆', 'A');
INSERT INTO `com_single_question` VALUES ('237', '10000000', '第十章', '3', '将两个各有N个元素的有序表归并成一个有序表,其最少的比较次数是(    )', 'N', '2N-1', '2N', 'N-1', 'A');
INSERT INTO `com_single_question` VALUES ('238', '10000000', '第十章', '3', '下列四种排序中（  ）的空间复杂度最大。', '插入排序', '冒泡排序', '堆排序', '归并排序', 'D');
INSERT INTO `com_single_question` VALUES ('239', '10000000', '第十章', '2', '设一组初始记录关键字序列为(25，50，15，35，80，85，20，40，36，70)，其中含有5个长度为 2的有序子表，则用归并排序的方法对该记录关键字序列进行一趟归并后的结果为（   ）。', '15，25，35，50，20，40，80，85，36，70 ', '15，25，35，50，80，20，85，40，70，36', ' 15，25，35，50，80，85，20，36，40，70', '15，25，35，50，80，20，36，40，70，85', 'A');
INSERT INTO `com_single_question` VALUES ('240', '10000000', '第十章', '1', '在下列排序方法中，哪组均是不稳定的？（  ）', '直接插入排序和希尔排序', '堆排序和快速排序', '冒泡排序和简单选择排序', '冒泡排序和简单选择排序', 'B');
INSERT INTO `com_single_question` VALUES ('241', '10000000', '第十章', '1', '下列排序算法中，稳定的排序方法是(   )', '堆排序', '直接插入排序', '希尔排序', '快速排序', 'B');
INSERT INTO `com_single_question` VALUES ('242', '10000000', '第十章', '1', '下面给出的四种排序法中(    )排序法是不稳定性排序法。', '插入', '冒泡', '二路归并', '堆积', 'D');
INSERT INTO `com_single_question` VALUES ('243', '10000000', '第十章', '1', '．下列排序算法中，其中（    ）是稳定的', ' 堆排序，冒泡排序', '快速排序，堆排序', '直接选择排序，归并排序', '归并排序，冒泡排序', 'D');
INSERT INTO `com_single_question` VALUES ('244', '10000000', '第十章', '1', '稳定的排序方法是（    ）', '直接插入排序和快速排序', '折半插入排序和起泡排序', '简单选择排序和四路归并排序', '树形选择排序和shell排序', 'B');
INSERT INTO `com_single_question` VALUES ('245', '10000000', '第十章', '1', '下列排序方法中，哪一个是稳定的排序方法？（  　）', '直接选择排序', '二分法插入排序', '希尔排序', '快速排序', 'B');
INSERT INTO `com_single_question` VALUES ('246', '10000000', '第十章', '1', '如果待排序序列中两个数据元素具有相同的值，在排序前后它们的相互位置发生颠倒，则称该排序算法是不稳定的。（   ）就是不稳定的排序方法。', '起泡排序', '归并排序', 'Shell排序', '直接插入排序', 'C');
INSERT INTO `com_single_question` VALUES ('247', '10000000', '第十章', '3', '下面给出的四种排序方法中，排序过程中的比较次数与排序方法无关的是。(   )', '选择排序法', '插入排序法', '快速排序法', '堆积排序法', 'A');
INSERT INTO `com_single_question` VALUES ('248', '10000000', '第十章', '3', '在下列排序算法中,哪一个算法的时间复杂度与初始排序无关（  ）。', '直接插入排序', '气泡排序', ' 快速排序', '直接选择排序', 'D');
INSERT INTO `com_single_question` VALUES ('249', '10000000', '第十章', '3', '对一组数据（84，47，25，15，21）排序，数据的排列次序在排序的过程中的变化为（1） 84 47 25 15 21  （2） 15 47 25 84 21  （3） 15 21 25 84 47  （4） 15 21 25 47 84则采用的排序是 (    )', '选择', '冒泡', '快速', '插入', 'A');
INSERT INTO `com_single_question` VALUES ('250', '10000000', '第十章', '3', '下列排序算法中(   )不能保证每趟排序至少能将一个元素放到其最终的位置上。', '快速排序', 'shell排序 ', '堆排序', '冒泡排序', 'B');
INSERT INTO `com_single_question` VALUES ('251', '10000000', '第十章', '3', '下列排序算法中(   )排序在一趟结束后不一定能选出一个元素放在其最终位置上。', '选择', '冒泡', '归并', '堆', 'C');
INSERT INTO `com_single_question` VALUES ('252', '10000000', '第十章', '3', ' 在下面的排序方法中，辅助空间为O（n）的是(   ) 。', '希尔排序', '堆排序', '选择排序', '归并排序', 'D');
INSERT INTO `com_single_question` VALUES ('274', '10000000', '第六章', '3', '如果结点A是结点B的双亲，而且结点B有4个兄弟，则结点A的度是（）', '2', '3', '4', '5', 'D');
INSERT INTO `com_single_question` VALUES ('275', '10000000', '第六章', '2', '设某数据结构的二元组形式表示为A=(D，R)，D={01，02，03，04，05，06，07，08，09}，R={r}， r={<01，02>，<01，03>，<01，04>，<02，05>，<02，06>，<03，07>，<03，08>，<03，09>}，则数据结构A是', '线性结构 ', '树型结构', '物理结构', '图型结构', 'B');
INSERT INTO `com_single_question` VALUES ('276', '10000000', '第六章', '2', '树最适合用来表示', '有序数据元素', '无序数据元素', '元素之间具有分支层次关系的数据 ', '元素之间无联系的数据', 'C');
INSERT INTO `com_single_question` VALUES ('277', '10000000', '第六章', '3', '一棵度为3的树有2个度为1的结点，3个度为2的结点，4个度为3的结点，则该树有（      ）个叶子结点。', '10', '12', '13', '15', 'B');
INSERT INTO `com_single_question` VALUES ('278', '10000000', '第六章', '3', '一棵满K叉树，其非叶子结点数为N1，则叶子结点数N0为 （       ）', 'KN1', 'KN1+1', '（K-1）N1', '（K-1）N1+1', 'D');
INSERT INTO `com_single_question` VALUES ('281', '10000000', '第六章', '1', '将一棵有20个结点的完全二叉树从根这一层开始，每一层上从左到右依次对结点进行编号，根结点的编号为1，则编号为13的结点的双亲编号为', '6', '7', '8', '9', 'A');
INSERT INTO `com_single_question` VALUES ('282', '10000000', '第六章', '2', '已知二叉树有两个叶子结点，两个度为1的结点，则该树中共有 (        )个结点。', '4', '5', '6', '7', 'D');
INSERT INTO `com_single_question` VALUES ('284', '10000000', '第六章', '1', '将一棵有20个结点的完全二叉树从根这一层开始，每一层上从左到右依次对结点进行编号，根结点的编号为1，则编号为12的结点的左孩子编号为(         )', '24', '25', '26', '28', 'A');
INSERT INTO `com_single_question` VALUES ('286', '10000000', '第六章', '1', '将一棵有24个结点的完全二叉树从根这一层开始，每一层上从左到右依次对结点进行编号，根结点的编号为1，则编号为11的结点的左孩子编号为(       )。', '21', '22', '23', '24', 'B');
INSERT INTO `com_single_question` VALUES ('292', '10000000', '第六章', '1', '深度为5的二叉树上结点数最多为(       )个。', '31', '16', '15', '32', 'A');
INSERT INTO `com_single_question` VALUES ('293', '10000000', '第六章', '1', '深度为6的二叉树上结点数最多为（）个。', '63', '64', '31', '32', 'A');
INSERT INTO `com_single_question` VALUES ('296', '10000000', '第六章', '1', '深度为4的二叉树上结点数最多为（）个。', '15', '16', '31', '32', 'A');
INSERT INTO `com_single_question` VALUES ('298', '10000000', '第六章', '2', '假定在一棵二叉树中，度为2的结点数为15个，度为1的结点数为31个，则叶子结点数为（     ）个。', '15', '16', '17', '47', 'B');
INSERT INTO `com_single_question` VALUES ('300', '10000000', '第六章', '1', '将一棵有30个结点的完全二叉树从根这一层开始，每一层上从左到右依次对结点进行编号，根结点的编号为1，则编号为12的结点的右孩子编号为（）。', '30', '25', '31', '24', 'B');
INSERT INTO `com_single_question` VALUES ('301', '10000000', '第六章', '1', '将一棵有100个结点的完全二叉树从根这一层开始，每一层上从左到右依次对结点进行编号，根结点的编号为1，则编号为49的结点的左孩子编号为（）。', '98', '99', '50', '48', 'A');
INSERT INTO `com_single_question` VALUES ('302', '10000000', '第六章', '2', '设某棵二叉树中有2000个结点，则该二叉树的最小高度为（      ）。', '9', '10', '11', '12', 'C');
INSERT INTO `com_single_question` VALUES ('306', '10000000', '第六章', '1', '二叉树的第6层的结点数最多为(       ).     ', '31', '63', '32', '64', 'C');
INSERT INTO `com_single_question` VALUES ('307', '10000000', '第九章', '2', '若有18个元素的有序表存放在一维数组A[19]中，第一个元素放A[1]中，现进行二分查找，则 查找A［3］的比较序列的下标依次为(        )   ', '1，2，3 ', ' 9，5，2，3', '9，5，3', '9，4，2，3', 'D');
INSERT INTO `com_single_question` VALUES ('309', '10000000', '第六章', '1', '设某二叉树中度数为0的结点数为N0，度数为1的结点数为Nl，度数为2的结点数为N2，则下列等 式成立的是（      ）。 ', 'N0=N1+1 ', 'N0=Nl+N2 ', 'N0=N2+1', ' N0=2N1+l', 'C');
INSERT INTO `com_single_question` VALUES ('311', '10000000', '第六章', '3', '设一棵m叉树中度数为0的结点数为N0，度数为1的结点数为Nl，……，度数为m的结点数为Nm， 则N0=（     ）。 ', 'Nl+N2+……+Nm', 'l+N2+2N3+3N4+……+(m-1)Nm', 'N2+2N3+3N4+……+(m-1)Nm', '2Nl+3N2+……+(m+1)Nm ', 'B');
INSERT INTO `com_single_question` VALUES ('315', '10000000', '第六章', '3', '已知二叉树的先序序列为ABDECF，中序序列为DBEAFC，则后序序列为(）', 'DEBAFC', 'DEFBCA', 'DEBCFA ', 'DEBFCA', 'D');
INSERT INTO `com_single_question` VALUES ('316', '10000000', '第六章', '3', '若一棵二叉树的先序和后序遍历序列相反，则该二叉树一定满足：(          )。', '左单支树', '树的高度等于结点数', '右单支树', '都不对', 'B');
INSERT INTO `com_single_question` VALUES ('318', '10000000', '第六章', '2', '设某棵二叉树的中序遍历序列为ABCD，前序遍历序列为CABD，则后序遍历该二叉树得到序列为（）', 'BADC', 'BCDA', 'CDAB', 'CBDA', 'A');
INSERT INTO `com_single_question` VALUES ('321', '10000000', '第六章', '3', '表达式a*(b+c)-d 的后缀表达式是(        )。', 'abcd*+-', 'abc+*d- ', 'abc*+d- ', '-+*abcd', 'B');
INSERT INTO `com_single_question` VALUES ('323', '10000000', '第六章', '2', '设哈夫曼树中的叶子结点总数为m，若用二叉链表作为存储结构，则该哈夫曼树中总共有（ ）个空 指针域。', '2m-1', '2m', '2m+1', '4m', 'B');
INSERT INTO `com_single_question` VALUES ('325', '10000000', '第一章', '1', '下列说法不正确的是（）。', '数据元素是数据的基本单位', '数据项是数据中不可分的最小单位', '数据可由若干个数据元素构成  ', '数据项可由若干个数据元素构成', 'D');
INSERT INTO `com_single_question` VALUES ('326', '10000000', '第九章', '2', '下面程序的时间复杂为（）中   for（i=1，s=0； i<=n； i++）  {t=1；for(j=1；j<=i；j++) t=t*j；s=s+t；} ', 'O(n) ', 'O(n*n)', 'O（n*n*n）', 'O（n*n*n*n）', 'B');
INSERT INTO `com_single_question` VALUES ('327', '10000000', '第一章', '1', '以下数据结构中哪一个是非线性结构？（）', '队列', '栈', '线性表', '二叉树', 'D');
INSERT INTO `com_single_question` VALUES ('328', '10000000', '第九章', '3', '设一维数组中有n个数组元素，则读取第i个数组元素的平均时间复杂度为（）。', 'O(n)', ' O(nlog2n)', 'O(1)', ' O(n*n)', 'C');
INSERT INTO `com_single_question` VALUES ('329', '10000000', '第一章', '1', '数据的最小单位是（）。', '数据项', '数据类型', '数据元素', '数据变量', 'A');
INSERT INTO `com_single_question` VALUES ('330', '10000000', '第九章', '3', '算法的时间复杂度取决于（）。', '问题的规模', '待处理数据的初态', 'A 和B ', '程序设计的语言', 'C');
INSERT INTO `com_single_question` VALUES ('331', '10000000', '第一章', '2', '从逻辑上可以把数据结构分为（ ）两大类。', '动态结构、静态结构', '顺序结构、链式结构', '线性结构、非线性结构', '初等结构、构造型结构', 'C');
INSERT INTO `com_single_question` VALUES ('332', '10000000', '第九章', '2', '在下面的程序段中，对x 的赋值语句的频度为（ ）中 FOR i:=1 TO n DO FOR j:=1 TO n DO x:=x+1;', 'O(2n)', 'O(n) ', 'O(n*n）', 'O(log2n)', 'C');
INSERT INTO `com_single_question` VALUES ('333', '10000000', '第一章', '2', '以下数据结构中，（ ）是非线性数据结构.', '树', '字符串', '队', '栈', 'C');
INSERT INTO `com_single_question` VALUES ('334', '10000000', '第一章', '2', '下列数据中，（ ）是非线性数据结构。', '栈', '队列', '完全二叉树', '线性表', 'C');
INSERT INTO `com_single_question` VALUES ('335', '10000000', '第九章', '3', '以下属于逻辑结构的是（）。', '顺序表', '哈希表', '有序表', '单链表', 'C');
INSERT INTO `com_single_question` VALUES ('338', '10000000', '第二章', '1', '下面关于线性表的叙述错误的是（）。', '线性表采用顺序存储必须占用一片连续的存储空间', '线性表采用链式存储不必占用一片连续的存储空间 ', '线性表采用链式存储便于插入和删除操作的实现 ', '线性表采用顺序存储便于插入和删除操作的实现  ', 'D');
INSERT INTO `com_single_question` VALUES ('339', '10000000', '第九章', '3', '具有12个关键字的有序表，折半查找的平均查找长度（    ）。', ' 3.1     ', '4', '2.5', '5', 'A');
INSERT INTO `com_single_question` VALUES ('340', '10000000', '第四章', '2', '函数substr(“DATASTRUCTURE”，5，9)的返回值为（）。', '“STRUCTURE”', ' “DATA” ', '“ASTRUCTUR” ', '“DATASTRUCTURE”  ', 'A');
INSERT INTO `com_single_question` VALUES ('341', '10000000', '第二章', '2', '表长为n的顺序存储的线性表，当在任何位置上删除一个元素的概率相等时，删除一个元素所需移动元素的平均个数是（）。', 'n', 'n/2', '(n-1)/2', '(n+1)/2', 'C');
INSERT INTO `com_single_question` VALUES ('343', '10000000', '第九章', '3', '若长度为n的线性表采用顺序存储结构，在删除第i个位置的元素的算法的时间复杂度为（   ）(1<=i<=n)。', 'O(0)  ', ' O(1)  ', 'O(n) ', 'O(n*n) ', 'C');
INSERT INTO `com_single_question` VALUES ('345', '10000000', '第九章', '2', '在顺序表（8,11,15,19,25,26,30,33,42,48,50）中，用折半查找法查找关键码值20，需做的关键码比较次数为（ ）。', '3', '4', '5', '6', 'B');
INSERT INTO `com_single_question` VALUES ('346', '10000000', '第二章', '1', '下述哪一条是顺序存储结构的优点？( )', '存储密度大 ', '插入运算方便 ', '删除运算方便', '可方便地用于各种逻辑结构的存储表示', 'A');
INSERT INTO `com_single_question` VALUES ('349', '10000000', '第二章', '1', '线性表是具有n 个（ ）的有限序列（n>0）。', '表元素', '字符', '数据元素', '数据项', 'C');
INSERT INTO `com_single_question` VALUES ('350', '10000000', '第九章', '1', '对长度为n的查找表进行顺序查找，其平均查找长度为（     ）。', '( n+1)/2 ', ' ( n-1)/2 ', 'n/2', '以上答案都不对', 'A');
INSERT INTO `com_single_question` VALUES ('352', '10000000', '第二章', '2', '若某线性表最常用的操作是存取任一指定序号的元素和在最后进行插入和删除运算，则利用（ ）存储方式最节省时间。', '顺序表', '双链表', '带头结点的双循环链表 ', '单循环链表', 'A');
INSERT INTO `com_single_question` VALUES ('353', '10000000', '第九章', '2', '对一个有序表（2,6,8,10,16,17,19,26）进行折半查找，当查找关键字为19的记录时，经（   ）次比较查找成功。', '1', '2', '3', '4', 'C');
INSERT INTO `com_single_question` VALUES ('354', '10000000', '第九章', '3', '若长度为n 的线性表采用顺序存储结构，在其第i 个位置插入一个新元素的算法的时间复杂度为（ ）(1<=i<=n+1)。', ' O(0)', 'O(1)', ' O(n)', 'O(n*n)', 'C');
INSERT INTO `com_single_question` VALUES ('356', '10000000', '第九章', '2', '设有100个结点的有序表折半查找时，最大比较次数为（ ）次。', '25', '50', '10', '7', 'D');
INSERT INTO `com_single_question` VALUES ('358', '10000000', '第九章', '3', '对一个长度20的有序表进行折半查找，则等概率下查找成功时的平均查找长度为（）', '31/10 ', '35/10    ', '37/10    ', '65/20', 'C');
INSERT INTO `com_single_question` VALUES ('360', '10000000', '第二章', '3', '设线性表中有2n个元素，以下操作中，在单链表上实现要比在顺序表上实现效率更高的是（）。', '删除指定元素 ', '在最后一个元素的后面插入一个新元素', '顺序输出前K个元素', '交换第i个元素和2n-1-i个元素', 'A');
INSERT INTO `com_single_question` VALUES ('361', '10000000', '第九章', '2', '对一个有序表（2,6,8,12,16,18,20,24）进行折半查找，当查找关键字为20的记录时，经（  ）次比较查找成功。', '1', '2', '3', '4', 'C');
INSERT INTO `com_single_question` VALUES ('362', '10000000', '第二章', '2', '链表不具有的特点是（）。', '随机访问任一元素', '插入删除不需要移动元素', '不必事先估计存储空间', '所需空间与线性表长度成正比', 'A');
INSERT INTO `com_single_question` VALUES ('364', '10000000', '第二章', '2', '在单链表中，指针p指向元素为x的结点，实现“删除x的后继”的语句是（）。', 'p=p->next; ', 'p->next=p->next->next; ', 'p->next=p;   ', 'p=p->next->next;', 'B');
INSERT INTO `com_single_question` VALUES ('365', '10000000', '第九章', '1', '.若查找每个记录的概率均等，则在具有n个记录的连续顺序文件中采用顺序查找法查找一个记录，其平均查找长度ASL为(    )。', '(n-1)/2 ', ' n/2', '(n+1)/2      ', 'n', 'C');
INSERT INTO `com_single_question` VALUES ('366', '10000000', '第二章', '1', '线性表采用链式存储时，结点的存储地址（）。', '必须是不连续的', '连续与否均可', '必须是连续的 ', '和头结点的存储地址相连续', 'B');
INSERT INTO `com_single_question` VALUES ('368', '10000000', '第二章', '2', '带头结点的单链表其头指针为head，该单链表为空的判定条件为（）。', 'head==NULL	', 'head->next==NULL', 'head->next== head  ', 'head->next!=NULL', 'B');
INSERT INTO `com_single_question` VALUES ('369', '10000000', '第二章', '3', '设指针变量p指向单链表中结点A，若删除单链表中结点A，则需要修改指针的操作序列为（）。', 'q=p->next；p->data=q->data；p->next=q->next；free(q)；', 'q=p->next；q->data=p->data；p->next=q->next；free(q)', ' q=p->next；p->next=q->next；free(q)；', ' q=p->next；p->data=q->data；free(q)；', 'A');
INSERT INTO `com_single_question` VALUES ('370', '10000000', '第九章', '2', ' 下面关于二分查找的叙述正确的是  (    ) ', '表必须有序，表可以顺序方式存储，也可以链表方式存储 ', '表必须有序且表中数据必须是整型，实型或字符型     ', '表必须有序，而且只能从小到大排列', '表必须有序，且表只能以顺序方式存储', 'D');
INSERT INTO `com_single_question` VALUES ('372', '10000000', '第九章', '2', '设一个有序的单链表中有n个结点，现要求插入一个新结点后使得单链表仍然保持有序，则该操作的 时间复杂度为（）。', 'O(log2n)', 'O(1)  ', ' O(n*n)', 'O(n) ', 'D');
INSERT INTO `com_single_question` VALUES ('373', '10000000', '第二章', '3', '某线性表中最常用的操作是在最后一个元素之后插入一个元素和删除第一个元素，则采用（ ）存储方式最节省运算时间。', '单链表', '仅有头指针的单循环链表', '双链表', '仅有尾指针的单循环链表', 'D');
INSERT INTO `com_single_question` VALUES ('375', '10000000', '第九章', '2', ' 用二分（折半）查找表的元素的速度比用顺序法(   ) ', '  必然快   ', ' 必然慢      ', '相等', '不能确定', 'D');
INSERT INTO `com_single_question` VALUES ('377', '10000000', '第九章', '2', '线性表（ a1,a2,…,an）以链接方式存储时，访问第i 位置元素的时间复杂性为（）', 'O（i）', 'O（1）', 'O（n）', 'O（i-1）', 'C');
INSERT INTO `com_single_question` VALUES ('378', '10000000', '第九章', '3', '当在一个有序的顺序存储表上查找一个数据时，既可用折半查找，也可用顺序查找，但前者比后者的查找速度(    )', '必定快    ', '不一定   ', '在大部分情况下要快', '取决于表递增还是递减', 'C');
INSERT INTO `com_single_question` VALUES ('379', '10000000', '第九章', '2', ' 具有12个关键字的有序表，折半查找的平均查找长度（ ）', '3.1', '4', '2.5', '5', 'A');
INSERT INTO `com_single_question` VALUES ('380', '10000000', '第二章', '2', '循环链表H 的尾结点P 的特点是（）。', 'P^.NEXT:=H ', 'P^.NEXT:= H^.NEXT ', 'P:=H ', 'P:=H^.NEXT', 'A');
INSERT INTO `com_single_question` VALUES ('381', '10000000', '第二章', '2', '在一个以 h 为头的单循环链中，p 指针指向链尾的条件是（）。', 'p＾.next=h ', 'p＾.next=NIL ', 'p＾.next.＾next=h', 'p＾.data=-1', 'A');
INSERT INTO `com_single_question` VALUES ('382', '10000000', '第二章', '3', '完成在双循环链表结点p 之后插入s 的操作是（）。', 'p^.next:=s ; s^.priou:=p; p^.next^.priou:=s ; s^.next:=p^.next;', 'p^.next^.priou:=s; p^.next:=s; s^.priou:=p; s^.next:=p^.next;', 's^.priou:=p; s^.next:=p^.next; p^.next:=s; p^.next^.priou:=s ;', ' s^.priou:=p; s^.next:=p^.next; p^.next^.priou:=s ; p^.next:=s;', 'D');
INSERT INTO `com_single_question` VALUES ('383', '10000000', '第九章', '1', '要进行顺序查找，则线性表（）；', '必须以顺序方式存储', '必须以链式方式存储；', '既可以以顺序方式存储，也可以链式方式存储；', '必须以顺序方式存储，且数据已按递增或递减顺序排好；', 'C');
INSERT INTO `com_single_question` VALUES ('385', '10000000', '第二章', '3', '在单链表指针为p 的结点之后插入指针为s 的结点，正确的操作是：（）', 'p->next=s;s->next=p->next;', 's->next=p->next;p->next=s;', 'p->next=s;p->next=s->next;', 'p->next=s->next;p->next=s;', 'B');
INSERT INTO `com_single_question` VALUES ('387', '10000000', '第九章', '2', '要进行折半查询，则线性表（）；', '必须以顺序方式存储， 数据有序无序均可', '必须以链式方式存储；', ' 既可以以顺序方式存储，也可以链式方式存储；', '必须以顺序方式存储，且数据已按递增或递减顺序排好；', 'D');
INSERT INTO `com_single_question` VALUES ('388', '10000000', '第九章', '1', '若表中元素个数为n,则顺序查找的平均比较次数为（）；', ' n/2   ', '(n+1)/2', 'nlog2n    ', ' log2(n+1)', 'B');
INSERT INTO `com_single_question` VALUES ('390', '10000000', '第九章', '1', '折半查找的平均比较次数为（）。 ', 'n/2  ', '(n+1)/2 ', 'nlog2n    ', '  log2(n+1)', 'D');
INSERT INTO `com_single_question` VALUES ('398', '10000000', '第九章', '3', ' 二叉查找树在 ()时其查找效率最低', '结点太多   ', '完全二叉树', ' 呈单枝树', '结点太复杂。', 'C');
INSERT INTO `com_single_question` VALUES ('404', '10000000', '第九章', '2', '设二叉排序树中有n个结点，则在二叉排序树的平均平均查找长度为（  ）。 ', ' O(1)', ' O(log2n) ', 'O(n)', 'O(n*n)', 'B');
INSERT INTO `com_single_question` VALUES ('405', '10000000', '第九章', '2', '设有序表中有1000个元素，则用二分查找查找元素X最多需要比较（ ）次。', '25', '10', '7', '1', 'B');
INSERT INTO `com_single_question` VALUES ('406', '10000000', '第九章', '3', '假定有k个关键字互为同义词，若用线性探测法把这k个关键字存入散列表中，至少要进行多少次探测？(    )   ', 'k-1次   ', 'k次   ', 'k+1次', 'k（k+1）/2次', 'D');
INSERT INTO `com_single_question` VALUES ('407', '10000000', '第九章', '2', ' 设有一组记录的关键字为{19，14，23，1，68，20，84，27，55，11，10，79}，用链地址法构造散列表，散列函数为H（key）=key %13 ,散列地址为1的链中有（ ）个记录。', '1', '2', '3', '4', 'D');
INSERT INTO `com_single_question` VALUES ('408', '10000000', '第九章', '2', ' 若采用链地址法构造散列表，散列函数为H（key）=key % 17，则需 () 个链表。', '17', '13', '16', '任意', 'A');
INSERT INTO `com_single_question` VALUES ('409', '10000000', '第九章', '2', '若采用链地址法构造散列表，散列函数为H（key）=key % 17，这些链的链首指针构成一个指针数组，数组的下标范围为 () ', '0至17       ', '1至17       ', '0至16       ', '1至16  ', 'C');
INSERT INTO `com_single_question` VALUES ('410', '10000000', '第九章', '2', ' 散列表的地址区间为0-17,散列函数为H(K)=K %17。采用线性探测法处理冲突，并将关键字序列26，25，72，38，8，18，59依次存储到散列表中，元素59存放在散列表中的地址是（  ）。', '8        ', '9', '10', '11', 'D');
INSERT INTO `com_single_question` VALUES ('411', '10000000', '第九章', '2', ' 散列表的地址区间为0-17,散列函数为H(K)=K % 17。采用线性探测法处理冲突，并将关键字序列26，25，72，38，8，18，59依次存储到散列表中，散列表的地址区间为0-17,查找元素59需要搜索的次数是（   ）。', '2', '3', '4', '5', 'C');
INSERT INTO `com_single_question` VALUES ('412', '10000000', '第九章', '3', ' 将10个元素散列到100000个单元的哈希表中，则（  ）产生冲突。', ' 一定会       ', '一定不会    ', '仍可能会', '以上答案都不对', 'C');
INSERT INTO `com_single_question` VALUES ('413', '10000000', '第九章', '2', '若结点的存储地址与其关键字间存在映射关系，则这种存储结构为(    )。', '顺序存储结构 ', '链式存储结构', '哈希散列存储结构  ', '索引存储结构', 'C');
INSERT INTO `com_single_question` VALUES ('414', '10000000', '第九章', '2', ' 对于线性表（7，34，55，25，64，46，20，10）进行散列存储时，若选用H（K）=K %9作 为散列函数，则散列地址为1的元素有（）个。        ', '1', '2', '3', '4', 'D');
INSERT INTO `com_single_question` VALUES ('415', '10000000', '第三章', '1', '下列关于栈叙述正确的是 ', '栈顶元素最先被删除', '栈顶元素最后被删除', '栈顶元素永远不能被删除	', '以上三种说法都不对', 'A');
INSERT INTO `com_single_question` VALUES ('416', '10000000', '第三章', '2', '设用链表作为栈的存储结构则退栈操作', ' 必须判别栈是否为满', '必须判别栈是否为空', '判别栈元素的类型', '对栈不作任何判别', 'B');
INSERT INTO `com_single_question` VALUES ('417', '10000000', '第三章', '3', '设输入序列是1、2、3、……、n，经过栈的作用后输出序列的第一个元素是n，则输出序列中第i个输 出元素是', 'n-i', 'n-1-i', 'n+1-i', '不能确定', 'D');
INSERT INTO `com_single_question` VALUES ('418', '10000000', '第三章', '1', ' 对于栈操作数据的原则是', '先进先出', '后进先出', '后进后出', '不分顺序', 'B');
INSERT INTO `com_single_question` VALUES ('419', '10000000', '第三章', '3', '若一个栈的输入序列为1,2,3,…,n，输出序列的第一个元素是i，则第j 个输出元素是', 'i-j-1 ', 'i-j', 'j-i+1', '不确定的', 'D');
INSERT INTO `com_single_question` VALUES ('420', '10000000', '第三章', '2', ' 有六个元素6，5，4，3，2，1 的顺序进栈，问下列哪一个不是合法的出栈序列？', '5 4 3 6 1 2 ', '4 5 3 1 2 6 ', '3 4 6 5 2 1 ', '2 3 4 1 5 6', 'A');
INSERT INTO `com_single_question` VALUES ('422', '10000000', '第三章', '2', '设abcdef 以所给的次序进栈，若在进栈操作时，允许退栈操作,则下面得不到的序列为', 'fedcba', 'bcafed', ' dcefba', 'cabdef', 'D');
INSERT INTO `com_single_question` VALUES ('423', '10000000', '第三章', '2', ' 输入序列为ABC，可以变为CBA 时，经过的栈操作为', 'push,pop,push,pop,push,pop', ' push,push,push,pop,pop,pop', 'push,push,pop,pop,push,pop', 'push,pop,push,push,pop,pop', 'B');
INSERT INTO `com_single_question` VALUES ('424', '10000000', '第三章', '2', '一个栈的输入序列为1 2 3 4 5，则下列序列中不可能是栈的输出序列的是', '2 3 4 1 5', ' 5 4 1 3 2 ', '2 3 1 4 5', '1 5 4 3 2', 'B');
INSERT INTO `com_single_question` VALUES ('425', '10000000', '第三章', '2', '对于一个栈而言，如果入栈的数据序列为1,2,3,4则不可能得到的出栈序列是', '1,2,3,4 ', '3,4,2,1 ', '3,4,1,2 ', '4,3,2,1', 'C');
INSERT INTO `com_single_question` VALUES ('426', '10000000', '第三章', '2', '对于一个栈而言，如果入栈的序列为a,b,c,d,e则不可能得到的出栈序列是', 'edcba ', 'dceab', 'decba', 'abcde', 'B');
INSERT INTO `com_single_question` VALUES ('427', '10000000', '第三章', '1', '栈和队列的共同特点是', '都是操作受限的线性表', '都是先进后出', '都是先进先出', '没有共同点', 'A');
INSERT INTO `com_single_question` VALUES ('428', '10000000', '第三章', '3', '一个递归算法必须包括', '递归部分', '终止条件和递归部分', '迭代部分', '终止条件和迭代部分', 'B');
INSERT INTO `com_single_question` VALUES ('429', '10000000', '第三章', '2', '递归过程或函数调用时，处理参数及返回地址，要用一种称为（ ）的数据结构。', '队列', '多维数组', '栈', '线性表', 'C');
INSERT INTO `com_single_question` VALUES ('430', '10000000', '第三章', '3', '设栈S 和队列Q 的初始状态为空，元素e1，e2，e3，e4,e5 和e6 依次通过栈S，一个元素出栈后即进队列Q，若6 个元素出队的序列是e2，e4，e3,e6,e5,e1 则栈S 的容量至少应该是', '6', '4', '3', '2', 'C');
INSERT INTO `com_single_question` VALUES ('431', '10000000', '第三章', '1', '栈和队列的主要区别是', '它们的逻辑结构不一样 ', '它们的存储结构不一样', '所包含的运算不一样式', '插入和删除运算的限定不一样', 'D');
INSERT INTO `com_single_question` VALUES ('432', '10000000', '第三章', '2', '设循环队列中数组的下标范围是0~n-1，其头、尾指针分别为f和r，则其队满的条件为', 'r=f', 'r+1=f', '(f+1)% n=r', '(r+1)% n= f', 'D');
INSERT INTO `com_single_question` VALUES ('433', '10000000', '第三章', '2', '已知队列（4，41，5，7，18，26，15），第一个入队列的是4，则第五个出队列的元素是', '5', '41', '18', '7', 'C');
INSERT INTO `com_single_question` VALUES ('434', '10000000', '第三章', '2', '设循环队列中数组的下标范围是0~n-1，其头、尾指针分别为f和r，则其元素个数为', 'r-f', 'r-f+1', '(r-f)% n+1', '(r-f+n)% n', 'D');
INSERT INTO `com_single_question` VALUES ('435', '10000000', '第三章', '1', '栈和队列都是', '限制存取位置的线性结构', '顺序存储的线性结构', '链式存储的线性结构', '限制存取位置的非线性结构', 'A');
INSERT INTO `com_single_question` VALUES ('436', '10000000', '第三章', '3', '在一个链队列中，假设f和r分别为指向队列中第一个结点和队尾结点的指针，则删除一个结点的操作是', 'r=f->next;', 'r=r->next;', 'f=f->next;', 'f=r->next;', 'C');
INSERT INTO `com_single_question` VALUES ('437', '10000000', '第三章', '1', '栈和队列的共同点是', '都是先进先出', '都是先进后出', '只允许在端点处插入和删除元素', '没有共同点', 'C');
INSERT INTO `com_single_question` VALUES ('438', '10000000', '第三章', '1', '栈和队都是', '顺序存储的线性结构', ' 链式存储的非线性结构', '限制存取点的线性结构', '限制存取点的非线性结构', 'C');
INSERT INTO `com_single_question` VALUES ('439', '10000000', '第三章', '2', '设顺序循环队列Q[0：M-1]的头指针和尾指针分别为F和R，头指针F总是指向队头元素的前一位置， 尾指针R总是指向队尾元素的当前位置，则该循环队列中的元素个数为', 'R-F', 'F-R ', '(R-F+M)％M', '(F-R+M)％M', 'C');
INSERT INTO `com_single_question` VALUES ('440', '10000000', '第三章', '3', '用链接方式存储的队列，在进行删除运算时', '仅修改头指针', '仅修改尾指针', '头、尾指针都要修改', '头、尾指针可能都要修改', 'D');
INSERT INTO `com_single_question` VALUES ('441', '10000000', '第三章', '2', '循环队列存储在数组A[0..m]中，则入队时的操作为', 'rear=rear+1', ' rear=(rear+1) % (m-1)', 'rear=(rear+1) % m ', 'rear=(rear+1)%(m+1)', 'D');
INSERT INTO `com_single_question` VALUES ('442', '10000000', '第三章', '3', '若用一个大小为6 的数组来实现循环队列，且当前rear 和front 的值分别为0 和3，当从队列中删除一个元素，再加入两个元素后，rear 和front 的值分别为多少？', '1 和 5 ', '2 和4', '4 和2', '5 和1', 'B');
INSERT INTO `com_single_question` VALUES ('443', '10000000', '第九章', '2', ' 设哈希表长为14，哈希函数是H(key)=key%11,表中已有数据的关键字为15，38，61，84共四个，现要将关键字为49的结点加到表中，用二次探测再散列法解决冲突，则放入的位置是(  )  ', '5         ', '6', '7', '9', 'D');
INSERT INTO `com_single_question` VALUES ('444', '10000000', '第十章', '2', '下列排序算法中，在待排序数据已有序时，花费时间反而最多的是(     )排序。', '冒泡', '希尔', '快速', '堆', 'C');
INSERT INTO `com_single_question` VALUES ('445', '10000000', '第十章', '3', '对初始状态为递增序列的表按递增顺序排序，最省时间的是（    ）算法。', '堆排序', '快速排序', '插入排序', ' 归并排序', 'B');
INSERT INTO `com_single_question` VALUES ('446', '10000000', '第十章', '1', '就平均性能而言，目前最好的内排序方法是(    )排序法。', '冒泡', '希尔插入', '交换', '快速', 'D');
INSERT INTO `com_single_question` VALUES ('447', '10000000', '第十章', '3', '如果只想得到1000个元素组成的序列中第5个最小元素之前的部分排序的序列，用（    ）方法最快。', '起泡排序', '冒泡排列', 'Shell排序', '堆排序', 'D');
INSERT INTO `com_single_question` VALUES ('448', '10000000', '第十章', '3', '下列排序算法中，（    ）算法可能会出现下面情况：在最后一趟开始之前，所有元素都不在其最终的位置上。', '堆排序  ', '冒泡排序', '快速排序', '插入排序', 'D');
INSERT INTO `com_single_question` VALUES ('449', '10000000', '第十章', '3', '就排序算法所用的辅助空间而言，堆排序，快速排序，归并排序的关系是　（    ）', '堆排序〈　快速排序〈归并排序', '堆排序〈　归并排序〈 快速排序', '堆排序〉 归并排序 〉快速排序 ', '堆排序 >  快速排序 > 归并排序', 'A');
INSERT INTO `com_single_question` VALUES ('450', '10000000', '第十章', '2', '设要将序列（q,h,c,y,p,a,m,s,r,d,f,x）  中的关键码按字母升序重新排序，（  ）是初始步长为4的shell排序一趟扫描的结果；', 'f ,h ,c ,d ,p ,a ,m ,q ,r ,s ,y ,x', ' p ,a ,c ,s ,q ,d ,f ,x ,r ,h ,m ,y', ' a ,d ,c ,r ,f ,q ,m ,s ,y ,p ,h ,x', ' h ,c ,q ,p ,a ,m ,s ,r ,d ,f ,x ,y', 'B');
INSERT INTO `com_single_question` VALUES ('451', '10000000', '第十章', '2', '设要将序列（q,h,c,y,p,a,m,s,r,d,f,x）  中的关键码按字母升序重新排序，（  ）是对排序初始建堆的结果；', ' f ,h ,c ,d ,p ,a ,m ,q ,r ,s ,y ,x', ' p ,a ,c ,s ,q ,d ,f ,x ,r ,h ,m ,y', ' a ,d ,c ,r ,f ,q ,m ,s ,y ,p ,h ,x ', ' h ,c ,q ,p ,a ,m ,s ,r ,d ,f ,x ,y', 'C');
INSERT INTO `com_single_question` VALUES ('452', '10000000', '第十章', '2', '设要将序列（q,h,c,y,p,a,m,s,r,d,f,x）  中的关键码按字母升序重新排序，（  ）是以第一个元素为分界元素的快速一趟扫描的结果', ' f ,h ,c ,d ,p ,a ,m ,q ,r ,s ,y ,x', ' p ,a ,c ,s ,q ,d ,f ,x ,r ,h ,m ,y', ' a ,d ,c ,r ,f ,q ,m ,s ,y ,p ,h ,x', 'h ,c ,q ,p ,a ,m ,s ,r ,d ,f ,x ,y', 'A');
INSERT INTO `com_single_question` VALUES ('454', '10000000', '第七章', '2', 'n个结点的完全有向图含有边的数目', 'n*n ', 'n*n ', 'n／2 ', 'n*（n－l）', 'D');
INSERT INTO `com_single_question` VALUES ('455', '10000000', '第七章', '1', '无向图中一个顶点的度是指图中', '通过该顶点的简单路径数', '与该顶点相邻接的顶点数', '通过该顶点的回路数 ', '与该顶点连通的顶点数', 'B');
INSERT INTO `com_single_question` VALUES ('456', '10000000', '第七章', '2', '设无向图的顶点个数为n，则该图最多有（）条边。', 'n-1', 'n(n-1)/2', 'n(n+1)/2 ', '0', 'B');
INSERT INTO `com_single_question` VALUES ('457', '10000000', '第七章', '2', '一个n个顶点的连通无向图，其边的个数至少为（ ）。', 'n-1 ', 'n', 'n+1', 'nlongn', 'A');
INSERT INTO `com_single_question` VALUES ('458', '10000000', '第七章', '3', '要连通具有n个顶点的有向图，至少需要（）条边。', 'n-1', 'n', 'n+1', '2n', 'B');
INSERT INTO `com_single_question` VALUES ('461', '10000000', '第七章', '3', '在一个无向图中，所有顶点的度数之和等于所有边数的（  ）倍。', '1/2 ', '2', '1', '4', 'B');
INSERT INTO `com_single_question` VALUES ('462', '10000000', '第七章', '3', '设某强连通图中有n个顶点，则该强连通图中至少有（     ）条边。   ', 'n(n-1)  ', 'n+1', ' n', 'n(n+1)', 'C');
INSERT INTO `com_single_question` VALUES ('463', '10000000', '第七章', '2', '设某完全无向图中有n个顶点，则该完全无向图中有（      ）条边。', 'n(n-1)/2 ', ' n(n-1)', '2n', '2n-1 ', 'A');
INSERT INTO `com_single_question` VALUES ('464', '10000000', '第七章', '1', ' 设有6个结点的无向图，该图至少应有(      )条边才能确保是一个连通图。 ', '5', '6', '7', '8', 'A');
INSERT INTO `com_single_question` VALUES ('465', '10000000', '第七章', '2', '设某无向图中有n个顶点e条边，则该无向图中所有顶点的度之和为（     ）。  ', ' n     ', '  e', ' 2n   ', ' 2e', 'D');
INSERT INTO `com_single_question` VALUES ('466', '10000000', '第七章', '2', '若n个顶点的无向图采用邻接矩阵存储方法，则该邻接矩阵为（        ）.', '对称矩阵                        ', ' 一般矩阵  ', ' 对角矩阵', '稀疏矩阵', 'A');
INSERT INTO `com_single_question` VALUES ('467', '10000000', '第七章', '2', '下列哪一种图的邻接矩阵是对称矩阵？（    ）', '有向图                          ', '无向图  ', ' AOV网   ', ' AOE网', 'B');
INSERT INTO `com_single_question` VALUES ('468', '10000000', '第七章', '2', '设某有向图中有n个顶点，则该有向图对应的邻接表中有（  ）个表头结点。    ', 'n-1  ', 'n ', '  n+1 ', ' 2n-1 ', 'B');
INSERT INTO `com_single_question` VALUES ('469', '10000000', '第七章', '2', '设无向图G中有n个顶点e条边，则其对应的邻接表中的表头结点和表结点的个数分别为（     ）。', 'n，e ', 'e', ' 2n，e ', ' n，2e ', 'D');
INSERT INTO `com_single_question` VALUES ('470', '10000000', '第七章', '2', '设某有向图的邻接表中有n个表头结点和m个表结点，则该图中有（  ）条有向边。  ', '  n    ', ' n-1 ', ' m ', '  m-1 ', 'C');
INSERT INTO `com_single_question` VALUES ('471', '10000000', '第七章', '2', ' 下列说法不正确的是（  ）。', '图的遍历是从给定的源点出发且每一个顶点仅被访问一次', '遍历的基本算法有两种：深度遍历和广度遍历  ', '图的深度遍历不适用于有向图', '图的深度遍历是一个递归过程', 'C');
INSERT INTO `com_single_question` VALUES ('472', '10000000', '第七章', '2', '无向图G=(V,E),其中：V={a,b,c,d,e,f},E={(a,b),(a,e),(a,c),(b,e),(c,f),(f,d),(e,d)}，对该图从A出发进行深度优先遍历，得到的顶点序列正确的是（     ）。', 'a,b,e,c,d,f              ', ' a,c,f,e,b,d', ' a,e,b,c,f,d', ' a,e,d,f,c,b', 'D');
INSERT INTO `com_single_question` VALUES ('473', '10000000', '第七章', '2', '设连通图G中的边集E={(a，b)，(a，e)，(a，c)，(b，e)，(e，d)，(d，f)，(f，c)}，则从顶点a出发不可能得到的一种深度优先遍历的顶点序列为（    ）。   ', 'abedfc', ' acfebd  ', ' aebdfc    ', 'aedfcb ', 'B');

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='专业表';

-- ----------------------------
-- Records of com_specialty
-- ----------------------------
INSERT INTO `com_specialty` VALUES ('1', '140401', '14计算机');
INSERT INTO `com_specialty` VALUES ('2', '140402', '14物联网');
INSERT INTO `com_specialty` VALUES ('3', '140403', '14软件工程');
INSERT INTO `com_specialty` VALUES ('4', '160409', '16物联网工程');

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
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8 COMMENT='学生表';

-- ----------------------------
-- Records of com_student
-- ----------------------------
INSERT INTO `com_student` VALUES ('1', '140401049', 'c4ea049486589ef44768723100a37191', '杨徐越', '140401', '男', null, null);
INSERT INTO `com_student` VALUES ('2', '140401050', '2b8140ad3601e91234a64cd392ab411a', '姜日久', '140401', '男', null, null);
INSERT INTO `com_student` VALUES ('3', '140403001', 'c89eb7272ad0de93f2596db10b5ef190', '软件学生1', '140403', '男', null, null);
INSERT INTO `com_student` VALUES ('4', '140403002', '0fe033a6a61d4304cae03b2338ef19d4', '软件学生2', '140403', '男', null, null);
INSERT INTO `com_student` VALUES ('5', '140403003', '1c961a4e0df7749d275d26666bb3c36a', '软件学生3', '140403', '男', null, null);
INSERT INTO `com_student` VALUES ('6', '140403004', 'c03fe9ab0dd04a291d1af1ec2c9fcaac', '软件学生4', '140403', '男', null, null);
INSERT INTO `com_student` VALUES ('7', '140403005', 'dba838abb79e1b0b5dbfc77ac4c494db', '软件学生5', '140403', '男', null, null);
INSERT INTO `com_student` VALUES ('8', '140402001', 'c23ff45fd6ee1c29e67e102afc0194a1', '计算机学生1', '140402', '男', null, null);
INSERT INTO `com_student` VALUES ('9', '140402002', 'fa934c9cd74da85f143ae2e1c2f7e672', '计算机学生2', '140402', '男', null, null);
INSERT INTO `com_student` VALUES ('10', '140402003', '946be4136f48486266f565aa2020c61d', '计算机学生3', '140402', '男', null, null);
INSERT INTO `com_student` VALUES ('11', '140402004', 'd7c3f581740afefbfc7cb2114625fbcd', '计算机学生4', '140402', '男', null, null);
INSERT INTO `com_student` VALUES ('12', '140402005', 'f1930f56bb5bb1ad4f43ad05c55fef1c', '计算机学生5', '140402', '男', null, null);
INSERT INTO `com_student` VALUES ('13', '140402006', '37cd930594da8e6b71d1519f14de7426', '计算机学生6', '140402', '男', null, null);
INSERT INTO `com_student` VALUES ('14', '160409001', '829633e302a87bb6fdec30d4781501c4', '曹芷硕', '160409', '男', '18840177683', '1017914222@qq.com');
INSERT INTO `com_student` VALUES ('15', '160409002', 'b659e081548e6b60290a8d3f3a91c3f7', '崔凯', '160409', '男', '15668776672', '1454479816@qq.com');
INSERT INTO `com_student` VALUES ('16', '160409003', 'e64bda4956f044f96fe8091e62dc47ee', '李航', '160409', '男', null, null);
INSERT INTO `com_student` VALUES ('17', '160409004', 'da85e05c1eae6959dad97083cd54c834', '韩吉来', '160409', '男', '18840181167', '2318096234@qq.com');
INSERT INTO `com_student` VALUES ('18', '160409005', 'a5c97fde547c42e121d36dbdef84781d', '张祯', '160409', '男', '18840179786', '2570467322@qq.com');
INSERT INTO `com_student` VALUES ('19', '160409006', '75930d51c9d7964339417925553cb87c', '丛国强', '160409', '男', null, null);
INSERT INTO `com_student` VALUES ('20', '160409007', 'ba71d7bf7838afc3bfcdeb497829aa6f', '隋昱桐', '160409', '男', null, null);
INSERT INTO `com_student` VALUES ('21', '160409008', '16985d9ba54c1df59785898e77f1447e', '孙海铭', '160409', '男', '15694165631', '759651336@qq.com');
INSERT INTO `com_student` VALUES ('22', '160409009', 'e74975d754fffdaac2afc6f117f43d48', '姜岱', '160409', '男', null, null);
INSERT INTO `com_student` VALUES ('23', '160409010', '7ec0674ce7306129472f388387da1800', '林继祥', '160409', '男', null, null);
INSERT INTO `com_student` VALUES ('24', '160409011', 'e6f4eb8684b2772d52eea86e1d62a637', '王鹏伟', '160409', '男', null, null);
INSERT INTO `com_student` VALUES ('25', '160409012', 'af5c99a9cb4a23abc751c886e30f386a', '庞正浩', '160409', '男', null, null);
INSERT INTO `com_student` VALUES ('26', '160409013', 'ee60adebb8f7e91a8fdc02f91666c289', '赵鑫', '160409', '男', null, null);
INSERT INTO `com_student` VALUES ('27', '160409014', '9d01e9d08b08056340b30842428c5da4', '于永新', '160409', '男', null, null);
INSERT INTO `com_student` VALUES ('28', '160409015', '4240d674f1b8d61e3f6e5008006b1c3d', '高庆峰', '160409', '男', null, null);
INSERT INTO `com_student` VALUES ('29', '160409016', 'b8c97d74b0b37486c56cd86bd9a9f3b6', '叶耀雷', '160409', '男', null, null);
INSERT INTO `com_student` VALUES ('30', '160409017', '62776ff73d6049810a3e3cf86040ec4b', '汪得鑫', '160409', '男', '18524566939', '1264822847@qq.com');
INSERT INTO `com_student` VALUES ('31', '160409018', '76ee3e32bab4c4179c397c5336351e3d', '周旭', '160409', '男', null, null);
INSERT INTO `com_student` VALUES ('32', '160409019', '12f231c20f17e577ed24f6d749ad5fc8', '田野', '160409', '男', null, null);
INSERT INTO `com_student` VALUES ('33', '160409020', 'e8c8ca010f49685e6feeaac230e44449', '方世玉', '160409', '男', null, null);
INSERT INTO `com_student` VALUES ('34', '160409021', '38d452c11de8a5ced636af441ad940f7', '金利阳', '160409', '男', '13104165825', '1456593468@qq.com');
INSERT INTO `com_student` VALUES ('35', '160409022', '7575c70e779cb2cf62eaa1f6517a339d', '肖峰', '160409', '男', null, null);
INSERT INTO `com_student` VALUES ('36', '160409023', '67efbfb22a32b4d746b85e37d0a948a8', '罗万银', '160409', '男', '13104165487', '2813872780@qq.com');
INSERT INTO `com_student` VALUES ('37', '160409024', '0d6f20c1dd6b36734efd1a1316123f26', '王庆伟', '160409', '男', '15329446665', '1027973284@qq.com');
INSERT INTO `com_student` VALUES ('38', '160409025', 'b6754d5f9739b3a479b1cc9118dfa731', '尚小楠', '160409', '女', null, null);
INSERT INTO `com_student` VALUES ('39', '160409026', '1dd16f0a9cb416a4e5748cc5ff0c8889', '姜惠心', '160409', '女', null, null);
INSERT INTO `com_student` VALUES ('40', '160409027', '35fdf103437d46bf270badada00974dc', '李书茵', '160409', '女', '15141669412', '2734479521@qq.com');
INSERT INTO `com_student` VALUES ('41', '160409028', 'a557f703b1b1b8f8d39d71c3c91ab604', '王娟', '160409', '女', null, null);
INSERT INTO `com_student` VALUES ('42', '160409029', '4fae40e3c0f5618f4b4d4dcecd0283bb', '王淇鑫', '160409', '女', null, null);
INSERT INTO `com_student` VALUES ('43', '160409030', '88c574a34c1f4bd04a052bbf1a6378d4', '李虹萱', '160409', '女', null, null);
INSERT INTO `com_student` VALUES ('44', '160409031', '5c29cfd07998859a6cc8ce1e295e5205', '蔡平安', '160409', '女', '18840181609', '1543232250@qq.com');
INSERT INTO `com_student` VALUES ('45', '160409032', '7e7a0eee0e8842e28d19d898c8c52808', '杨倩', '160409', '女', null, null);
INSERT INTO `com_student` VALUES ('46', '160409033', 'ede30c863b2c7e00fb6e2b9c30057e20', '姜宇涵', '160409', '女', null, null);
INSERT INTO `com_student` VALUES ('47', '160409034', 'e65a0181c9e4f19122d0385082b862be', '李季', '160409', '女', null, null);
INSERT INTO `com_student` VALUES ('48', '160409035', 'a18549d72f70258a0992b58ce900cf67', '罗诗琪', '160409', '女', '18840179198', '445149893@qq.com');
INSERT INTO `com_student` VALUES ('49', '160409036', 'cee0e72d1f4185f0381f26f148557928', '张光耀', '160409', '男', null, null);
INSERT INTO `com_student` VALUES ('50', '160409037', 'fa7f40c3ac23c73f0b516f9efde3c743', '王梓', '160409', '男', '18840181108', '345521885@qq.com');
INSERT INTO `com_student` VALUES ('51', '160409038', '97443274eb72246ab80dea0287a40e87', '韩涛', '160409', '男', '15842457842', '2650047421@qq.com');
INSERT INTO `com_student` VALUES ('52', '160409039', '848e36746bb393c7eb49cc724b839f6f', '李远', '160409', '男', '15998615928', '1035815128@qq.com');
INSERT INTO `com_student` VALUES ('53', '160409040', 'e1307b9f7cd4676043457b4fa2498bd3', '刘宇辉', '160409', '男', null, null);
INSERT INTO `com_student` VALUES ('54', '160409041', 'e59fbe6fba4dc4eb9c7fe36ede7eec2a', '来威国', '160409', '男', null, null);
INSERT INTO `com_student` VALUES ('55', '160409042', 'af605d75bb32d51589d1c03fbecf5986', '刘永哲', '160409', '男', null, null);
INSERT INTO `com_student` VALUES ('56', '160409043', 'f9c43ead44abf76e4bc65e7f65e81946', '薛喨', '160409', '男', '15940603154', '1018647828@qq.com');
INSERT INTO `com_student` VALUES ('57', '160409044', 'c96237c15878b07ba53491193c7ffd95', '张亚夫', '160409', '男', '18840180966', '1401201027@qq.com');
INSERT INTO `com_student` VALUES ('58', '160409045', '9e6b4731924585f74e44c2510adef576', '刘晟池', '160409', '男', null, null);
INSERT INTO `com_student` VALUES ('59', '160409046', 'c65b84bd2a97bb9c4734d2b91eb164ce', '范鑫琦', '160409', '男', '18840181230', '1664596790@qq.com');
INSERT INTO `com_student` VALUES ('60', '160409047', '90a5da08645f39426222603a6ecbb134', '辛康洲', '160409', '男', null, null);
INSERT INTO `com_student` VALUES ('61', '160409048', '2821c810b3e89887a3f1680c69a78186', '陈佳琳', '160409', '男', '13149786191', '576772766@qq.com');
INSERT INTO `com_student` VALUES ('62', '160409049', 'b1b55fac01691c62d68a15748664d7b2', '刘简宁', '160409', '男', null, null);
INSERT INTO `com_student` VALUES ('63', '160409050', 'e53447e82919d9ebb01fc7ca0aef1fba', '蒋凯盛', '160409', '男', null, null);
INSERT INTO `com_student` VALUES ('64', '160409051', 'afd9573683264c8b4e32d3900762d7ef', '王贯宇', '160409', '男', '18304211220', '951424271@qq.com');
INSERT INTO `com_student` VALUES ('65', '160409052', 'bb1268e902a164ee0f447f998f099cfb', '洪帅', '160409', '男', '18840181164', '2713139385@qq.com');
INSERT INTO `com_student` VALUES ('66', '160409053', '528e52cd13e7887d55e1ee5dd1ee9c1b', '张家宝', '160409', '男', '18840178250', '2481296456@qq.com');
INSERT INTO `com_student` VALUES ('67', '160409054', '09d04489887f1680529c9bdefa899393', '段文皓', '160409', '男', null, null);
INSERT INTO `com_student` VALUES ('68', '160409055', 'ca5fd3d17c10f2046c5dc17db52c8812', '董梦男', '160409', '男', null, null);
INSERT INTO `com_student` VALUES ('69', '160409056', 'd72c62627d9149d31ef86b4388f0930d', '陈鑫', '160409', '男', '18840181216', '115639348@qq.com');
INSERT INTO `com_student` VALUES ('70', '160409057', 'ee667b5eb4178d45418e5ebf3aa276d2', '李卓', '160409', '男', null, null);
INSERT INTO `com_student` VALUES ('71', '160409058', 'ecbcfd013ac5a22c57d06fb375daa045', '王万丰', '160409', '男', '13149780227', '255191773@qq.com');
INSERT INTO `com_student` VALUES ('72', '160409059', '9b13e4f03295517f534ac2bd06f6c97a', '张朦朦', '160409', '女', null, null);
INSERT INTO `com_student` VALUES ('73', '160409060', '736f57f39af43a00fc1ec3c75614a5ca', '孔凡馨', '160409', '女', '13104166421', '1156467584@qq.com');
INSERT INTO `com_student` VALUES ('74', '160409061', '5ddf5d18bf7861ad2ea390be699f339a', '郭小光', '160409', '男', '15668647801', '1460941857@qq.com');
INSERT INTO `com_student` VALUES ('75', '160409062', 'b70036640e03cf6520b4bfd4c922c210', '吴玉莹', '160409', '女', null, null);
INSERT INTO `com_student` VALUES ('76', '160409063', 'd4c51c16341d0e9c039ef98909c05c6c', '耿元昊', '160409', '女', null, null);
INSERT INTO `com_student` VALUES ('77', '160409064', 'c8a32a4ba811c272e320e052559f9ffb', '韩佳钰', '160409', '女', null, null);
INSERT INTO `com_student` VALUES ('78', '160409065', '93a41e4233fd7850f11d0afd8c32f608', '侯雨蒙', '160409', '女', '13149769959', '736894796@qq.com');
INSERT INTO `com_student` VALUES ('79', '160409066', 'b9e033eb9784c536abb3344848976148', '盛丽娜', '160409', '女', '13149769986', '409896753@qq.com');
INSERT INTO `com_student` VALUES ('80', '160409067', '9ca7b30aaa2e01475c14b602417243a6', '苗丽梦', '160409', '女', '18840181027', '1183384803@qq.com');
INSERT INTO `com_student` VALUES ('81', '160409068', '01bc5afd29ba7da08fd930be92ec0761', '邓卓尔', '160409', '女', '13130661721', '3292422094@qq.com');
INSERT INTO `com_student` VALUES ('82', '160409069', 'd84d5a4c62f2bb61278a8792d5f3fb61', '万佳欣', '160409', '女', '18840179221', '2522616261@qq.com');
INSERT INTO `com_student` VALUES ('83', '160409070', '11925e64cd17887c2da4a1c7b18ca8f2', '李杰', '160409', '女', '18840181165', '2014446989@qq.com');
INSERT INTO `com_student` VALUES ('84', '160409072', '73484836dc5d0833fd1042dd17b6d2c7', '测试学生', '160409', '男', null, null);
INSERT INTO `com_student` VALUES ('85', '160409073', '8d8520f62a1cf89b647522fba2312212', '测试学生2', '160409', '男', null, null);
INSERT INTO `com_student` VALUES ('86', '160409074', 'd70303a0aa3e51859efcb3e8e21d0bff', '测试学生3', '160409', '男', null, null);
INSERT INTO `com_student` VALUES ('87', '160409075', 'f7e32e60d7cfba305e7c40c96b35ba66', '测试学生4', '160409', '男', null, null);

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
INSERT INTO `com_student_l_another_question` VALUES ('1', '140401049', '10000000', 'xu');
INSERT INTO `com_student_l_another_question` VALUES ('1', '140401050', '10000000', 'yue');

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
INSERT INTO `com_studnet_l_role` VALUES ('140402001', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140402002', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140402003', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140402004', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140402005', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140402006', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140403001', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140403002', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140403003', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140403004', '4');
INSERT INTO `com_studnet_l_role` VALUES ('140403005', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409001', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409002', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409003', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409004', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409005', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409006', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409007', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409008', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409009', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409010', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409011', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409012', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409013', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409014', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409015', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409016', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409017', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409018', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409019', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409020', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409021', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409022', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409023', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409024', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409025', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409026', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409027', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409028', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409029', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409030', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409031', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409032', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409033', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409034', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409035', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409036', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409037', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409038', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409039', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409040', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409041', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409042', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409043', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409044', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409045', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409046', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409047', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409048', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409049', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409050', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409051', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409052', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409053', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409054', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409055', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409056', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409057', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409058', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409059', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409060', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409061', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409062', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409063', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409064', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409065', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409066', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409067', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409068', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409069', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409070', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409072', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409073', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409074', '4');
INSERT INTO `com_studnet_l_role` VALUES ('160409075', '4');

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='教师表';

-- ----------------------------
-- Records of com_teacher
-- ----------------------------
INSERT INTO `com_teacher` VALUES ('1', '140403', '827ccb0eea8a706c4c34a16891f84e7b', '软件教师', '男', '教授', '软件工程教研室', null, null);
INSERT INTO `com_teacher` VALUES ('2', '140402', '827ccb0eea8a706c4c34a16891f84e7b', '计算机教师', '男', '教授', '软件工程教研室', null, null);
INSERT INTO `com_teacher` VALUES ('4', '120403', 'a0ee950ee40351fb53056af56fd6e1b1', '贾丹', '女', '副教授', '软件工程', null, null);
INSERT INTO `com_teacher` VALUES ('5', '147258', '827ccb0eea8a706c4c34a16891f84e7b', 'Newteacher', '男', 'Nothing To Show', 'Nothing To Show', null, null);
INSERT INTO `com_teacher` VALUES ('6', '100000', '698d51a19d8a121ce581499d7b701668', 'sumsun', '男', 'Pro', 'Nothing To Show', null, null);

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
INSERT INTO `com_teacher_l_course` VALUES ('100000', '10000000', '140401', '2017-09-04', '2017-09-14');
INSERT INTO `com_teacher_l_course` VALUES ('120403', '10000000', '160409', '2017-08-29', '2018-01-05');
INSERT INTO `com_teacher_l_course` VALUES ('140403', '10000000', '140401', '2017-09-07', '2017-11-17');
INSERT INTO `com_teacher_l_course` VALUES ('140403', '10000000', '140402', '2017-09-01', '2018-01-31');
INSERT INTO `com_teacher_l_course` VALUES ('140403', '10000000', '140403', '2017-09-01', '2018-01-31');
INSERT INTO `com_teacher_l_course` VALUES ('147258', '10000000', '140401', '2017-11-07', '2017-12-29');
INSERT INTO `com_teacher_l_course` VALUES ('147258', '45678945', '140401', '2017-11-22', '2018-02-16');

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
-- Records of com_teacher_l_role
-- ----------------------------
INSERT INTO `com_teacher_l_role` VALUES ('100000', '3');
INSERT INTO `com_teacher_l_role` VALUES ('120403', '3');
INSERT INTO `com_teacher_l_role` VALUES ('140402', '3');
INSERT INTO `com_teacher_l_role` VALUES ('140403', '3');
INSERT INTO `com_teacher_l_role` VALUES ('147258', '3');

-- ----------------------------
-- Table structure for com_tf_question
-- ----------------------------
DROP TABLE IF EXISTS `com_tf_question`;
CREATE TABLE `com_tf_question` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `courseId` int(8) NOT NULL COMMENT '课程号',
  `section` varchar(10) NOT NULL COMMENT '章节名称',
  `levels` int(1) NOT NULL COMMENT '难度',
  `content` varchar(255) NOT NULL COMMENT '题目正文',
  `result` int(1) NOT NULL COMMENT '答案',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=405 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of com_tf_question
-- ----------------------------
INSERT INTO `com_tf_question` VALUES ('195', '10000000', '第十章', '1', '1．	快速排序是一种稳定的排序方法。（ ）', '0');
INSERT INTO `com_tf_question` VALUES ('196', '10000000', '第十章', '2', ' 当待排序序列初始有序时，快速排序的时间复杂性为O(n)。（    ）', '0');
INSERT INTO `com_tf_question` VALUES ('197', '10000000', '第十章', '1', '快速排序的时间复杂性不受数据初始状态影响，恒为O(nlog2n)。', '0');
INSERT INTO `com_tf_question` VALUES ('198', '10000000', '第十章', '3', '当输入序列已经基本有序时，起泡排序需要比较关键码的次数，比快速排序还要少。', '1');
INSERT INTO `com_tf_question` VALUES ('199', '10000000', '第十章', '3', '2．	若使记录序列按关键字非递减有序排列，则在堆排序中，应先建立一个小顶堆。', '0');
INSERT INTO `com_tf_question` VALUES ('200', '10000000', '第十章', '3', '当待排序序列初始有序时，简单选择排序的时间复杂性为O(n)。', '0');
INSERT INTO `com_tf_question` VALUES ('201', '10000000', '第十章', '2', '当向一个最小堆插入一个具有最小值的元素时，该元素需要逐层向上调整，直到被调整到堆顶位置为止。', '1');
INSERT INTO `com_tf_question` VALUES ('202', '10000000', '第十章', '3', '对具有n个结点的堆进行插入一个元素运算的时间复杂度为O(n)。', '0');
INSERT INTO `com_tf_question` VALUES ('204', '10000000', '第六章', '1', '某个结点的度就是它的孩子数目。（）', '1');
INSERT INTO `com_tf_question` VALUES ('205', '10000000', '第六章', '1', '如果二叉树中某结点的度为1，则说该结点只有一棵子树。（）', '1');
INSERT INTO `com_tf_question` VALUES ('206', '10000000', '第六章', '2', '完全二叉树就是满二叉树。（）', '0');
INSERT INTO `com_tf_question` VALUES ('207', '10000000', '第六章', '3', '如果二叉树中结点总数为K，则该二叉树中分数总数为K+1。（）', '0');
INSERT INTO `com_tf_question` VALUES ('208', '10000000', '第六章', '3', '先序遍历序列与中序遍历序列相同的二叉树只能是右单支树。', '1');
INSERT INTO `com_tf_question` VALUES ('209', '10000000', '第六章', '2', '一棵树的后序遍历序列与对应二叉树的后序遍历序列相同。', '0');
INSERT INTO `com_tf_question` VALUES ('210', '10000000', '第六章', '2', '一棵树的先序遍历序列与对应二叉树的先序遍历序列相同。', '1');
INSERT INTO `com_tf_question` VALUES ('211', '10000000', '第六章', '2', '若一棵二叉树中的结点均无右孩子，则该二叉树的中根遍历和后根遍历序列正好相反。（）', '0');
INSERT INTO `com_tf_question` VALUES ('212', '10000000', '第六章', '2', '对二叉排序树进行中根遍历，可得到结点的有序排列。', '1');
INSERT INTO `com_tf_question` VALUES ('213', '10000000', '第六章', '3', '任何一棵二叉树的叶结点在三种遍历中的相对次序是不变的。', '1');
INSERT INTO `com_tf_question` VALUES ('214', '10000000', '第六章', '2', '在一棵二叉树中，假定每个结点只有左子女，没有右子女，对它分别进行前序遍历和中根遍历，则具有相同的结果。（）', '0');
INSERT INTO `com_tf_question` VALUES ('215', '10000000', '第六章', '1', '二叉树是一棵无序树。', '0');
INSERT INTO `com_tf_question` VALUES ('216', '10000000', '第六章', '3', '完全二叉树的某结点若无左孩子，则它必是叶结点。', '1');
INSERT INTO `com_tf_question` VALUES ('217', '10000000', '第六章', '2', ' 二叉树中每个结点的两棵子树的高度差等于1。', '0');
INSERT INTO `com_tf_question` VALUES ('218', '10000000', '第六章', '2', '在线索二叉树中每个结点通过线索都可以直接找到它的前驱和后继。', '0');
INSERT INTO `com_tf_question` VALUES ('219', '10000000', '第六章', '3', '在任意一棵二叉树的前序序列和后序序列中，各叶子之间的相对次序关系都相同。（）', '1');
INSERT INTO `com_tf_question` VALUES ('220', '10000000', '第六章', '2', '线索二叉树中的每个结点通常包含有5个数据成员。（）', '1');
INSERT INTO `com_tf_question` VALUES ('221', '10000000', '第六章', '2', '对森林的中序遍历序列与其对应的二叉树的中序遍历序列相同。（）', '1');
INSERT INTO `com_tf_question` VALUES ('223', '10000000', '第六章', '3', '将一棵二叉树转换成树后，则该树一定没有右子树。（）', '1');
INSERT INTO `com_tf_question` VALUES ('225', '10000000', '第六章', '2', '哈夫曼树中不存在度为1的结点。（）', '1');
INSERT INTO `com_tf_question` VALUES ('226', '10000000', '第六章', '2', '赫夫曼树中，权值大的结点离根结点远。', '0');
INSERT INTO `com_tf_question` VALUES ('227', '10000000', '第六章', '2', '哈夫曼树中不存在度为0的结点。', '0');
INSERT INTO `com_tf_question` VALUES ('228', '10000000', '第六章', '2', '存在这样的二叉树，对它采用任何次序的遍历，结果相同。', '1');
INSERT INTO `com_tf_question` VALUES ('230', '10000000', '第九章', '3', '算法的时间复杂度T(n)=O(f(n))表示随着问题规模n的增长，算法执行时间的增长率和f(n) 的增长率相同。（）', '1');
INSERT INTO `com_tf_question` VALUES ('231', '10000000', '第一章', '1', '记录是数据处理的最小单位。', '0');
INSERT INTO `com_tf_question` VALUES ('232', '10000000', '第一章', '2', '数据的逻辑结构是指数据的各数据项之间的逻辑关系。', '1');
INSERT INTO `com_tf_question` VALUES ('233', '10000000', '第一章', '1', '健壮的算法不会因非法的输入数据而出现莫名其妙的状态。', '1');
INSERT INTO `com_tf_question` VALUES ('234', '10000000', '第一章', '1', '数据的物理结构是指数据在计算机内的实际存储形式。', '1');
INSERT INTO `com_tf_question` VALUES ('235', '10000000', '第一章', '2', '顺序存储方式的优点是存储密度大，且插入、删除运算效率高。', '0');
INSERT INTO `com_tf_question` VALUES ('236', '10000000', '第一章', '2', '算法分析的目的是找出数据结构的合理性。', '0');
INSERT INTO `com_tf_question` VALUES ('237', '10000000', '第一章', '2', '算法和程序原则上没有区别，在讨论数据结构时二者是通用的。', '0');
INSERT INTO `com_tf_question` VALUES ('238', '10000000', '第一章', '2', '数据的逻辑结构是指各数据元素之间的逻辑关系。', '1');
INSERT INTO `com_tf_question` VALUES ('239', '10000000', '第一章', '1', '数据元素是数据的最小单位。', '0');
INSERT INTO `com_tf_question` VALUES ('240', '10000000', '第二章', '1', '顺序存储的线性表可以随机存储。', '1');
INSERT INTO `com_tf_question` VALUES ('241', '10000000', '第二章', '2', '线性表的长度是线性表所占用的存储空间的大小。', '0');
INSERT INTO `com_tf_question` VALUES ('242', '10000000', '第二章', '2', '在线性表的顺序存储结构中，逻辑上相邻的元素在物理位置上并不一定是相邻的。', '0');
INSERT INTO `com_tf_question` VALUES ('243', '10000000', '第二章', '1', '线性表只能用顺序存储结构实现。', '0');
INSERT INTO `com_tf_question` VALUES ('244', '10000000', '第一章', '2', '顺序存储结构的主要缺点是插入或删除操作时需移动大量元素。', '1');
INSERT INTO `com_tf_question` VALUES ('245', '10000000', '第二章', '1', '顺序表和一维数组一样，都可以按下标随机（或直接）访问。', '1');
INSERT INTO `com_tf_question` VALUES ('248', '10000000', '第二章', '1', ' 顺序存储结构的主要缺点是不利于插入或删除操作。', '1');
INSERT INTO `com_tf_question` VALUES ('249', '10000000', '第二章', '2', '线性表的特点是每个元素都有一个前驱和一个后继。', '0');
INSERT INTO `com_tf_question` VALUES ('250', '10000000', '第二章', '2', '顺序存储方式只能用于存储线性结构。', '0');
INSERT INTO `com_tf_question` VALUES ('252', '10000000', '第二章', '2', '线性表就是顺序存储的表。', '0');
INSERT INTO `com_tf_question` VALUES ('253', '10000000', '第二章', '2', '顺序存储方式的优点是存储密度大，且插入、删除运算效率高。', '0');
INSERT INTO `com_tf_question` VALUES ('254', '10000000', '第十章', '3', '在长度为n的顺序表中，求第i个元素的直接前驱算法的时间复杂度为0（1）。', '1');
INSERT INTO `com_tf_question` VALUES ('268', '10000000', '第九章', '3', '在长度为n的顺序表中，求第i个元素的直接前驱算法的时间复杂度为0（1）。', '1');
INSERT INTO `com_tf_question` VALUES ('269', '10000000', '第二章', '2', '链表中的头结点仅起到标识的作用。', '0');
INSERT INTO `com_tf_question` VALUES ('270', '10000000', '第二章', '2', '线性表采用链表存储时，结点和结点内部的存储空间可以是不连续的。', '1');
INSERT INTO `com_tf_question` VALUES ('271', '10000000', '第二章', '3', '对任何数据结构链式存储结构一定优于顺序存储结构。', '0');
INSERT INTO `com_tf_question` VALUES ('272', '10000000', '第二章', '2', '循环链表不是线性表.', '0');
INSERT INTO `com_tf_question` VALUES ('273', '10000000', '第二章', '2', '链表是采用链式存储结构的线性表,进行插入、删除操作时，在链表中比在顺序存储结构中效率高。', '1');
INSERT INTO `com_tf_question` VALUES ('274', '10000000', '第二章', '1', '单链表可以实现随机存取。', '0');
INSERT INTO `com_tf_question` VALUES ('275', '10000000', '第二章', '1', '线性表若采用链式存储表示, 在删除时不需要移动元素。', '1');
INSERT INTO `com_tf_question` VALUES ('276', '10000000', '第二章', '2', '循环链表的结点与单链表的结点结构完全相同，只是结点间的连接方式不同。', '1');
INSERT INTO `com_tf_question` VALUES ('277', '10000000', '第二章', '3', '在对双向循环链表做删除一个结点操作时，应先将被删除结点的前驱结点和后继结点链接好再执行删除结点操作。', '1');
INSERT INTO `com_tf_question` VALUES ('278', '10000000', '第二章', '2', '在用循环单链表表示的链式队列中，可以不设队头指针，仅在链尾设置队尾指针。', '1');
INSERT INTO `com_tf_question` VALUES ('279', '10000000', '第二章', '2', '线性表若采用链式存储表示时，其存储结点的地址可连续也可不连续。', '1');
INSERT INTO `com_tf_question` VALUES ('280', '10000000', '第三章', '2', '若让元素1,2,3依次进栈，则出栈次序1,3,2是不可能出现的情况。', '0');
INSERT INTO `com_tf_question` VALUES ('281', '10000000', '第三章', '3', '两个栈共享一片连续内存空间时，为提高内存利用率，减少溢出机会，应把两个栈的栈底分别设在这片内存空间的两端。', '1');
INSERT INTO `com_tf_question` VALUES ('282', '10000000', '第三章', '2', '链式栈与顺序栈相比, 一个明显的优点是通常不会出现栈满的情况。', '1');
INSERT INTO `com_tf_question` VALUES ('283', '10000000', '第三章', '1', '栈只允许在栈尾进行插入和删除', '1');
INSERT INTO `com_tf_question` VALUES ('284', '10000000', '第三章', '1', '栈和队列不是线性表', '0');
INSERT INTO `com_tf_question` VALUES ('285', '10000000', '第三章', '3', '两个栈共享一片连续内存空间时，为提高内存利用率，减少溢出机会，应把两个栈的栈底分别设在这片内存空间的两端。', '1');
INSERT INTO `com_tf_question` VALUES ('286', '10000000', '第三章', '3', '即使对不含相同元素的同一输入序列进行两组不同的合法的入栈和出栈组合操作，所得的输出序列也一定相同。', '0');
INSERT INTO `com_tf_question` VALUES ('287', '10000000', '第三章', '2', '若输入序列为1,2,3,4,5,6,则通过一个栈可以输出序列3,2,5,6,4,1.', '1');
INSERT INTO `com_tf_question` VALUES ('288', '10000000', '第三章', '2', '若输入序列为1，2，3，4，5，6，则通过一个栈可以输出序列1，5，4，6，2，3。', '0');
INSERT INTO `com_tf_question` VALUES ('289', '10000000', '第三章', '3', '任何一个递归过程都可以转换成非递归过程。', '1');
INSERT INTO `com_tf_question` VALUES ('290', '10000000', '第三章', '3', '递归的算法简单、易懂、容易编写，而且执行效率也高。', '1');
INSERT INTO `com_tf_question` VALUES ('291', '10000000', '第三章', '3', '递归调用算法与相同功能的非递归算法相比，主要问题在于重复计算太多，而且调用本身需要分配额外的空间和传递数据和控制，所以时间与空间开销通常都比较大。', '1');
INSERT INTO `com_tf_question` VALUES ('292', '10000000', '第三章', '3', '在具有n 个单元的循环队列中，队满时队列中共有n个元素。', '0');
INSERT INTO `com_tf_question` VALUES ('294', '10000000', '第三章', '1', '在队列中，只能在队头端允许进行插入和删除操作。', '0');
INSERT INTO `com_tf_question` VALUES ('295', '10000000', '第三章', '1', '在队列中，允许进行插入操作的一端称为队头。', '0');
INSERT INTO `com_tf_question` VALUES ('296', '10000000', '第三章', '1', '队列只允许在队尾进行插入和删除。', '0');
INSERT INTO `com_tf_question` VALUES ('297', '10000000', '第三章', '1', '队列是先进后出的线性表。', '0');
INSERT INTO `com_tf_question` VALUES ('298', '10000000', '第三章', '1', '在队列中，允许进行删除操作的一端称为队尾。', '0');
INSERT INTO `com_tf_question` VALUES ('299', '10000000', '第三章', '1', ' 栈和队列都是线性表，只是在插入和删除时受到了一些限制。', '1');
INSERT INTO `com_tf_question` VALUES ('300', '10000000', '第三章', '1', '栈和队列的存储方式，既可以是顺序方式，又可以是链式方式。', '1');
INSERT INTO `com_tf_question` VALUES ('301', '10000000', '第三章', '1', '栈与队列是一种特殊操作的线性表。', '1');
INSERT INTO `com_tf_question` VALUES ('302', '10000000', '第三章', '1', '栈和队列都是限制存取点的线性结构。', '1');
INSERT INTO `com_tf_question` VALUES ('303', '10000000', '第三章', '1', '在一个顺序存储的循环队列中, 队头指针指向队头元素的后一个位置。', '0');
INSERT INTO `com_tf_question` VALUES ('304', '10000000', '第三章', '2', '链队列的出队操作总是需要修改尾指针。', '0');
INSERT INTO `com_tf_question` VALUES ('305', '10000000', '第三章', '2', '栈和队列都是顺序存取的线性表, 但它们对存取位置的限制不同。', '1');
INSERT INTO `com_tf_question` VALUES ('306', '10000000', '第三章', '2', '链队列的出队操作总是需要修改尾指针。', '0');
INSERT INTO `com_tf_question` VALUES ('307', '10000000', '第三章', '1', '队列是一种插入与删除操作分别在表的两端进行的线性表，是一种先进后出型结构。', '0');
INSERT INTO `com_tf_question` VALUES ('308', '10000000', '第三章', '2', '通常使用队列来处理函数或过程的调用。', '0');
INSERT INTO `com_tf_question` VALUES ('309', '10000000', '第三章', '2', '循环队列通常用指针来实现队列的头尾相接。', '0');
INSERT INTO `com_tf_question` VALUES ('310', '10000000', '第三章', '2', ' 循环队列也存在空间溢出问题。', '1');
INSERT INTO `com_tf_question` VALUES ('311', '10000000', '第九章', '2', '折半查找既适用于有序表，也适用于无序表。（    ）', '0');
INSERT INTO `com_tf_question` VALUES ('312', '10000000', '第九章', '2', '折半查找既适用于顺序存储结构，也适用于链式存储结构。（ ）', '0');
INSERT INTO `com_tf_question` VALUES ('314', '10000000', '第九章', '2', ' 顺序查找法适用于存储结构为顺序或链接存储的线性表。(  )', '1');
INSERT INTO `com_tf_question` VALUES ('315', '10000000', '第九章', '2', ' 在索引顺序结构的搜索中，对索引表既可以采取顺序搜索，也可以采用折半搜索。(  )', '1');
INSERT INTO `com_tf_question` VALUES ('316', '10000000', '第九章', '3', ' 在索引顺序结构上实施分块搜索，在等概率情况下，其平均搜索长度不仅与子表个数有关，而且与每一个子表中的对象个数有关。(  )', '1');
INSERT INTO `com_tf_question` VALUES ('317', '10000000', '第九章', '1', ' 顺序查找法适用于存储结构为顺序或链接存储的线性表。（   　）', '1');
INSERT INTO `com_tf_question` VALUES ('318', '10000000', '第九章', '1', ' 能够在链接存储的有序表上进行折半查找，其时间复杂度与在顺序存储的有序表上相同。(  )', '0');
INSERT INTO `com_tf_question` VALUES ('319', '10000000', '第九章', '2', ' 进行折半查找的表必须是顺序存储的有序表。(  )', '1');
INSERT INTO `com_tf_question` VALUES ('320', '10000000', '第九章', '3', '给出不同的输入序列建造二叉排序树，一定得到不同的二叉排序树。', '0');
INSERT INTO `com_tf_question` VALUES ('321', '10000000', '第九章', '2', '平衡二叉树中所有结点的平衡因子都不超过1。（  ）', '1');
INSERT INTO `com_tf_question` VALUES ('322', '10000000', '第九章', '2', ' 对平衡二叉树进行中根遍历，可得到结点的有序排列。（  ）', '1');
INSERT INTO `com_tf_question` VALUES ('324', '10000000', '第九章', '2', ' 对于同一组记录，生成二叉排序树的形态与插入记录的次序无关。(  )', '0');
INSERT INTO `com_tf_question` VALUES ('325', '10000000', '第九章', '2', '对于两棵具有相同记录集合而具有不同形态的二叉排序树，按中序遍历得到的结点序列是相同的。(  )', '1');
INSERT INTO `com_tf_question` VALUES ('326', '10000000', '第九章', '2', '对平衡二叉树进行中根遍历，可得到结点的有序序列。（  　）', '1');
INSERT INTO `com_tf_question` VALUES ('328', '10000000', '第九章', '2', '在二叉排序树中插入新结点时，新结点总是作为叶子结点插入。（  　）', '1');
INSERT INTO `com_tf_question` VALUES ('330', '10000000', '第九章', '1', ' 哈希查找法中解决冲突问题的常用方法是除留余数法。（  ）', '0');
INSERT INTO `com_tf_question` VALUES ('331', '10000000', '第九章', '2', ' 装载因子是散列表的一个重要参数，它反映了散列表的装满程度。(  )', '1');
INSERT INTO `com_tf_question` VALUES ('332', '10000000', '第九章', '2', '  对于同一组关键码互不相同的记录，若生成二叉排序树时插入记录的次序不同，则得到不同形态的二叉排序树。(  )', '1');
INSERT INTO `com_tf_question` VALUES ('333', '10000000', '第九章', '3', ' 理想情况下哈希查找的等概率查找成功的平均查找长度是O（1）。(  )', '1');
INSERT INTO `com_tf_question` VALUES ('335', '10000000', '第六章', '1', '如果二叉树中某结点的度为1，则说该结点只有一棵子树。', '1');
INSERT INTO `com_tf_question` VALUES ('338', '10000000', '第六章', '3', '先序遍历序列与中序遍历序列相同的二叉树只能是右单支树。', '1');
INSERT INTO `com_tf_question` VALUES ('341', '10000000', '第六章', '2', '若一棵二叉树中的结点均无右孩子，则该二叉树的中根遍历和后根遍历序列正好相反。', '0');
INSERT INTO `com_tf_question` VALUES ('344', '10000000', '第六章', '2', '在一棵二叉树中，假定每个结点只有左子女，没有右子女，对它分别进行前序遍历和中根遍历，则具有相同的结果。', '0');
INSERT INTO `com_tf_question` VALUES ('346', '10000000', '第六章', '3', '完全二叉树的某结点若无左孩子，则它必是叶结点。', '1');
INSERT INTO `com_tf_question` VALUES ('347', '10000000', '第六章', '2', '二叉树中每个结点的两棵子树的高度差等于1。', '0');
INSERT INTO `com_tf_question` VALUES ('351', '10000000', '第六章', '2', '1．	对森林的中序遍历序列与其对应的二叉树的中序遍历序列相同。', '1');
INSERT INTO `com_tf_question` VALUES ('352', '10000000', '第六章', '2', '2．	一个森林与一棵二叉树的转换是唯一的。', '1');
INSERT INTO `com_tf_question` VALUES ('358', '10000000', '第六章', '2', '存在这样的二叉树，对它采用任何次序的遍历，结果相同。', '1');
INSERT INTO `com_tf_question` VALUES ('360', '10000000', '第七章', '2', '一个无向连通图的生成树是图的极小的连通子图。（  ）', '1');
INSERT INTO `com_tf_question` VALUES ('367', '10000000', '第七章', '1', '一个连通网的最小生成树是唯一的。', '0');
INSERT INTO `com_tf_question` VALUES ('368', '10000000', '第七章', '2', '连通图上各边权值均不相同，则该图的最小生成树是唯一的。（     ）', '1');
INSERT INTO `com_tf_question` VALUES ('369', '10000000', '第七章', '1', '一个网（带权图）都有唯一的最小生成树。（    ）', '0');
INSERT INTO `com_tf_question` VALUES ('371', '10000000', '第七章', '2', '不同的求最小生成树的方法最后得到的生成树是相同的.（     ）', '0');
INSERT INTO `com_tf_question` VALUES ('372', '10000000', '第七章', '2', '采用不同的遍历方法，所得到的无向图的生成树是不同的。（  ）', '1');
INSERT INTO `com_tf_question` VALUES ('373', '10000000', '第七章', '2', '对一个连通图进行一次深度优先搜索可以遍访图中的所有顶点。(        )', '1');
INSERT INTO `com_tf_question` VALUES ('374', '10000000', '第七章', '2', '图的广度优先搜索算法通常采用非递归算法求解。(  )', '1');
INSERT INTO `com_tf_question` VALUES ('375', '10000000', '第七章', '2', '采用不同的遍历方法，所得到的无向图的生成树总是相同的。（  　）', '0');
INSERT INTO `com_tf_question` VALUES ('376', '10000000', '第七章', '3', '图的深度优先搜索是一种典型的回溯搜索的例子，可以通过递归算法求解。(  )', '1');
INSERT INTO `com_tf_question` VALUES ('377', '10000000', '第七章', '3', '需要借助于一个队列来实现图的深度遍历算法。（   ）', '0');
INSERT INTO `com_tf_question` VALUES ('378', '10000000', '第七章', '3', '图的广度优先搜索类似于树的按层次遍历。（     ）', '1');
INSERT INTO `com_tf_question` VALUES ('379', '10000000', '第七章', '2', '边数很多的稠密图，适宜用邻接表表示。（  ）', '0');
INSERT INTO `com_tf_question` VALUES ('380', '10000000', '第七章', '2', '存储无向图的邻接矩阵是对称的，因此可以只存储邻接矩阵的下（上）三角部分。(  )', '1');
INSERT INTO `com_tf_question` VALUES ('381', '10000000', '第七章', '2', ' 邻接表只能用于有向图的存储，邻接矩阵对于有向图和无向图的存储都适用。(     )', '0');
INSERT INTO `com_tf_question` VALUES ('382', '10000000', '第七章', '2', '邻接矩阵适用于稠密图（边数接近于顶点数的平方），邻接表适用于稀疏图（边数远小于顶点数的平方）。', '1');
INSERT INTO `com_tf_question` VALUES ('383', '10000000', '第七章', '2', '用邻接矩阵存储一个图时，在不考虑压缩存储的情况下，所占用的存储空间大小只与图中顶点数有关', '1');
INSERT INTO `com_tf_question` VALUES ('384', '10000000', '第七章', '2', '一个有向图的邻接表和逆邻接表中结点的个数可能不等。（    ）', '0');
INSERT INTO `com_tf_question` VALUES ('385', '10000000', '第七章', '2', '无向图的邻接矩阵一定是对称矩阵，有向图的邻接矩阵一定是非对称矩阵。（    ）', '0');
INSERT INTO `com_tf_question` VALUES ('386', '10000000', '第七章', '2', '有n个顶点的无向图, 采用邻接矩阵表示, 图中的边数等于邻接矩阵中非零元素之和的一半。（      ）', '1');
INSERT INTO `com_tf_question` VALUES ('387', '10000000', '第七章', '2', '用邻接矩阵法存储一个图所需的存储单元数目与图的边数有关。（    ）', '0');
INSERT INTO `com_tf_question` VALUES ('389', '10000000', '第七章', '1', '有向图中顶点V的度等于其邻接矩阵中第V行中的1的个数。（    ）', '0');
INSERT INTO `com_tf_question` VALUES ('390', '10000000', '第七章', '2', '有e条边的无向图，在邻接表中有e个表结点。（     ）', '0');
INSERT INTO `com_tf_question` VALUES ('391', '10000000', '第七章', '2', '有向图用邻接矩阵表示后，顶点i的入度等于邻接矩阵中第i列的元素之和。（）', '1');
INSERT INTO `com_tf_question` VALUES ('392', '10000000', '第七章', '2', '对于一个有向图的逆邻接表，第i个链表中的结点个数为顶点vi的出度。', '0');
INSERT INTO `com_tf_question` VALUES ('393', '10000000', '第七章', '2', '有向图用邻接表表示后，顶点i的出度等于邻接表中第i个单链表中结点个数。(         )', '1');
INSERT INTO `com_tf_question` VALUES ('394', '10000000', '第七章', '2', '有向图用邻接表表示，邻接表中第i个单链表中结点个数等于顶点i的入度。(      )', '0');
INSERT INTO `com_tf_question` VALUES ('395', '10000000', '第七章', '3', '有向图的邻接矩阵一定是不对称的。（    ）', '0');
INSERT INTO `com_tf_question` VALUES ('396', '10000000', '第七章', '2', '强连通图的各顶点间均可达。（     ）', '1');
INSERT INTO `com_tf_question` VALUES ('397', '10000000', '第七章', '3', '在n个结点的无向图中，若边数等于n-1,则该图必是连通图。（  ） ', '0');
INSERT INTO `com_tf_question` VALUES ('398', '10000000', '第七章', '2', '图中各个顶点的编号是人为的，不是它本身固有的，因此可以根据需要进行改变。(  )', '1');
INSERT INTO `com_tf_question` VALUES ('399', '10000000', '第七章', '2', '在一个有向图中，所有顶点的入度之和等于所有顶点的出度之和。（  ）', '1');
INSERT INTO `com_tf_question` VALUES ('401', '10000000', '第七章', '1', '强连通分量是有向图中的极大强连通子图。(  )', '1');
INSERT INTO `com_tf_question` VALUES ('402', '10000000', '第七章', '2', '边数很少的稀疏图，适宜用邻接表表示。（  ）', '1');
INSERT INTO `com_tf_question` VALUES ('403', '10000000', '第七章', '2', '边数很多的稠密图，适宜用邻接矩阵表示。（  ）', '1');
