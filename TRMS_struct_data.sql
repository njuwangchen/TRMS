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

 Date: 04/07/2015 16:58:50 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `alembic_version`
-- ----------------------------
DROP TABLE IF EXISTS `alembic_version`;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Records of `alembic_version`
-- ----------------------------
BEGIN;
INSERT INTO `alembic_version` VALUES ('2a1716dd9363');
COMMIT;

-- ----------------------------
--  Table structure for `attribute`
-- ----------------------------
DROP TABLE IF EXISTS `attribute`;
CREATE TABLE `attribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

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
  KEY `cited_id` (`cited_id`),
  KEY `literature_id` (`literature_id`),
  KEY `cite_type_id` (`cite_type_id`),
  CONSTRAINT `cite_ibfk_1` FOREIGN KEY (`cited_id`) REFERENCES `literature_meta` (`id`),
  CONSTRAINT `cite_ibfk_2` FOREIGN KEY (`literature_id`) REFERENCES `literature_meta` (`id`),
  CONSTRAINT `cite_ibfk_3` FOREIGN KEY (`cite_type_id`) REFERENCES `type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Records of `cite`
-- ----------------------------
BEGIN;
INSERT INTO `cite` VALUES ('1', '1', '2', '3');
COMMIT;

-- ----------------------------
--  Table structure for `code`
-- ----------------------------
DROP TABLE IF EXISTS `code`;
CREATE TABLE `code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(256) NOT NULL,
  `creator_id` int(11) NOT NULL,
  `updater_id` int(11) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime DEFAULT NULL,
  `description` mediumtext,
  `size` float DEFAULT NULL,
  `uri` varchar(256) NOT NULL,
  `language` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `updater_id` (`updater_id`),
  CONSTRAINT `code_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`),
  CONSTRAINT `code_ibfk_2` FOREIGN KEY (`updater_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Records of `code`
-- ----------------------------
BEGIN;
INSERT INTO `code` VALUES ('1', 'Datamining with R', '1', '1', '2015-03-09 21:00:20', '2015-03-24 21:00:25', 'sample code implemention for frequent pattern mining', '20', 'http://iamcode', 'R');
COMMIT;

-- ----------------------------
--  Table structure for `code_literature`
-- ----------------------------
DROP TABLE IF EXISTS `code_literature`;
CREATE TABLE `code_literature` (
  `code_id` int(11) NOT NULL DEFAULT '0',
  `literature_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`code_id`,`literature_id`),
  KEY `literature_id` (`literature_id`),
  CONSTRAINT `code_literature_ibfk_1` FOREIGN KEY (`code_id`) REFERENCES `code` (`id`),
  CONSTRAINT `code_literature_ibfk_2` FOREIGN KEY (`literature_id`) REFERENCES `literature_meta` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT;

-- ----------------------------
--  Records of `code_literature`
-- ----------------------------
BEGIN;
INSERT INTO `code_literature` VALUES ('1', '1');
COMMIT;

-- ----------------------------
--  Table structure for `comment`
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `commenter_id` int(11) NOT NULL,
  `resource_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `content` mediumtext,
  `star` int(11) NOT NULL,
  `comment_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `commenter_id` (`commenter_id`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`commenter_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Records of `comment`
-- ----------------------------
BEGIN;
INSERT INTO `comment` VALUES ('1', '1', '1', '1', 'good paper', '4', '2015-03-24 21:21:10');
COMMIT;

-- ----------------------------
--  Table structure for `data_set`
-- ----------------------------
DROP TABLE IF EXISTS `data_set`;
CREATE TABLE `data_set` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(256) NOT NULL,
  `creator_id` int(11) NOT NULL,
  `updater_id` int(11) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime DEFAULT NULL,
  `description` mediumtext,
  `size` float DEFAULT NULL,
  `uri` varchar(256) DEFAULT NULL,
  `data_set_type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `data_set_type_id` (`data_set_type_id`),
  KEY `updater_id` (`updater_id`),
  CONSTRAINT `data_set_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`),
  CONSTRAINT `data_set_ibfk_2` FOREIGN KEY (`data_set_type_id`) REFERENCES `type` (`id`),
  CONSTRAINT `data_set_ibfk_3` FOREIGN KEY (`updater_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Records of `data_set`
-- ----------------------------
BEGIN;
INSERT INTO `data_set` VALUES ('1', 'caltch101', '1', '1', '2015-03-24 21:16:52', '2015-03-24 21:16:55', 'image set', '3', 'http://iamcaltech101', '4'), ('2', 'nihao', '1', null, '2015-03-09 21:00:20', null, '', '0', '', '1');
COMMIT;

-- ----------------------------
--  Table structure for `data_set_literature`
-- ----------------------------
DROP TABLE IF EXISTS `data_set_literature`;
CREATE TABLE `data_set_literature` (
  `data_set_id` int(11) DEFAULT NULL,
  `literature_id` int(11) DEFAULT NULL,
  KEY `data_set_id` (`data_set_id`),
  KEY `literature_id` (`literature_id`),
  CONSTRAINT `data_set_literature_ibfk_1` FOREIGN KEY (`data_set_id`) REFERENCES `data_set` (`id`),
  CONSTRAINT `data_set_literature_ibfk_2` FOREIGN KEY (`literature_id`) REFERENCES `literature_meta` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Records of `data_set_literature`
-- ----------------------------
BEGIN;
INSERT INTO `data_set_literature` VALUES ('1', '1');
COMMIT;

-- ----------------------------
--  Table structure for `favorite`
-- ----------------------------
DROP TABLE IF EXISTS `favorite`;
CREATE TABLE `favorite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `favorite_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Records of `favorite`
-- ----------------------------
BEGIN;
INSERT INTO `favorite` VALUES ('1', '1', 'default');
COMMIT;

-- ----------------------------
--  Table structure for `favorite_resource`
-- ----------------------------
DROP TABLE IF EXISTS `favorite_resource`;
CREATE TABLE `favorite_resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resource_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `favorite_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `favorite_id` (`favorite_id`),
  CONSTRAINT `favorite_resource_ibfk_1` FOREIGN KEY (`favorite_id`) REFERENCES `favorite` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Records of `favorite_resource`
-- ----------------------------
BEGIN;
INSERT INTO `favorite_resource` VALUES ('1', '1', '1', '1');
COMMIT;

-- ----------------------------
--  Table structure for `literature_meta`
-- ----------------------------
DROP TABLE IF EXISTS `literature_meta`;
CREATE TABLE `literature_meta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(256) NOT NULL,
  `abstract` mediumtext,
  `author` varchar(256) DEFAULT NULL,
  `published_year` int(11) DEFAULT NULL,
  `key_words` varchar(256) DEFAULT NULL,
  `pages` int(11) DEFAULT NULL,
  `uri` varchar(256) DEFAULT NULL,
  `creator_id` int(11) NOT NULL,
  `updater_id` int(11) DEFAULT NULL,
  `literature_type_id` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime DEFAULT NULL,
  `DOI` varchar(256) DEFAULT NULL,
  `ISBN` varchar(256) DEFAULT NULL,
  `ISSN` varchar(256) DEFAULT NULL,
  `abstractCN` mediumtext,
  `authorCN` varchar(256) DEFAULT NULL,
  `edition` varchar(256) DEFAULT NULL,
  `editor` varchar(256) DEFAULT NULL,
  `institute` varchar(256) DEFAULT NULL,
  `instructor` varchar(256) DEFAULT NULL,
  `issue` int(11) DEFAULT NULL,
  `key_words_CN` varchar(256) DEFAULT NULL,
  `language` varchar(256) DEFAULT NULL,
  `location` varchar(256) DEFAULT NULL,
  `press` varchar(256) DEFAULT NULL,
  `publisher` varchar(256) DEFAULT NULL,
  `publisherCN` varchar(256) DEFAULT NULL,
  `section` int(11) DEFAULT NULL,
  `titleCN` varchar(256) DEFAULT NULL,
  `volume` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `literature_type_id` (`literature_type_id`),
  KEY `updater_id` (`updater_id`),
  CONSTRAINT `literature_meta_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`),
  CONSTRAINT `literature_meta_ibfk_2` FOREIGN KEY (`literature_type_id`) REFERENCES `type` (`id`),
  CONSTRAINT `literature_meta_ibfk_3` FOREIGN KEY (`updater_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Records of `literature_meta`
-- ----------------------------
BEGIN;
INSERT INTO `literature_meta` VALUES ('1', 'Frequent Pattern Mining', 'Frequent pattern mining has been a focused theme in data mining research for over a decade. Abundant literature has been dedicated to this research and tremendous progress has been made, ranging from efficient and scalable algorithms for frequent itemset mining in transaction databases to numerous research frontiers, such as sequential pattern mining, structured pattern mining, correlation mining, associative classification, and frequent pattern-based clustering, as well as their broad applications. In this article, we provide a brief overview of the current status of frequent pattern mining and discuss a few promising research directions. We believe that frequent pattern mining research has substantially broadened the scope of data analysis and will have deep impact on data mining methodologies and applications in the long run. However, there are still some challenging research issues that need to be solved before frequent pattern mining can claim a cornerstone approach in data mining applications.', 'Jiawei HAN', '2008', 'Frequent pattern mining', '20', '/uploaded/p19i791duh1radqa41csgtmm9e07.pdf', '1', '1', '1', '2015-03-24 20:57:18', '2015-04-07 13:41:24', 'jsldkjf89s8d9f9s8d9f8', '120120102012032', '123jk1j2k31k2312', '这是一段我胡乱写的中文摘要呼呼><', '韩家伟', '1.0', 'Tom Lee', 'University of Illinois - Urbana Shampane', null, '2', '模式识别，数据挖掘', 'English', 'USA', '南大', 'xxx', 'xx出版商', '3', '频繁模式挖掘', '1'), ('2', 'I am cited', 'cited.....', 'Jiawei Han', '2005', 'cited', '15', '/uploaded/gSpan1428150430515.pdf', '1', '1', '1', '2015-03-24 21:03:31', '2015-03-24 21:03:33', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null), ('3', 'testchin', 'testchin', 'a', null, null, null, null, '1', null, '2', '2015-03-31 14:41:35', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null), ('4', 'This is for testing add..', '', 'chen wong', '0', '', '0', '/uploaded/graph_mining1428151618800.pdf', '1', null, '1', '2015-03-31 16:43:35', null, '', '', '', '', '', '', '', '', '', '0', '', '', '', '', '', '', '0', '', '0'), ('5', 'Time consuming operation', '', 'Penny Lee', '0', '', '0', '', '1', null, '1', '2015-03-31 18:53:37', null, '', '', '', '', '', '', '', '', '', '0', '', '', '', '', '', '', '0', '', '0'), ('6', 'I want to go through the whole process', 'huhuhuh', 'Chen Wang', '2015', '', '0', '/uploaded/p19i7bth1c7s1lr9g9s10p5bscj.pdf', '1', null, '1', '2015-04-06 20:35:50', null, '', '', '', '呼呼噜噜', '王晨', '', '', '', '', '0', '', '', '', '', '', '', '0', '我想走一遍完整的流程', '0'), ('13', 'I do not know why', '', '', '0', '', '0', '', '1', null, '1', '2015-04-06 20:50:32', null, '', '', '', '', '', '', '', '', '', '0', '', '', '', '', '', '', '0', '', '0'), ('14', 'jkjkjkjkj', '', '', '0', '', '0', '', '1', null, '1', '2015-04-06 20:50:32', null, '', '', '', '', '', '', '', '', '', '0', '', '', '', '', '', '', '0', '', '0'), ('15', 'test for test', '', '', '0', '', '0', '', '1', null, '1', '2015-04-06 20:57:38', null, '', '', '', '', '', '', '', '', '', '0', '', '', '', '', '', '', '0', '', '0'), ('16', 'jkjljkjljkjlkjlkjljk', '', '', '0', '', '0', '', '1', null, '1', '2015-04-06 20:57:38', null, '', '', '', '', '', '', '', '', '', '0', '', '', '', '', '', '', '0', '', '0'), ('17', 'test scroll to top', '', '', '0', '', '0', '', '1', null, '1', '2015-04-06 21:34:02', null, '', '', '', '', '', '', '', '', '', '0', '', '', '', '', '', '', '0', '呵呵测试一下', '22'), ('18', 'let me try', '', 'chen', '0', '', '0', '', '1', '1', '1', '2015-04-06 21:39:25', '2015-04-06 21:47:17', '', '', '', '', '', '', '', '', '', '0', '', '', '', '', '', '', '0', '', '0');
COMMIT;

-- ----------------------------
--  Table structure for `ppt`
-- ----------------------------
DROP TABLE IF EXISTS `ppt`;
CREATE TABLE `ppt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `literature_id` int(11) DEFAULT NULL,
  `size` float DEFAULT NULL,
  `uri` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `literature_id` (`literature_id`),
  CONSTRAINT `ppt_ibfk_2` FOREIGN KEY (`literature_id`) REFERENCES `literature_meta` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Records of `ppt`
-- ----------------------------
BEGIN;
INSERT INTO `ppt` VALUES ('2', '1', '2293960', '/uploadedPpt/p19i7b76181rhs18ov1nl6131k3nk7.ppt'), ('3', '6', '1088530', '/uploadedPpt/p19i7bv5k5mrd1cr81udr1v4p1c271f.ppt');
COMMIT;

-- ----------------------------
--  Table structure for `tag`
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Records of `tag`
-- ----------------------------
BEGIN;
INSERT INTO `tag` VALUES ('1', 'like it'), ('2', 'pretty like it'), ('3', 'couldn\'t like it more');
COMMIT;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Records of `tag_resource`
-- ----------------------------
BEGIN;
INSERT INTO `tag_resource` VALUES ('1', '1', '3', '1');
COMMIT;

-- ----------------------------
--  Table structure for `type`
-- ----------------------------
DROP TABLE IF EXISTS `type`;
CREATE TABLE `type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Records of `type`
-- ----------------------------
BEGIN;
INSERT INTO `type` VALUES ('1', 'paper', '1'), ('2', 'book', '1'), ('3', 'mention', '3'), ('4', 'image', '2');
COMMIT;

-- ----------------------------
--  Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `password` varchar(32) NOT NULL,
  `privilege` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Records of `user`
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES ('1', 'test', '1111', '1');
COMMIT;

-- ----------------------------
--  Table structure for `video`
-- ----------------------------
DROP TABLE IF EXISTS `video`;
CREATE TABLE `video` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `literature_id` int(11) DEFAULT NULL,
  `size` float DEFAULT NULL,
  `uri` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `literature_id` (`literature_id`),
  CONSTRAINT `video_ibfk_2` FOREIGN KEY (`literature_id`) REFERENCES `literature_meta` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
--  Records of `video`
-- ----------------------------
BEGIN;
INSERT INTO `video` VALUES ('3', '1', '751105000', '/uploadedVideo/Rouge.1988.BDRip.x264.2AAC.MiniSD-Dream.mkv'), ('4', '1', '59947200', '/uploadedVideo/p19i79s1l5rgm11uko571uco17mc7.mp4'), ('5', '6', '26618700', '/uploadedVideo/p19i7bu5siqvn25c10l81f2g13mfl.MP4'), ('6', '1', '61581300', '/uploadedVideo/p19i97t8i81goi1eh11k371o5kstmd.mp4');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
