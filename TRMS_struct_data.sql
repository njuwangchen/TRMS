/*
 Navicat Premium Data Transfer

 Source Server         : MylocalDB
 Source Server Type    : MySQL
 Source Server Version : 50623
 Source Host           : localhost
 Source Database       : TRMS

 Target Server Type    : MySQL
 Target Server Version : 50623
 File Encoding         : utf-8

 Date: 05/06/2015 01:39:57 AM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `KB__conference`
-- ----------------------------
DROP TABLE IF EXISTS `KB__conference`;
CREATE TABLE `KB__conference` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`abbreviation` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
	`full` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=`InnoDB` AUTO_INCREMENT=3 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ROW_FORMAT=COMPACT COMMENT='' CHECKSUM=0 DELAY_KEY_WRITE=0;

-- ----------------------------
--  Records of `KB__conference`
-- ----------------------------
BEGIN;
INSERT INTO `KB__conference` VALUES ('1', 'aa', 'amerivan aa'), ('2', 'bb', 'bros pppp');
COMMIT;

-- ----------------------------
--  Table structure for `KB__conference__year`
-- ----------------------------
DROP TABLE IF EXISTS `KB__conference__year`;
CREATE TABLE `KB__conference__year` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`abbreviation` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
	`year` int(11) NOT NULL,
	`location` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
	`editor` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=`InnoDB` AUTO_INCREMENT=3 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ROW_FORMAT=COMPACT COMMENT='' CHECKSUM=0 DELAY_KEY_WRITE=0;

-- ----------------------------
--  Records of `KB__conference__year`
-- ----------------------------
BEGIN;
INSERT INTO `KB__conference__year` VALUES ('1', 'bb', '2003', 'new york', 'sunanzhi'), ('2', 'aa', '2003', 'madison', 'sdfsdfsdfsdfs');
COMMIT;

-- ----------------------------
--  Table structure for `KB__journal`
-- ----------------------------
DROP TABLE IF EXISTS `KB__journal`;
CREATE TABLE `KB__journal` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`abbreviation` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
	`full` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=`InnoDB` AUTO_INCREMENT=3 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ROW_FORMAT=COMPACT COMMENT='' CHECKSUM=0 DELAY_KEY_WRITE=0;

-- ----------------------------
--  Records of `KB__journal`
-- ----------------------------
BEGIN;
INSERT INTO `KB__journal` VALUES ('1', 'bb', 'jslkdjflkajlsdf'), ('2', 'aa', 'asdfsdfasdfa');
COMMIT;

-- ----------------------------
--  Table structure for `KB__journal__year__issue`
-- ----------------------------
DROP TABLE IF EXISTS `KB__journal__year__issue`;
CREATE TABLE `KB__journal__year__issue` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`abbreviation` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
	`year` int(11) NOT NULL,
	`issue` int(11) NOT NULL,
	`editor` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=`InnoDB` AUTO_INCREMENT=3 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ROW_FORMAT=COMPACT COMMENT='' CHECKSUM=0 DELAY_KEY_WRITE=0;

-- ----------------------------
--  Records of `KB__journal__year__issue`
-- ----------------------------
BEGIN;
INSERT INTO `KB__journal__year__issue` VALUES ('1', 'aa', '2003', '1', 'jskldjfklajlsdkjf'), ('2', 'bb', '2009', '2', 'askdjflskjdlkfja');
COMMIT;

-- ----------------------------
--  Table structure for `alembic_version`
-- ----------------------------
DROP TABLE IF EXISTS `alembic_version`;
CREATE TABLE `alembic_version` (
	`version_num` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL
) ENGINE=`InnoDB` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ROW_FORMAT=COMPACT COMMENT='' CHECKSUM=0 DELAY_KEY_WRITE=0;

-- ----------------------------
--  Records of `alembic_version`
-- ----------------------------
BEGIN;
INSERT INTO `alembic_version` VALUES ('300bdc5571f2');
COMMIT;

-- ----------------------------
--  Table structure for `attribute`
-- ----------------------------
DROP TABLE IF EXISTS `attribute`;
CREATE TABLE `attribute` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`name` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
	`type` int(11) NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=`InnoDB` AUTO_INCREMENT=30 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ROW_FORMAT=COMPACT COMMENT='' CHECKSUM=0 DELAY_KEY_WRITE=0;

-- ----------------------------
--  Records of `attribute`
-- ----------------------------
BEGIN;
INSERT INTO `attribute` VALUES ('1', '待评价', '2'), ('2', '待提高', '2'), ('3', '有点', '2'), ('4', '缺点', '2'), ('5', 'title', '1'), ('6', 'titleCN', '1'), ('7', 'abstract', '1'), ('8', 'abstractCN', '1'), ('9', 'author', '1'), ('10', 'authorCN', '1'), ('11', 'published_year', '1'), ('12', 'publisher', '1'), ('13', 'key_words', '1'), ('14', 'key_words_CN', '1'), ('15', 'location', '1'), ('16', 'institute', '1'), ('17', 'instructor', '1'), ('18', 'language', '1'), ('19', 'pages', '1'), ('20', 'volume', '1'), ('21', 'issue', '1'), ('22', 'section', '1'), ('23', 'edition', '1'), ('24', 'press', '1'), ('25', 'editor', '1'), ('26', 'ISBN', '1'), ('27', 'ISSN', '1'), ('28', 'DOI', '1'), ('29', 'uri', '1');
COMMIT;

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
	CONSTRAINT `cite_ibfk_1` FOREIGN KEY (`cite_type_id`) REFERENCES `type` (`id`),
	CONSTRAINT `cite_ibfk_2` FOREIGN KEY (`cited_id`) REFERENCES `literature_meta` (`id`),
	CONSTRAINT `cite_ibfk_3` FOREIGN KEY (`literature_id`) REFERENCES `literature_meta` (`id`),
	INDEX `cite_type_id` (`cite_type_id`) comment '',
	INDEX `cited_id` (`cited_id`) comment '',
	INDEX `literature_id` (`literature_id`) comment ''
) ENGINE=`InnoDB` AUTO_INCREMENT=19 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ROW_FORMAT=COMPACT COMMENT='' CHECKSUM=0 DELAY_KEY_WRITE=0;

-- ----------------------------
--  Records of `cite`
-- ----------------------------
BEGIN;
INSERT INTO `cite` VALUES ('14', '5', '2', '5'), ('18', '2', '3', '5');
COMMIT;

-- ----------------------------
--  Table structure for `code`
-- ----------------------------
DROP TABLE IF EXISTS `code`;
CREATE TABLE `code` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`title` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
	`creator_id` int(11) NOT NULL,
	`updater_id` int(11) DEFAULT NULL,
	`create_time` datetime NOT NULL,
	`update_time` datetime DEFAULT NULL,
	`description` text CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`size` float DEFAULT NULL,
	`uri` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
	`language` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`file_name` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`rank_num` int(11) DEFAULT NULL,
	`total_rank` int(11) DEFAULT NULL,
	`link` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`publisher` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`upload_history` text CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`from_literature_id` int(11) DEFAULT NULL,
	PRIMARY KEY (`id`),
	CONSTRAINT `code_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`),
	CONSTRAINT `code_ibfk_2` FOREIGN KEY (`updater_id`) REFERENCES `user` (`id`),
	CONSTRAINT `code_ibfk_3` FOREIGN KEY (`from_literature_id`) REFERENCES `literature_meta` (`id`),
	INDEX `creator_id` (`creator_id`) comment '',
	INDEX `updater_id` (`updater_id`) comment '',
	INDEX `from_literature_id` (`from_literature_id`) comment ''
) ENGINE=`InnoDB` AUTO_INCREMENT=4 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ROW_FORMAT=COMPACT COMMENT='' CHECKSUM=0 DELAY_KEY_WRITE=0;

-- ----------------------------
--  Records of `code`
-- ----------------------------
BEGIN;
INSERT INTO `code` VALUES ('1', 'first code', '1', '1', '2015-04-07 21:07:40', '2015-05-05 17:28:50', 0x6c616c616c6c61, '0', '', 'sdf', '', '0', '0', null, 'chen', 0x6e756c6c3b6c696e75785f73657475705f312e342e312e7a69702c7031396b63666533707531723937316c7532693837316a3662316d7475622e7a69702c31373531323537, '5'), ('2', 'this is yin wang\'s 14 rows code', '1', '1', '2015-04-15 18:29:41', '2015-04-20 14:22:34', 0x76657279206e696365, '0', '', 'ruby', '', '0', '0', null, null, null, null), ('3', 'this is yin wang\'s 14 rows code', '1', null, '2015-04-15 18:31:38', null, 0x76657279206e696365, '0', '', '', '', '0', '0', null, null, null, null);
COMMIT;

-- ----------------------------
--  Table structure for `code_literature`
-- ----------------------------
DROP TABLE IF EXISTS `code_literature`;
CREATE TABLE `code_literature` (
	`code_id` int(11) NOT NULL,
	`literature_id` int(11) NOT NULL,
	PRIMARY KEY (`code_id`, `literature_id`),
	CONSTRAINT `code_literature_ibfk_1` FOREIGN KEY (`code_id`) REFERENCES `code` (`id`),
	CONSTRAINT `code_literature_ibfk_2` FOREIGN KEY (`literature_id`) REFERENCES `literature_meta` (`id`),
	INDEX `literature_id` (`literature_id`) comment ''
) ENGINE=`InnoDB` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ROW_FORMAT=COMPACT COMMENT='' CHECKSUM=0 DELAY_KEY_WRITE=0;

-- ----------------------------
--  Records of `code_literature`
-- ----------------------------
BEGIN;
INSERT INTO `code_literature` VALUES ('3', '2'), ('1', '4'), ('3', '4');
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
	`content` text CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`star` int(11) NOT NULL,
	`comment_time` datetime NOT NULL,
	`is_simple` int(11) NOT NULL,
	PRIMARY KEY (`id`),
	CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`commenter_id`) REFERENCES `user` (`id`),
	INDEX `commenter_id` (`commenter_id`) comment ''
) ENGINE=`InnoDB` AUTO_INCREMENT=34 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ROW_FORMAT=COMPACT COMMENT='' CHECKSUM=0 DELAY_KEY_WRITE=0;

-- ----------------------------
--  Records of `comment`
-- ----------------------------
BEGIN;
INSERT INTO `comment` VALUES ('29', '1', '2', '1', 0x6b3b646c6b663b736466, '5', '2015-04-19 13:28:19', '1'), ('30', '1', '2', '1', 0x736466736466736466, '2', '2015-04-19 13:28:39', '1'), ('31', '1', '3', '1', 0x6c616c616c6c6c6c616c6c616c6c616c61, '3', '2015-04-19 13:28:52', '1'), ('32', '1', '5', '1', 0xe79c9fe698afe4b880e7af87e4b88de99499e79a84e8aebae69687e591a2efbc81, '5', '2015-04-19 13:30:23', '1'), ('33', '1', '2', '1', 0xe7b2bee98791e6a186e69eb6, '4', '2015-04-20 14:16:07', '1');
COMMIT;

-- ----------------------------
--  Table structure for `data_set`
-- ----------------------------
DROP TABLE IF EXISTS `data_set`;
CREATE TABLE `data_set` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`title` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
	`creator_id` int(11) NOT NULL,
	`updater_id` int(11) DEFAULT NULL,
	`create_time` datetime NOT NULL,
	`update_time` datetime DEFAULT NULL,
	`description` text CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`size` float DEFAULT NULL,
	`uri` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`data_set_type_id` int(11) NOT NULL,
	`file_name` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`rank_num` int(11) DEFAULT NULL,
	`total_rank` int(11) DEFAULT NULL,
	`link` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`publisher` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`upload_history` text CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`from_literature_id` int(11) DEFAULT NULL,
	PRIMARY KEY (`id`),
	CONSTRAINT `data_set_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`),
	CONSTRAINT `data_set_ibfk_2` FOREIGN KEY (`data_set_type_id`) REFERENCES `type` (`id`),
	CONSTRAINT `data_set_ibfk_3` FOREIGN KEY (`updater_id`) REFERENCES `user` (`id`),
	CONSTRAINT `data_set_ibfk_4` FOREIGN KEY (`from_literature_id`) REFERENCES `literature_meta` (`id`),
	INDEX `creator_id` (`creator_id`) comment '',
	INDEX `data_set_type_id` (`data_set_type_id`) comment '',
	INDEX `updater_id` (`updater_id`) comment '',
	INDEX `from_literature_id` (`from_literature_id`) comment ''
) ENGINE=`InnoDB` AUTO_INCREMENT=3 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ROW_FORMAT=COMPACT COMMENT='' CHECKSUM=0 DELAY_KEY_WRITE=0;

-- ----------------------------
--  Records of `data_set`
-- ----------------------------
BEGIN;
INSERT INTO `data_set` VALUES ('1', 'great pic', '1', '1', '2015-04-07 21:26:50', '2015-05-05 17:42:28', '', '0', '', '3', '', '0', '0', null, 'a', null, '5'), ('2', 'test relation', '1', '1', '2015-04-15 16:35:24', '2015-05-03 16:53:46', '', '5631520', '/uploadedDataset/p19kcfmdnb1s74ish19o2ot6oq67.zip', '3', 'ui-grid.info-3.0.0-rc.20.zip', '0', '0', null, 'b', 0x6e756c6c3b75692d677269642e696e666f2d332e302e302d72632e32302e7a69702c7031396b63666d646e623173373469736831396f326f74366f7136372e7a69702c35363331353230, null);
COMMIT;

-- ----------------------------
--  Table structure for `data_set_literature`
-- ----------------------------
DROP TABLE IF EXISTS `data_set_literature`;
CREATE TABLE `data_set_literature` (
	`data_set_id` int(11) NOT NULL,
	`literature_id` int(11) NOT NULL,
	PRIMARY KEY (`data_set_id`, `literature_id`),
	CONSTRAINT `data_set_literature_ibfk_1` FOREIGN KEY (`data_set_id`) REFERENCES `data_set` (`id`),
	CONSTRAINT `data_set_literature_ibfk_2` FOREIGN KEY (`literature_id`) REFERENCES `literature_meta` (`id`),
	INDEX `literature_id` (`literature_id`) comment ''
) ENGINE=`InnoDB` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ROW_FORMAT=COMPACT COMMENT='' CHECKSUM=0 DELAY_KEY_WRITE=0;

-- ----------------------------
--  Records of `data_set_literature`
-- ----------------------------
BEGIN;
INSERT INTO `data_set_literature` VALUES ('1', '2'), ('1', '4'), ('1', '5');
COMMIT;

-- ----------------------------
--  Table structure for `favorite`
-- ----------------------------
DROP TABLE IF EXISTS `favorite`;
CREATE TABLE `favorite` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`user_id` int(11) NOT NULL,
	`name` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
	PRIMARY KEY (`id`),
	CONSTRAINT `favorite_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
	INDEX `user_id` (`user_id`) comment ''
) ENGINE=`InnoDB` AUTO_INCREMENT=2 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ROW_FORMAT=COMPACT COMMENT='' CHECKSUM=0 DELAY_KEY_WRITE=0;

-- ----------------------------
--  Records of `favorite`
-- ----------------------------
BEGIN;
INSERT INTO `favorite` VALUES ('1', '1', 'sdf');
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
	`favorite_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	CONSTRAINT `favorite_resource_ibfk_1` FOREIGN KEY (`favorite_id`) REFERENCES `favorite` (`id`),
	INDEX `favorite_id` (`favorite_id`) comment ''
) ENGINE=`InnoDB` AUTO_INCREMENT=1 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ROW_FORMAT=COMPACT COMMENT='' CHECKSUM=0 DELAY_KEY_WRITE=0;

-- ----------------------------
--  Table structure for `literature_meta`
-- ----------------------------
DROP TABLE IF EXISTS `literature_meta`;
CREATE TABLE `literature_meta` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`title` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
	`titleCN` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`abstract` text CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`abstractCN` text CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`author` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`authorCN` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`published_year` int(11) DEFAULT NULL,
	`publisher` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`publisherCN` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`key_words` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`key_words_CN` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`location` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`institute` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`instructor` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`language` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`pages` int(11) DEFAULT NULL,
	`volume` int(11) DEFAULT NULL,
	`issue` int(11) DEFAULT NULL,
	`section` int(11) DEFAULT NULL,
	`edition` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`press` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`editor` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`ISBN` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`ISSN` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`DOI` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`uri` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`creator_id` int(11) NOT NULL,
	`updater_id` int(11) DEFAULT NULL,
	`literature_type_id` int(11) NOT NULL,
	`create_time` datetime NOT NULL,
	`update_time` datetime DEFAULT NULL,
	`file_name` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`rank_num` int(11) DEFAULT NULL,
	`total_rank` int(11) DEFAULT NULL,
	`upload_history` text CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`publisher_abbreviation` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	PRIMARY KEY (`id`),
	CONSTRAINT `literature_meta_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`),
	CONSTRAINT `literature_meta_ibfk_2` FOREIGN KEY (`literature_type_id`) REFERENCES `type` (`id`),
	CONSTRAINT `literature_meta_ibfk_3` FOREIGN KEY (`updater_id`) REFERENCES `user` (`id`),
	INDEX `creator_id` (`creator_id`) comment '',
	INDEX `literature_type_id` (`literature_type_id`) comment '',
	INDEX `updater_id` (`updater_id`) comment ''
) ENGINE=`InnoDB` AUTO_INCREMENT=13 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ROW_FORMAT=COMPACT COMMENT='' CHECKSUM=0 DELAY_KEY_WRITE=0;

-- ----------------------------
--  Records of `literature_meta`
-- ----------------------------
BEGIN;
INSERT INTO `literature_meta` VALUES ('2', 'My very first article', '我的第一篇文章', 0x54686973206973207468652066697273742061727469636c65, 0x432e57616e67e79a84e7acace4b880e7af87e69687e7aba0, 'C.Wang', '王晨', '2014', 'Nanjing University', '南京大学', '', '', '', '', '', '', '0', '0', '0', '0', '', '', '', '', '', '', '', '1', '1', '1', '2015-04-07 17:08:36', '2015-05-04 16:30:26', '', '3', '11', 0x6e756c6c3b4c656173655f43572e7064662c7031396b63657366726131353134316f36656d746a31356d32636f34392e7064663b636172746f6f6e2e7064662c7031396b636639396e61727075316e316738643831386d3331346270392e706466, null), ('3', 'This is for testing add..', '', '', '', 'chen wong', '', '0', '', '', '', '', '', '', '', '', '0', '0', '0', '0', '', '', '', '', '', '', '', '1', '1', '2', '2015-04-08 17:42:29', '2015-04-08 21:51:28', '', '1', '3', null, null), ('4', 'meeting', '这是一篇会议论文', '', '', 'cc', '', '0', '', '', '', '', '', '', '', '', '0', '0', '0', '0', '', '', '', '', '', '', '', '1', '1', '2', '2015-04-08 21:14:25', '2015-04-08 21:51:28', '', '0', '0', null, null), ('5', 'Bug Inducing Analysis to Prevent Fault Prone Bug Fixes', '通过对程序中引入的错误分析来预防易注入错误的错误修复', 0x4275672066697820697320616e20696d706f7274616e7420616e64206368616c6c656e67696e67207461736b20696e20736f66747761726520646576656c6f706d656e7420616e64206d61696e74656e616e63652e204275672066697820697320616c736f20612064616e6765726f7573206368616e67652c2062656361757365206974206d6967687420696e64756365206e657720627567732e20497420697320646966666963756c7420746f20646563696465207768657468657220612062756720666978206973207361666520696e2070726163746963652e20496e20746869732070617065722c20776520636f6e64756374656420616e20656d7069726963616c207374756479206f6e2062756720696e647563696e6720616e616c7973697320746f20646973636f7665722074686520747970657320616e64206665617475726573206f66206661756c742070726f6e65206275672066697865732e20576520757365206120636c6173736963616c20616c676f726974686d20746f20747261636b20746865206c6f636174696f6e206f662074686520636f6465206368616e67657320696e74726f647563696e672074686520627567732e20546865206368616e6765207479706573206f662074686520636f6465732077696c6c20626520636865636b656420627920616e206175746f6d6174696320746f6f6c20616e6420776865746865722074686973206368616e676520697320612062756720666978206368616e6765206973207265636f726465642e20576520616e616c797a6520746865207374617469737469637320746f2066696e64206f75742077686174207479706573206f66206368616e676520617265206d6f73742070726f6e6520746f20696e64756365206e65772062756773207768656e20746865792061726520696e74656e64656420746f206669782061206275672e2046696e616c6c792c20736f6d652067756964656c696e6573206172652070726f766964656420746f2068656c7020646576656c6f706572732070726576656e742073756368206661756c742070726f6e65206275672066697865732e, 0xe8bf99e698afe4b8ade69687e69198e8a681, 'Haoyu Yang, Chen Wang, Qingkai Shi, Yang Feng, Zhenyu Chen', '杨皓宇，王晨，时清凯，冯洋，陈振宇', '2014', 'SEKE', '', 'bug inducing, bug fix, mining software repository, software maintenance', '错误注入，错误修复，程序修复，数据挖掘', 'Toronto', 'State Key Laboratory for Novel Software Technology, Nanjing University', 'Zhenyu Chen', 'English', '6', '0', '0', '0', '', '', '', '', '', '', '/uploaded/p19k9pnukf1mvt38f1snoeh71qcpv.pdf', '1', '1', '2', '2015-04-08 21:17:47', '2015-05-02 15:51:38', 'Bug Inducing Analysis to Prevent Fault Prone Bug Fixes.pdf', '1', '5', null, null), ('6', 'test kb', '', '', '', 'test', '', '0', 'amerivan aa', '', '', '', '', '', '', '', '0', '0', '0', '0', '', '', '', '', '', '', '', '1', null, '1', '2015-05-04 13:31:45', null, '', '0', '0', '', 'aa'), ('7', 'test kb 2', '', '', '', 'test', '', '1', 'amerivan aa', '', '', '', '', '', '', '', '0', '0', '0', '0', '', '', '', '', '', '', '', '1', null, '1', '2015-05-04 13:32:37', null, '', '0', '0', '', 'aa'), ('8', 'test kb 3', '', '', '', 'test', '', '2009', '', '', '', '', '', '', '', '', '0', '0', '0', '0', '', '', '', '', '', '', '', '1', null, '1', '2015-05-04 13:33:40', null, '', '0', '0', '', 'aa'), ('9', 'test kb 4', '', '', '', 'test', '', '0', 'el es ed', '', '', '', '', '', '', '', '0', '0', '0', '0', '', '', '', '', '', '', '', '1', null, '1', '2015-05-04 13:34:15', null, '', '0', '0', '', 'eee'), ('10', 'test kb 5', '', '', '', 'test', '', '2003', '', '', '', '', 'madison', '', '', '', '0', '0', '0', '0', '', '', 'sdfsdfsdfsdfs', '', '', '', '', '1', null, '1', '2015-05-04 13:47:55', null, '', '0', '0', '', 'aa'), ('11', 'test kb 778', '', '', '', 'wdfsdf', '', '0', '', '', '', '', '', '', '', '', '0', '0', '0', '0', '', '', '', '', '', '', '', '1', null, '2', '2015-05-04 14:13:31', null, '', '0', '0', '', 'aa'), ('12', 'hhhh', '', '', '', 'hjk', '', '0', 'amerivan aa', '', '', '', '', '', '', '', '0', '0', '0', '0', '', '', '', '', '', '', '', '1', null, '1', '2015-05-04 14:17:43', null, '', '0', '0', '', 'aa');
COMMIT;

-- ----------------------------
--  Table structure for `personalized`
-- ----------------------------
DROP TABLE IF EXISTS `personalized`;
CREATE TABLE `personalized` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`literature_id` int(11) NOT NULL,
	`user_id` int(11) NOT NULL,
	`uri` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
	`fileName` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	PRIMARY KEY (`id`),
	CONSTRAINT `personalized_ibfk_1` FOREIGN KEY (`literature_id`) REFERENCES `literature_meta` (`id`),
	CONSTRAINT `personalized_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
	INDEX `literature_id` (`literature_id`) comment '',
	INDEX `user_id` (`user_id`) comment ''
) ENGINE=`InnoDB` AUTO_INCREMENT=9 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ROW_FORMAT=COMPACT COMMENT='' CHECKSUM=0 DELAY_KEY_WRITE=0;

-- ----------------------------
--  Records of `personalized`
-- ----------------------------
BEGIN;
INSERT INTO `personalized` VALUES ('8', '2', '1', '', '');
COMMIT;

-- ----------------------------
--  Table structure for `ppt`
-- ----------------------------
DROP TABLE IF EXISTS `ppt`;
CREATE TABLE `ppt` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`literature_id` int(11) DEFAULT NULL,
	`size` float DEFAULT NULL,
	`uri` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`ppt_name` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	PRIMARY KEY (`id`),
	CONSTRAINT `ppt_ibfk_1` FOREIGN KEY (`literature_id`) REFERENCES `literature_meta` (`id`),
	INDEX `literature_id` (`literature_id`) comment ''
) ENGINE=`InnoDB` AUTO_INCREMENT=1 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ROW_FORMAT=COMPACT COMMENT='' CHECKSUM=0 DELAY_KEY_WRITE=0;

-- ----------------------------
--  Table structure for `report`
-- ----------------------------
DROP TABLE IF EXISTS `report`;
CREATE TABLE `report` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`title` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
	`report_date` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`reporter` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`company` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`reporter_title` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`location` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`creator_id` int(11) NOT NULL,
	`updater_id` int(11) DEFAULT NULL,
	`create_time` datetime NOT NULL,
	`update_time` datetime DEFAULT NULL,
	`total_rank` int(11) DEFAULT NULL,
	`rank_num` int(11) DEFAULT NULL,
	PRIMARY KEY (`id`),
	CONSTRAINT `report_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`),
	CONSTRAINT `report_ibfk_2` FOREIGN KEY (`updater_id`) REFERENCES `user` (`id`),
	INDEX `creator_id` (`creator_id`) comment '',
	INDEX `updater_id` (`updater_id`) comment ''
) ENGINE=`InnoDB` AUTO_INCREMENT=2 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ROW_FORMAT=COMPACT COMMENT='' CHECKSUM=0 DELAY_KEY_WRITE=0;

-- ----------------------------
--  Records of `report`
-- ----------------------------
BEGIN;
INSERT INTO `report` VALUES ('1', '一个报告', '2015-05-14 00:00:00', '薛', '', '大神', '学校', '1', null, '2015-04-19 13:48:50', null, '0', '0');
COMMIT;

-- ----------------------------
--  Table structure for `report_attachment`
-- ----------------------------
DROP TABLE IF EXISTS `report_attachment`;
CREATE TABLE `report_attachment` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`report_id` int(11) DEFAULT NULL,
	`uri` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`attachment_name` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	PRIMARY KEY (`id`),
	CONSTRAINT `report_attachment_ibfk_1` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`),
	INDEX `report_id` (`report_id`) comment ''
) ENGINE=`InnoDB` AUTO_INCREMENT=5 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ROW_FORMAT=COMPACT COMMENT='' CHECKSUM=0 DELAY_KEY_WRITE=0;

-- ----------------------------
--  Records of `report_attachment`
-- ----------------------------
BEGIN;
INSERT INTO `report_attachment` VALUES ('4', '1', '/uploadedReportattachment/p19k9smbso4res3oa778l01sje5.pdf', 'Fabric说明文档.pdf');
COMMIT;

-- ----------------------------
--  Table structure for `report_code`
-- ----------------------------
DROP TABLE IF EXISTS `report_code`;
CREATE TABLE `report_code` (
	`report_id` int(11) NOT NULL,
	`code_id` int(11) NOT NULL,
	PRIMARY KEY (`report_id`, `code_id`),
	CONSTRAINT `report_code_ibfk_1` FOREIGN KEY (`code_id`) REFERENCES `code` (`id`),
	CONSTRAINT `report_code_ibfk_2` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`),
	INDEX `code_id` (`code_id`) comment ''
) ENGINE=`InnoDB` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ROW_FORMAT=COMPACT COMMENT='' CHECKSUM=0 DELAY_KEY_WRITE=0;

-- ----------------------------
--  Table structure for `report_data_set`
-- ----------------------------
DROP TABLE IF EXISTS `report_data_set`;
CREATE TABLE `report_data_set` (
	`report_id` int(11) NOT NULL,
	`data_set_id` int(11) NOT NULL,
	PRIMARY KEY (`report_id`, `data_set_id`),
	CONSTRAINT `report_data_set_ibfk_1` FOREIGN KEY (`data_set_id`) REFERENCES `data_set` (`id`),
	CONSTRAINT `report_data_set_ibfk_2` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`),
	INDEX `data_set_id` (`data_set_id`) comment ''
) ENGINE=`InnoDB` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ROW_FORMAT=COMPACT COMMENT='' CHECKSUM=0 DELAY_KEY_WRITE=0;

-- ----------------------------
--  Table structure for `report_literature`
-- ----------------------------
DROP TABLE IF EXISTS `report_literature`;
CREATE TABLE `report_literature` (
	`report_id` int(11) NOT NULL,
	`literature_id` int(11) NOT NULL,
	PRIMARY KEY (`report_id`, `literature_id`),
	CONSTRAINT `report_literature_ibfk_1` FOREIGN KEY (`literature_id`) REFERENCES `literature_meta` (`id`),
	CONSTRAINT `report_literature_ibfk_2` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`),
	INDEX `literature_id` (`literature_id`) comment ''
) ENGINE=`InnoDB` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ROW_FORMAT=COMPACT COMMENT='' CHECKSUM=0 DELAY_KEY_WRITE=0;

-- ----------------------------
--  Table structure for `report_recording`
-- ----------------------------
DROP TABLE IF EXISTS `report_recording`;
CREATE TABLE `report_recording` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`report_id` int(11) DEFAULT NULL,
	`uri` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`recording_name` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	PRIMARY KEY (`id`),
	CONSTRAINT `report_recording_ibfk_1` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`),
	INDEX `report_id` (`report_id`) comment ''
) ENGINE=`InnoDB` AUTO_INCREMENT=1 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ROW_FORMAT=COMPACT COMMENT='' CHECKSUM=0 DELAY_KEY_WRITE=0;

-- ----------------------------
--  Table structure for `tag`
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`name` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
	`type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=`InnoDB` AUTO_INCREMENT=3 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ROW_FORMAT=COMPACT COMMENT='' CHECKSUM=0 DELAY_KEY_WRITE=0;

-- ----------------------------
--  Records of `tag`
-- ----------------------------
BEGIN;
INSERT INTO `tag` VALUES ('1', 'c++', ''), ('2', 'java', '');
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
	CONSTRAINT `tag_resource_ibfk_1` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`),
	INDEX `tag_id` (`tag_id`) comment ''
) ENGINE=`InnoDB` AUTO_INCREMENT=5 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ROW_FORMAT=COMPACT COMMENT='' CHECKSUM=0 DELAY_KEY_WRITE=0;

-- ----------------------------
--  Records of `tag_resource`
-- ----------------------------
BEGIN;
INSERT INTO `tag_resource` VALUES ('2', '1', '5', '1'), ('3', '2', '5', '1'), ('4', '2', '5', '2');
COMMIT;

-- ----------------------------
--  Table structure for `type`
-- ----------------------------
DROP TABLE IF EXISTS `type`;
CREATE TABLE `type` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`name` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
	`type_id` int(11) NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=`InnoDB` AUTO_INCREMENT=7 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ROW_FORMAT=COMPACT COMMENT='' CHECKSUM=0 DELAY_KEY_WRITE=0;

-- ----------------------------
--  Records of `type`
-- ----------------------------
BEGIN;
INSERT INTO `type` VALUES ('1', '期刊', '1'), ('2', '会议', '1'), ('3', '图片', '2'), ('4', '数据', '2'), ('5', '赞扬', '3'), ('6', '批评', '3');
COMMIT;

-- ----------------------------
--  Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`name` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
	`password` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
	`privilege` int(11) NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=`InnoDB` AUTO_INCREMENT=3 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ROW_FORMAT=COMPACT COMMENT='' CHECKSUM=0 DELAY_KEY_WRITE=0;

-- ----------------------------
--  Records of `user`
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES ('1', 'chen', '123', '0'), ('2', 'test', 'test', '0');
COMMIT;

-- ----------------------------
--  Table structure for `video`
-- ----------------------------
DROP TABLE IF EXISTS `video`;
CREATE TABLE `video` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`literature_id` int(11) DEFAULT NULL,
	`size` float DEFAULT NULL,
	`uri` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	`video_name` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
	PRIMARY KEY (`id`),
	CONSTRAINT `video_ibfk_1` FOREIGN KEY (`literature_id`) REFERENCES `literature_meta` (`id`),
	INDEX `literature_id` (`literature_id`) comment ''
) ENGINE=`InnoDB` AUTO_INCREMENT=10 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ROW_FORMAT=COMPACT COMMENT='' CHECKSUM=0 DELAY_KEY_WRITE=0;

-- ----------------------------
--  Records of `video`
-- ----------------------------
BEGIN;
INSERT INTO `video` VALUES ('9', '2', '58897900', '/uploadedVideo/p19k9oof7j1h871o67v13raf1d0o7.mp4', 'Lady Gaga and Tony Bennett perform Cheek to Cheek.mp4');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
