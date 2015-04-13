/*
 Navicat MySQL Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 50614
 Source Host           : localhost
 Source Database       : TRMS

 Target Server Type    : MySQL
 Target Server Version : 50614
 File Encoding         : utf-8

 Date: 04/13/2015 17:16:02 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `alembic_version`
-- ----------------------------
DROP TABLE IF EXISTS `alembic_version`;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `alembic_version`
-- ----------------------------
BEGIN;
INSERT INTO `alembic_version` VALUES ('36659af78edd');
COMMIT;

-- ----------------------------
--  Table structure for `attribute`
-- ----------------------------
DROP TABLE IF EXISTS `attribute`;
CREATE TABLE `attribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `cite`
-- ----------------------------
DROP TABLE IF EXISTS `cite`;
CREATE TABLE `cite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `literature_id` int(11) NOT NULL,
  `cited_id` int(11) NOT NULL,
  `cite_type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cite_type_id` (`cite_type_id`),
  KEY `cited_id` (`cited_id`),
  KEY `literature_id` (`literature_id`),
  CONSTRAINT `cite_ibfk_1` FOREIGN KEY (`cite_type_id`) REFERENCES `type` (`id`),
  CONSTRAINT `cite_ibfk_2` FOREIGN KEY (`cited_id`) REFERENCES `literature_meta` (`id`),
  CONSTRAINT `cite_ibfk_3` FOREIGN KEY (`literature_id`) REFERENCES `literature_meta` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `code`
-- ----------------------------
DROP TABLE IF EXISTS `code`;
CREATE TABLE `code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(256) COLLATE utf8_bin NOT NULL,
  `creator_id` int(11) NOT NULL,
  `updater_id` int(11) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime DEFAULT NULL,
  `description` text COLLATE utf8_bin,
  `size` float DEFAULT NULL,
  `uri` varchar(256) COLLATE utf8_bin NOT NULL,
  `language` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `file_name` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `rank_num` int(11) DEFAULT NULL,
  `total_rank` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `updater_id` (`updater_id`),
  CONSTRAINT `code_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`),
  CONSTRAINT `code_ibfk_2` FOREIGN KEY (`updater_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `code`
-- ----------------------------
BEGIN;
INSERT INTO `code` VALUES ('1', 'first code', '1', null, '2015-04-07 21:07:40', null, 'lalalla', '0', '', '', null, '0', '0');
COMMIT;

-- ----------------------------
--  Table structure for `code_literature`
-- ----------------------------
DROP TABLE IF EXISTS `code_literature`;
CREATE TABLE `code_literature` (
  `code_id` int(11) NOT NULL,
  `literature_id` int(11) NOT NULL,
  PRIMARY KEY (`code_id`,`literature_id`),
  KEY `literature_id` (`literature_id`),
  CONSTRAINT `code_literature_ibfk_1` FOREIGN KEY (`code_id`) REFERENCES `code` (`id`),
  CONSTRAINT `code_literature_ibfk_2` FOREIGN KEY (`literature_id`) REFERENCES `literature_meta` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `comment`
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `commenter_id` int(11) NOT NULL,
  `resource_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `content` text COLLATE utf8_bin,
  `star` int(11) NOT NULL,
  `comment_time` datetime NOT NULL,
  `is_simple` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `commenter_id` (`commenter_id`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`commenter_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `comment`
-- ----------------------------
BEGIN;
INSERT INTO `comment` VALUES ('1', '1', '3', '1', 'good article', '3', '2015-04-09 14:29:30', '1'), ('2', '1', '3', '1', '1&2&3', '3', '2015-04-09 14:40:36', '0'), ('3', '1', '2', '1', 'mkmkm', '3', '2015-04-09 16:51:00', '1'), ('4', '1', '2', '1', 'sdfsdf', '3', '2015-04-09 16:52:21', '1'), ('5', '1', '2', '1', 'jkjkjkjkjkj', '3', '2015-04-09 17:31:49', '1'), ('6', '1', '2', '1', 'jkjkjkjk999', '3', '2015-04-09 17:58:07', '1'), ('7', '1', '2', '1', 'm,m,m,m', '3', '2015-04-09 19:46:10', '1'), ('8', '1', '2', '1', 'kjkjk&ouoio&tyty', '3', '2015-04-09 19:46:10', '0'), ('9', '1', '2', '1', 'kjkjk&jkjkj&m,m,', '3', '2015-04-09 19:46:10', '0'), ('10', '1', '2', '1', 'kkk', '3', '2015-04-09 19:46:10', '1'), ('11', '1', '2', '1', '.,.,', '3', '2015-04-09 19:49:55', '1'), ('12', '1', '2', '1', 'iiii', '3', '2015-04-09 19:49:55', '1'), ('13', '1', '2', '1', 'kklk', '3', '2015-04-09 19:56:27', '1'), ('14', '1', '2', '1', 'jkjkjkjkjkjk', '3', '2015-04-09 19:56:32', '1'), ('15', '1', '2', '1', '挺好的&蛮赞的&不错哦', '3', '2015-04-09 20:00:01', '0'), ('16', '1', '2', '1', '这是一首简单的小情歌', '3', '2015-04-09 20:01:55', '1'), ('17', '1', '2', '1', '唱着我们心头的白哥', '3', '2015-04-09 20:04:20', '1'), ('18', '1', '2', '1', '想留不能留', '3', '2015-04-09 20:33:57', '1'), ('19', '1', '2', '1', '才最寂寞&没说完温柔&只剩李哥', '5', '2015-04-09 20:35:05', '0'), ('20', '1', '4', '1', '呵呵哒', '1', '2015-04-09 20:47:21', '1'), ('21', '1', '1', '3', '这样也能行？', '4', '2015-04-09 20:52:22', '1'), ('22', '1', '1', '3', '怎么回事啊。。。', '2', '2015-04-09 20:57:11', '1'), ('23', '1', '1', '3', 'skdlfksldkfsdf', '3', '2015-04-09 21:14:39', '1'), ('24', '1', '1', '2', '数据库地方就开始将对方', '3', '2015-04-09 21:30:13', '1'), ('25', '1', '5', '1', '挺不错的！', '3', '2015-04-12 13:03:46', '1'), ('26', '1', '5', '1', '数据可靠&论证详细&实验有说服力', '4', '2015-04-12 13:10:45', '0'), ('27', '1', '5', '1', '好的好的', '5', '2015-04-12 15:19:12', '1');
COMMIT;

-- ----------------------------
--  Table structure for `data_set`
-- ----------------------------
DROP TABLE IF EXISTS `data_set`;
CREATE TABLE `data_set` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(256) COLLATE utf8_bin NOT NULL,
  `creator_id` int(11) NOT NULL,
  `updater_id` int(11) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime DEFAULT NULL,
  `description` text COLLATE utf8_bin,
  `size` float DEFAULT NULL,
  `uri` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `data_set_type_id` int(11) NOT NULL,
  `file_name` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `rank_num` int(11) DEFAULT NULL,
  `total_rank` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `data_set_type_id` (`data_set_type_id`),
  KEY `updater_id` (`updater_id`),
  CONSTRAINT `data_set_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`),
  CONSTRAINT `data_set_ibfk_2` FOREIGN KEY (`data_set_type_id`) REFERENCES `type` (`id`),
  CONSTRAINT `data_set_ibfk_3` FOREIGN KEY (`updater_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `data_set`
-- ----------------------------
BEGIN;
INSERT INTO `data_set` VALUES ('1', 'great pic', '1', null, '2015-04-07 21:26:50', null, '', '2000', '', '3', null, '0', '0');
COMMIT;

-- ----------------------------
--  Table structure for `data_set_literature`
-- ----------------------------
DROP TABLE IF EXISTS `data_set_literature`;
CREATE TABLE `data_set_literature` (
  `data_set_id` int(11) NOT NULL,
  `literature_id` int(11) NOT NULL,
  PRIMARY KEY (`data_set_id`,`literature_id`),
  KEY `literature_id` (`literature_id`),
  CONSTRAINT `data_set_literature_ibfk_1` FOREIGN KEY (`data_set_id`) REFERENCES `data_set` (`id`),
  CONSTRAINT `data_set_literature_ibfk_2` FOREIGN KEY (`literature_id`) REFERENCES `literature_meta` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `favorite`
-- ----------------------------
DROP TABLE IF EXISTS `favorite`;
CREATE TABLE `favorite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `favorite_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `favorite_resource`
-- ----------------------------
DROP TABLE IF EXISTS `favorite_resource`;
CREATE TABLE `favorite_resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resource_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `favorite_id` int(11) NOT NULL,
  `favorite_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `favorite_id` (`favorite_id`),
  CONSTRAINT `favorite_resource_ibfk_1` FOREIGN KEY (`favorite_id`) REFERENCES `favorite` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `literature_meta`
-- ----------------------------
DROP TABLE IF EXISTS `literature_meta`;
CREATE TABLE `literature_meta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(256) COLLATE utf8_bin NOT NULL,
  `titleCN` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `abstract` text COLLATE utf8_bin,
  `abstractCN` text COLLATE utf8_bin,
  `author` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `authorCN` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `published_year` int(11) DEFAULT NULL,
  `publisher` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `publisherCN` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `key_words` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `key_words_CN` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `location` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `institute` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `instructor` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `language` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `pages` int(11) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  `issue` int(11) DEFAULT NULL,
  `section` int(11) DEFAULT NULL,
  `edition` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `press` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `editor` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `ISBN` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `ISSN` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `DOI` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `uri` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `creator_id` int(11) NOT NULL,
  `updater_id` int(11) DEFAULT NULL,
  `literature_type_id` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime DEFAULT NULL,
  `file_name` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `rank_num` int(11) DEFAULT NULL,
  `total_rank` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `literature_type_id` (`literature_type_id`),
  KEY `updater_id` (`updater_id`),
  CONSTRAINT `literature_meta_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`),
  CONSTRAINT `literature_meta_ibfk_2` FOREIGN KEY (`literature_type_id`) REFERENCES `type` (`id`),
  CONSTRAINT `literature_meta_ibfk_3` FOREIGN KEY (`updater_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `literature_meta`
-- ----------------------------
BEGIN;
INSERT INTO `literature_meta` VALUES ('2', 'My very first article', '我的第一篇文章', 'This is the first article', 'C.Wang的第一篇文章', 'C.Wang', '王晨', '2014', 'Nanjing University', '南京大学', '', '', '', '', '', '', '0', '0', '0', '0', '', '', '', '', '', '', '/uploaded/p19i9iisutm33vr2ne8jrq1m707.pdf', '1', '1', '1', '2015-04-07 17:08:36', '2015-04-07 17:08:36', null, '0', '0'), ('3', 'This is for testing add..', '', '', '', 'chen wong', '', '0', '', '', '', '', '', '', '', '', '0', '0', '0', '0', '', '', '', '', '', '', '', '1', '1', '2', '2015-04-08 17:42:29', '2015-04-08 21:51:28', '', '0', '0'), ('4', 'meeting', '这是一篇会议论文', '', '', 'cc', '', '0', '', '', '', '', '', '', '', '', '0', '0', '0', '0', '', '', '', '', '', '', '', '1', '1', '2', '2015-04-08 21:14:25', '2015-04-08 21:51:28', '', '0', '0'), ('5', 'Bug Inducing Analysis to Prevent Fault Prone Bug Fixes', '通过对程序中引入的错误分析来预防易注入错误的错误修复', 'Bug fix is an important and challenging task in software development and maintenance. Bug fix is also a dangerous change, because it might induce new bugs. It is difficult to decide whether a bug fix is safe in practice. In this paper, we conducted an empirical study on bug inducing analysis to discover the types and features of fault prone bug fixes. We use a classical algorithm to track the location of the code changes introducing the bugs. The change types of the codes will be checked by an automatic tool and whether this change is a bug fix change is recorded. We analyze the statistics to find out what types of change are most prone to induce new bugs when they are intended to fix a bug. Finally, some guidelines are provided to help developers prevent such fault prone bug fixes.', '这是中文摘要', 'Haoyu Yang, Chen Wang, Qingkai Shi, Yang Feng, Zhenyu Chen', '杨皓宇，王晨，时清凯，冯洋，陈振宇', '2014', 'SEKE', '', 'bug inducing, bug fix, mining software repository, software maintenance', '错误注入，错误修复，程序修复，数据挖掘', 'Toronto', 'State Key Laboratory for Novel Software Technology, Nanjing University', 'Zhenyu Chen', 'English', '6', '0', '0', '0', '', '', '', '', '', '', '/uploaded/p19im0jorf13e61267177hupf1squ7.pdf', '1', '1', '2', '2015-04-08 21:17:47', '2015-04-12 15:19:00', '', '0', '0');
COMMIT;

-- ----------------------------
--  Table structure for `ppt`
-- ----------------------------
DROP TABLE IF EXISTS `ppt`;
CREATE TABLE `ppt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `literature_id` int(11) DEFAULT NULL,
  `size` float DEFAULT NULL,
  `uri` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `ppt_name` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `literature_id` (`literature_id`),
  CONSTRAINT `ppt_ibfk_1` FOREIGN KEY (`literature_id`) REFERENCES `literature_meta` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `ppt`
-- ----------------------------
BEGIN;
INSERT INTO `ppt` VALUES ('1', '2', '4335810', '/uploadedPpt/p19i9ikdbkgg41lpv1jtgnhvff13.ppt', null), ('2', '5', '1755570', '/uploadedPpt/p19im0me4d1ds43m1jrbpg8otm13.ppt', '');
COMMIT;

-- ----------------------------
--  Table structure for `report`
-- ----------------------------
DROP TABLE IF EXISTS `report`;
CREATE TABLE `report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(256) COLLATE utf8_bin NOT NULL,
  `report_date` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `reporter` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `company` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `reporter_title` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `location` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `creator_id` int(11) NOT NULL,
  `updater_id` int(11) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime DEFAULT NULL,
  `total_rank` int(11) DEFAULT NULL,
  `rank_num` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `updater_id` (`updater_id`),
  CONSTRAINT `report_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`),
  CONSTRAINT `report_ibfk_2` FOREIGN KEY (`updater_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `report_attachment`
-- ----------------------------
DROP TABLE IF EXISTS `report_attachment`;
CREATE TABLE `report_attachment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `report_id` int(11) DEFAULT NULL,
  `uri` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `attachment_name` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `report_id` (`report_id`),
  CONSTRAINT `report_attachment_ibfk_1` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `report_code`
-- ----------------------------
DROP TABLE IF EXISTS `report_code`;
CREATE TABLE `report_code` (
  `report_id` int(11) NOT NULL,
  `code_id` int(11) NOT NULL,
  PRIMARY KEY (`report_id`,`code_id`),
  KEY `code_id` (`code_id`),
  CONSTRAINT `report_code_ibfk_1` FOREIGN KEY (`code_id`) REFERENCES `code` (`id`),
  CONSTRAINT `report_code_ibfk_2` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `report_data_set`
-- ----------------------------
DROP TABLE IF EXISTS `report_data_set`;
CREATE TABLE `report_data_set` (
  `report_id` int(11) NOT NULL,
  `data_set_id` int(11) NOT NULL,
  PRIMARY KEY (`report_id`,`data_set_id`),
  KEY `data_set_id` (`data_set_id`),
  CONSTRAINT `report_data_set_ibfk_1` FOREIGN KEY (`data_set_id`) REFERENCES `data_set` (`id`),
  CONSTRAINT `report_data_set_ibfk_2` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `report_literature`
-- ----------------------------
DROP TABLE IF EXISTS `report_literature`;
CREATE TABLE `report_literature` (
  `report_id` int(11) NOT NULL,
  `literature_id` int(11) NOT NULL,
  PRIMARY KEY (`report_id`,`literature_id`),
  KEY `literature_id` (`literature_id`),
  CONSTRAINT `report_literature_ibfk_1` FOREIGN KEY (`literature_id`) REFERENCES `literature_meta` (`id`),
  CONSTRAINT `report_literature_ibfk_2` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `report_recording`
-- ----------------------------
DROP TABLE IF EXISTS `report_recording`;
CREATE TABLE `report_recording` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `report_id` int(11) DEFAULT NULL,
  `uri` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `recording_name` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `report_id` (`report_id`),
  CONSTRAINT `report_recording_ibfk_1` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `tag`
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `tag_resource`
-- ----------------------------
DROP TABLE IF EXISTS `tag_resource`;
CREATE TABLE `tag_resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resource_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tag_id` (`tag_id`),
  CONSTRAINT `tag_resource_ibfk_1` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Table structure for `type`
-- ----------------------------
DROP TABLE IF EXISTS `type`;
CREATE TABLE `type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  `type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `type`
-- ----------------------------
BEGIN;
INSERT INTO `type` VALUES ('1', '期刊', '1'), ('2', '会议', '1'), ('3', '图片', '2'), ('4', '数据', '2');
COMMIT;

-- ----------------------------
--  Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) COLLATE utf8_bin NOT NULL,
  `password` varchar(32) COLLATE utf8_bin NOT NULL,
  `privilege` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `user`
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES ('1', 'chen', '123', '0');
COMMIT;

-- ----------------------------
--  Table structure for `video`
-- ----------------------------
DROP TABLE IF EXISTS `video`;
CREATE TABLE `video` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `literature_id` int(11) DEFAULT NULL,
  `size` float DEFAULT NULL,
  `uri` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `video_name` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `literature_id` (`literature_id`),
  CONSTRAINT `video_ibfk_1` FOREIGN KEY (`literature_id`) REFERENCES `literature_meta` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `video`
-- ----------------------------
BEGIN;
INSERT INTO `video` VALUES ('1', '2', '26618700', '/uploadedVideo/p19i9ijmaqedd1bn18jb2921t989.MP4', null), ('2', '2', '45919000', '/uploadedVideo/p19ibt0h91ed31gsk1btpb1g1j1g7.mp4', ''), ('3', '5', '26618600', '/uploadedVideo/p19im0kt2g1nk6jcsfi0l6q8mc9.MP4', ''), ('4', '5', '61581300', '/uploadedVideo/p19im7t41b6491m0i44kul1i8j7.mp4', '');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
