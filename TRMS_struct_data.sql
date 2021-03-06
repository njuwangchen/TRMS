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

 Date: 05/15/2015 22:31:23 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `KB__conference`
-- ----------------------------
DROP TABLE IF EXISTS `KB__conference`;
CREATE TABLE `KB__conference` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `abbreviation` varchar(128) COLLATE utf8_bin NOT NULL,
  `full` varchar(256) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

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
  `abbreviation` varchar(128) COLLATE utf8_bin NOT NULL,
  `year` int(11) NOT NULL,
  `location` varchar(256) COLLATE utf8_bin NOT NULL,
  `editor` varchar(256) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

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
  `abbreviation` varchar(128) COLLATE utf8_bin NOT NULL,
  `full` varchar(256) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

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
  `abbreviation` varchar(128) COLLATE utf8_bin NOT NULL,
  `year` int(11) NOT NULL,
  `issue` int(11) NOT NULL,
  `editor` varchar(256) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

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
  `version_num` varchar(32) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

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
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  `type` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `attribute`
-- ----------------------------
BEGIN;
INSERT INTO `attribute` VALUES ('1', '待评价', '2'), ('2', '待提高', '2'), ('3', '有点', '2'), ('4', '缺点', '2'), ('5', 'title', '1'), ('6', 'titleCN', '1'), ('7', 'abstract', '1'), ('8', 'abstractCN', '1'), ('9', 'author', '1'), ('10', 'authorCN', '1'), ('11', 'published_year', '1'), ('12', 'publisher', '1'), ('13', 'key_words', '1'), ('14', 'key_words_CN', '1'), ('15', 'location', '1'), ('16', 'institute', '1'), ('17', 'instructor', '1'), ('18', 'language', '1'), ('19', 'pages', '1'), ('20', 'volume', '1'), ('21', 'issue', '1'), ('22', 'section', '1'), ('23', 'edition', '1'), ('24', 'press', '1'), ('25', 'editor', '1'), ('26', 'ISBN', '1'), ('27', 'ISSN', '1'), ('28', 'DOI', '1'), ('29', 'uri', '1'), ('32', '提及', '3'), ('33', '批评', '3');
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
  KEY `cite_type_id` (`cite_type_id`),
  KEY `cited_id` (`cited_id`),
  KEY `literature_id` (`literature_id`),
  CONSTRAINT `cite_ibfk_1` FOREIGN KEY (`cite_type_id`) REFERENCES `type` (`id`),
  CONSTRAINT `cite_ibfk_2` FOREIGN KEY (`cited_id`) REFERENCES `literature_meta` (`id`),
  CONSTRAINT `cite_ibfk_3` FOREIGN KEY (`literature_id`) REFERENCES `literature_meta` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

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
  `link` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `publisher` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `upload_history` text COLLATE utf8_bin,
  `from_literature_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `updater_id` (`updater_id`),
  KEY `from_literature_id` (`from_literature_id`),
  CONSTRAINT `code_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`),
  CONSTRAINT `code_ibfk_2` FOREIGN KEY (`updater_id`) REFERENCES `user` (`id`),
  CONSTRAINT `code_ibfk_3` FOREIGN KEY (`from_literature_id`) REFERENCES `literature_meta` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

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
  PRIMARY KEY (`code_id`,`literature_id`),
  KEY `literature_id` (`literature_id`),
  CONSTRAINT `code_literature_ibfk_1` FOREIGN KEY (`code_id`) REFERENCES `code` (`id`),
  CONSTRAINT `code_literature_ibfk_2` FOREIGN KEY (`literature_id`) REFERENCES `literature_meta` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

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
  `content` text COLLATE utf8_bin,
  `star` int(11) NOT NULL,
  `comment_time` datetime NOT NULL,
  `is_simple` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `commenter_id` (`commenter_id`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`commenter_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `comment`
-- ----------------------------
BEGIN;
INSERT INTO `comment` VALUES ('29', '1', '2', '1', 0x6b3b646c6b663b736466, '5', '2015-04-19 13:28:19', '1'), ('30', '1', '2', '1', 0x736466736466736466, '2', '2015-04-19 13:28:39', '1'), ('31', '1', '3', '1', 0x6c616c616c6c6c6c616c6c616c6c616c61, '3', '2015-04-19 13:28:52', '1'), ('32', '1', '5', '1', 0xe79c9fe698afe4b880e7af87e4b88de99499e79a84e8aebae69687e591a2efbc81, '5', '2015-04-19 13:30:23', '1'), ('33', '1', '2', '1', 0xe7b2bee98791e6a186e69eb6, '4', '2015-04-20 14:16:07', '1'), ('34', '1', '2', '1', 0x756e646566696e656426e68891e698afe5be85e68f90e9ab98, '0', '2015-05-08 00:43:50', '0'), ('35', '1', '2', '1', 0x756e646566696e656426e68891e698afe5be85e68f90e9ab9826e598bfe598bf, '0', '2015-05-08 00:44:07', '0'), ('36', '1', '2', '1', 0x756e646566696e6564266e696e69, '0', '2015-05-08 00:45:15', '0'), ('37', '1', '2', '1', 0x756e646566696e656426756e646566696e656426756e646566696e656426e4bb80e4b988e9acbc, '0', '2015-05-08 00:54:00', '0'), ('38', '1', '2', '1', 0x7869786869, '0', '2015-05-08 00:56:33', '0'), ('39', '1', '2', '1', 0x7368696d652664756964266565, '0', '2015-05-08 00:56:40', '0');
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
  `link` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `publisher` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `upload_history` text COLLATE utf8_bin,
  `from_literature_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `data_set_type_id` (`data_set_type_id`),
  KEY `updater_id` (`updater_id`),
  KEY `from_literature_id` (`from_literature_id`),
  CONSTRAINT `data_set_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`),
  CONSTRAINT `data_set_ibfk_2` FOREIGN KEY (`data_set_type_id`) REFERENCES `type` (`id`),
  CONSTRAINT `data_set_ibfk_3` FOREIGN KEY (`updater_id`) REFERENCES `user` (`id`),
  CONSTRAINT `data_set_ibfk_4` FOREIGN KEY (`from_literature_id`) REFERENCES `literature_meta` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

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
  PRIMARY KEY (`data_set_id`,`literature_id`),
  KEY `literature_id` (`literature_id`),
  CONSTRAINT `data_set_literature_ibfk_1` FOREIGN KEY (`data_set_id`) REFERENCES `data_set` (`id`),
  CONSTRAINT `data_set_literature_ibfk_2` FOREIGN KEY (`literature_id`) REFERENCES `literature_meta` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

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
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `favorite_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `favorite`
-- ----------------------------
BEGIN;
INSERT INTO `favorite` VALUES ('2', '1', '我的收藏1'), ('3', '1', '我的收藏2'), ('4', '1', '我的收藏3'), ('5', '1', '我的收藏4'), ('6', '1', '新建收藏夹1');
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
  KEY `favorite_id` (`favorite_id`),
  CONSTRAINT `favorite_resource_ibfk_1` FOREIGN KEY (`favorite_id`) REFERENCES `favorite` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `favorite_resource`
-- ----------------------------
BEGIN;
INSERT INTO `favorite_resource` VALUES ('1', '13', '1', '2', '2015-05-10 01:27:25'), ('2', '14', '1', '2', '2015-05-10 01:27:33');
COMMIT;

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
  `upload_history` text COLLATE utf8_bin,
  `publisher_abbreviation` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `literature_type_id` (`literature_type_id`),
  KEY `updater_id` (`updater_id`),
  CONSTRAINT `literature_meta_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`),
  CONSTRAINT `literature_meta_ibfk_2` FOREIGN KEY (`literature_type_id`) REFERENCES `type` (`id`),
  CONSTRAINT `literature_meta_ibfk_3` FOREIGN KEY (`updater_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `literature_meta`
-- ----------------------------
BEGIN;
INSERT INTO `literature_meta` VALUES ('2', 'Segmentation propagation in imagenet', '', 0x5365676d656e746174696f6e2070726f7061676174696f6e20696e20696d6167656e6574, '', 'C.Wang', '王晨', '2014', 'Nanjing University', '南京大学', 'Imagenet, AI', '', 'Los Angles', 'Information Institute', 'John Chabber.', '', '0', '0', '0', '0', '', '', '', '0192839491', '', '', '', '1', '1', '2', '2015-04-07 17:08:36', '2015-05-11 09:41:13', '', '3', '11', 0x6e756c6c3b4c656173655f43572e7064662c7031396b63657366726131353134316f36656d746a31356d32636f34392e7064663b636172746f6f6e2e7064662c7031396b636639396e61727075316e316738643831386d3331346270392e706466, null), ('3', 'Reproducibility of optic disk topographic measurements with the Topcon ImageNet and the Heidelberg Retina Tomograph.', '', '', '', 'chen wong', '', '0', '', '', '', '', '', '', '', '', '0', '0', '0', '0', '', '', '', '', '', '', '', '1', '1', '2', '2015-04-08 17:42:29', '2015-04-08 21:51:28', '', '1', '3', null, null), ('4', 'ImageNet Classification with Deep Convolutional Neural Networks\n\nImageNet Classification with Deep Convolutional Neural Networks', '', '', '', 'Alex Krizhevsky\nIlya Sutskever\nGeoffrey E. Hinton', '', '2012', 'NIPS', '', 'Image Coginition, Deep learning', '', '', '', '', '', '0', '0', '0', '0', '', '', '', '', '', '', '', '1', '1', '2', '2015-04-08 21:14:25', '2015-04-08 21:51:28', '', '0', '0', null, null), ('5', 'Bug Inducing Analysis to Prevent Fault Prone Bug Fixes', '通过对程序中引入的错误分析来预防易注入错误的错误修复', 0x4275672066697820697320616e20696d706f7274616e7420616e64206368616c6c656e67696e67207461736b20696e20736f66747761726520646576656c6f706d656e7420616e64206d61696e74656e616e63652e204275672066697820697320616c736f20612064616e6765726f7573206368616e67652c2062656361757365206974206d6967687420696e64756365206e657720627567732e20497420697320646966666963756c7420746f20646563696465207768657468657220612062756720666978206973207361666520696e2070726163746963652e20496e20746869732070617065722c20776520636f6e64756374656420616e20656d7069726963616c207374756479206f6e2062756720696e647563696e6720616e616c7973697320746f20646973636f7665722074686520747970657320616e64206665617475726573206f66206661756c742070726f6e65206275672066697865732e20576520757365206120636c6173736963616c20616c676f726974686d20746f20747261636b20746865206c6f636174696f6e206f662074686520636f6465206368616e67657320696e74726f647563696e672074686520627567732e20546865206368616e6765207479706573206f662074686520636f6465732077696c6c20626520636865636b656420627920616e206175746f6d6174696320746f6f6c20616e6420776865746865722074686973206368616e676520697320612062756720666978206368616e6765206973207265636f726465642e20576520616e616c797a6520746865207374617469737469637320746f2066696e64206f75742077686174207479706573206f66206368616e676520617265206d6f73742070726f6e6520746f20696e64756365206e65772062756773207768656e20746865792061726520696e74656e64656420746f206669782061206275672e2046696e616c6c792c20736f6d652067756964656c696e6573206172652070726f766964656420746f2068656c7020646576656c6f706572732070726576656e742073756368206661756c742070726f6e65206275672066697865732e, 0xe8bf99e698afe4b8ade69687e69198e8a681, 'Haoyu Yang, Chen Wang, Qingkai Shi, Yang Feng, Zhenyu Chen', '杨皓宇，王晨，时清凯，冯洋，陈振宇', '2014', 'SEKE', '', 'bug inducing, bug fix, mining software repository, software maintenance', '错误注入，错误修复，程序修复，数据挖掘', 'Toronto', 'State Key Laboratory for Novel Software Technology, Nanjing University', 'Zhenyu Chen', 'English', '6', '0', '0', '0', '', '', '', '', '', '', '/uploaded/p19k9pnukf1mvt38f1snoeh71qcpv.pdf', '1', '1', '2', '2015-04-08 21:17:47', '2015-05-11 10:08:10', 'Bug Inducing Analysis to Prevent Fault Prone Bug Fixes.pdf', '1', '5', null, null), ('13', 'ImageNet: A large-scale hierarchical image database', null, null, null, null, null, '2009', 'CVPR', null, null, null, 'Miami, FL', null, null, null, '7', null, null, null, null, 'IEEE', null, null, '1063-6919', '10.1109/CVPR.2009.5206848', 'http://ieeexplore.ieee.org/xpl/articleDetails.jsp?arnumber=5206848&tag=1', '1', null, '1', '2015-05-10 00:53:46', null, null, '0', '0', null, null), ('14', 'Visual and semantic similarity in ImageNet', '', 0x4d616e7920636f6d707574657220766973696f6e20617070726f61636865732074616b6520666f72206772616e74656420706f73697469766520616e737765727320746f207175657374696f6e73207375636820617320e2809c4172652073656d616e7469632063617465676f726965732076697375616c6c7920736570617261626c653fe2809d20616e6420e2809c49732076697375616c2073696d696c617269747920636f7272656c6174656420746f2073656d616e7469632073696d696c61726974793fe2809d2e20496e20746869732070617065722c207765207374756479206578706572696d656e74616c6c79207768657468657220746865736520617373756d7074696f6e7320686f6c6420616e642073686f7720706172616c6c656c7320746f207175657374696f6e7320696e7665737469676174656420696e20636f676e697469766520736369656e63652061626f7574207468652068756d616e2076697375616c2073797374656d2e2054686520696e736967687473206761696e65642066726f6d206f757220616e616c7973697320656e61626c65206275696c64696e672061206e6f76656c2064697374616e63652066756e6374696f6e206265747765656e20696d6167657320617373657373696e6720776865746865722074686579206172652066726f6d207468652073616d652062617369632d6c6576656c2063617465676f72792e20546869732066756e6374696f6e20676f6573206265796f6e64206469726563742076697375616c2064697374616e636520617320697420616c736f206578706c6f6974732073656d616e7469632073696d696c6172697479206d65617375726564207468726f75676820496d6167654e65742e2057652064656d6f6e737472617465206578706572696d656e74616c6c792074686174206974206f7574706572666f726d7320707572656c792076697375616c2064697374616e6365732e, '', 'Deselaers, T.  Ferrari, V.', '', '2011', 'Computer Vision and Pattern Recognition (CVPR)', '', 'cognition computer vision image matching visual databases', '', 'Providence, RI', 'ETG&GOOGLE', '', '', '8', '0', '0', '0', '', 'IEEE', '', '1063-6919', '', '10.1109/CVPR.2011.5995474', '', '1', null, '2', '2015-05-10 00:58:32', '2015-05-11 09:57:34', '', '0', '0', '', '');
COMMIT;

-- ----------------------------
--  Table structure for `personalized`
-- ----------------------------
DROP TABLE IF EXISTS `personalized`;
CREATE TABLE `personalized` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `literature_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `uri` varchar(256) COLLATE utf8_bin NOT NULL,
  `fileName` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `literature_id` (`literature_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `personalized_ibfk_1` FOREIGN KEY (`literature_id`) REFERENCES `literature_meta` (`id`),
  CONSTRAINT `personalized_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `personalized`
-- ----------------------------
BEGIN;
INSERT INTO `personalized` VALUES ('8', '2', '1', '', ''), ('9', '5', '1', '/uploadedPersonalized/p19l1i8r2i6bs1eu61ji8nvq5kd9.pdf', 'Bug-introducing analysis in Object-Oriented programs to prevent fault prone bug-fix change.pdf');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

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
  `uri` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `attachment_name` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `report_id` (`report_id`),
  CONSTRAINT `report_attachment_ibfk_1` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

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
  `type` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `tag`
-- ----------------------------
BEGIN;
INSERT INTO `tag` VALUES ('1', 'python', '编程语言'), ('2', 'java', '编程语言'), ('3', '易于学习', '资料特点'), ('4', '文字清晰', '资料特点'), ('5', '插图好看', '资料特点'), ('6', '图像处理', '领域'), ('7', '文本挖掘', '领域'), ('8', '数据挖掘', '领域'), ('9', '机器学习', '领域'), ('10', '海量数据库', '领域'), ('11', '体系结构', '领域'), ('12', '算法', '领域');
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `tag_resource`
-- ----------------------------
BEGIN;
INSERT INTO `tag_resource` VALUES ('2', '1', '5', '1'), ('3', '2', '5', '1'), ('4', '2', '5', '2'), ('6', '15', '1', '6'), ('9', '15', '1', '8'), ('10', '15', '1', '7'), ('11', '15', '1', '11'), ('16', '14', '1', '1');
COMMIT;

-- ----------------------------
--  Table structure for `type`
-- ----------------------------
DROP TABLE IF EXISTS `type`;
CREATE TABLE `type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  `type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `type`
-- ----------------------------
BEGIN;
INSERT INTO `type` VALUES ('1', '期刊', '1'), ('2', '会议', '1'), ('3', '图片', '2'), ('4', '数据', '2'), ('5', '赞扬', '3'), ('6', '批评', '3'), ('7', '你好', '1');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

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
  `uri` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `video_name` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `literature_id` (`literature_id`),
  CONSTRAINT `video_ibfk_1` FOREIGN KEY (`literature_id`) REFERENCES `literature_meta` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `video`
-- ----------------------------
BEGIN;
INSERT INTO `video` VALUES ('9', '2', '58897900', '/uploadedVideo/p19k9oof7j1h871o67v13raf1d0o7.mp4', 'Lady Gaga and Tony Bennett perform Cheek to Cheek.mp4');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
