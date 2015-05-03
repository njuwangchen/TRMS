-- phpMyAdmin SQL Dump
-- version 4.0.8
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2015-05-03 08:56:33
-- 服务器版本: 5.6.14
-- PHP 版本: 5.5.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `TRMS`
--

-- --------------------------------------------------------

--
-- 表的结构 `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
CREATE TABLE IF NOT EXISTS `alembic_version` (
  `version_num` varchar(32) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- 转存表中的数据 `alembic_version`
--

INSERT INTO `alembic_version` (`version_num`) VALUES
('538484b812ec');

-- --------------------------------------------------------

--
-- 表的结构 `attribute`
--

DROP TABLE IF EXISTS `attribute`;
CREATE TABLE IF NOT EXISTS `attribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `cite`
--

DROP TABLE IF EXISTS `cite`;
CREATE TABLE IF NOT EXISTS `cite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `literature_id` int(11) NOT NULL,
  `cited_id` int(11) NOT NULL,
  `cite_type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cite_type_id` (`cite_type_id`),
  KEY `cited_id` (`cited_id`),
  KEY `literature_id` (`literature_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=18 ;

--
-- 转存表中的数据 `cite`
--

INSERT INTO `cite` (`id`, `literature_id`, `cited_id`, `cite_type_id`) VALUES
(12, 2, 4, 5),
(13, 2, 5, 6),
(14, 5, 2, 5),
(15, 4, 2, 6),
(16, 2, 2, 6),
(17, 2, 3, 6);

-- --------------------------------------------------------

--
-- 表的结构 `code`
--

DROP TABLE IF EXISTS `code`;
CREATE TABLE IF NOT EXISTS `code` (
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
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `updater_id` (`updater_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `code`
--

INSERT INTO `code` (`id`, `title`, `creator_id`, `updater_id`, `create_time`, `update_time`, `description`, `size`, `uri`, `language`, `file_name`, `rank_num`, `total_rank`, `link`, `publisher`, `upload_history`) VALUES
(1, 'first code', 1, 1, '2015-04-07 21:07:40', '2015-05-03 16:49:14', 'lalalla', 1751260, '/uploadedCode/p19kcfe3pu1r971lu2i871j6b1mtub.zip', 'sdf', 'linux_setup_1.4.1.zip', 0, 0, NULL, 'chen', 'null;linux_setup_1.4.1.zip,p19kcfe3pu1r971lu2i871j6b1mtub.zip,1751257'),
(2, 'this is yin wang''s 14 rows code', 1, 1, '2015-04-15 18:29:41', '2015-04-20 14:22:34', 'very nice', 0, '', 'ruby', '', 0, 0, NULL, NULL, NULL),
(3, 'this is yin wang''s 14 rows code', 1, NULL, '2015-04-15 18:31:38', NULL, 'very nice', 0, '', '', '', 0, 0, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `code_literature`
--

DROP TABLE IF EXISTS `code_literature`;
CREATE TABLE IF NOT EXISTS `code_literature` (
  `code_id` int(11) NOT NULL,
  `literature_id` int(11) NOT NULL,
  PRIMARY KEY (`code_id`,`literature_id`),
  KEY `literature_id` (`literature_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- 转存表中的数据 `code_literature`
--

INSERT INTO `code_literature` (`code_id`, `literature_id`) VALUES
(2, 2),
(3, 2),
(1, 4),
(3, 4),
(2, 5);

-- --------------------------------------------------------

--
-- 表的结构 `comment`
--

DROP TABLE IF EXISTS `comment`;
CREATE TABLE IF NOT EXISTS `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `commenter_id` int(11) NOT NULL,
  `resource_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `content` text COLLATE utf8_bin,
  `star` int(11) NOT NULL,
  `comment_time` datetime NOT NULL,
  `is_simple` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `commenter_id` (`commenter_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=34 ;

--
-- 转存表中的数据 `comment`
--

INSERT INTO `comment` (`id`, `commenter_id`, `resource_id`, `type`, `content`, `star`, `comment_time`, `is_simple`) VALUES
(29, 1, 2, 1, 'k;dlkf;sdf', 5, '2015-04-19 13:28:19', 1),
(30, 1, 2, 1, 'sdfsdfsdf', 2, '2015-04-19 13:28:39', 1),
(31, 1, 3, 1, 'lalallllallallala', 3, '2015-04-19 13:28:52', 1),
(32, 1, 5, 1, '真是一篇不错的论文呢！', 5, '2015-04-19 13:30:23', 1),
(33, 1, 2, 1, '精金框架', 4, '2015-04-20 14:16:07', 1);

-- --------------------------------------------------------

--
-- 表的结构 `data_set`
--

DROP TABLE IF EXISTS `data_set`;
CREATE TABLE IF NOT EXISTS `data_set` (
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
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `data_set_type_id` (`data_set_type_id`),
  KEY `updater_id` (`updater_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `data_set`
--

INSERT INTO `data_set` (`id`, `title`, `creator_id`, `updater_id`, `create_time`, `update_time`, `description`, `size`, `uri`, `data_set_type_id`, `file_name`, `rank_num`, `total_rank`, `link`, `publisher`, `upload_history`) VALUES
(1, 'great pic', 1, 1, '2015-04-07 21:26:50', '2015-05-02 17:36:07', '', 28662, '/uploadedDataset/p19k9r0f7p7ke9of1qmq143aih83.zip', 3, 'the last project.zip', 0, 0, NULL, 'a', NULL),
(2, 'test relation', 1, 1, '2015-04-15 16:35:24', '2015-05-03 16:53:46', '', 5631520, '/uploadedDataset/p19kcfmdnb1s74ish19o2ot6oq67.zip', 3, 'ui-grid.info-3.0.0-rc.20.zip', 0, 0, NULL, 'b', 'null;ui-grid.info-3.0.0-rc.20.zip,p19kcfmdnb1s74ish19o2ot6oq67.zip,5631520');

-- --------------------------------------------------------

--
-- 表的结构 `data_set_literature`
--

DROP TABLE IF EXISTS `data_set_literature`;
CREATE TABLE IF NOT EXISTS `data_set_literature` (
  `data_set_id` int(11) NOT NULL,
  `literature_id` int(11) NOT NULL,
  PRIMARY KEY (`data_set_id`,`literature_id`),
  KEY `literature_id` (`literature_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- 转存表中的数据 `data_set_literature`
--

INSERT INTO `data_set_literature` (`data_set_id`, `literature_id`) VALUES
(1, 2),
(2, 2),
(1, 4),
(1, 5),
(2, 5);

-- --------------------------------------------------------

--
-- 表的结构 `favorite`
--

DROP TABLE IF EXISTS `favorite`;
CREATE TABLE IF NOT EXISTS `favorite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `favorite`
--

INSERT INTO `favorite` (`id`, `user_id`, `name`) VALUES
(1, 1, 'sdf');

-- --------------------------------------------------------

--
-- 表的结构 `favorite_resource`
--

DROP TABLE IF EXISTS `favorite_resource`;
CREATE TABLE IF NOT EXISTS `favorite_resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resource_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `favorite_id` int(11) NOT NULL,
  `favorite_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `favorite_id` (`favorite_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `literature_meta`
--

DROP TABLE IF EXISTS `literature_meta`;
CREATE TABLE IF NOT EXISTS `literature_meta` (
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
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `literature_type_id` (`literature_type_id`),
  KEY `updater_id` (`updater_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `literature_meta`
--

INSERT INTO `literature_meta` (`id`, `title`, `titleCN`, `abstract`, `abstractCN`, `author`, `authorCN`, `published_year`, `publisher`, `publisherCN`, `key_words`, `key_words_CN`, `location`, `institute`, `instructor`, `language`, `pages`, `volume`, `issue`, `section`, `edition`, `press`, `editor`, `ISBN`, `ISSN`, `DOI`, `uri`, `creator_id`, `updater_id`, `literature_type_id`, `create_time`, `update_time`, `file_name`, `rank_num`, `total_rank`, `upload_history`) VALUES
(2, 'My very first article', '我的第一篇文章', 'This is the first article', 'C.Wang的第一篇文章', 'C.Wang', '王晨', 2014, 'Nanjing University', '南京大学', '', '', '', '', '', '', 0, 0, 0, 0, '', '', '', '', '', '', '/uploaded/p19kcf99narpu1n1g8d818m314bp9.pdf', 1, 1, 1, '2015-04-07 17:08:36', '2015-05-03 16:46:36', 'cartoon.pdf', 3, 11, 'null;Lease_CW.pdf,p19kcesfra15141o6emtj15m2co49.pdf;cartoon.pdf,p19kcf99narpu1n1g8d818m314bp9.pdf'),
(3, 'This is for testing add..', '', '', '', 'chen wong', '', 0, '', '', '', '', '', '', '', '', 0, 0, 0, 0, '', '', '', '', '', '', '', 1, 1, 2, '2015-04-08 17:42:29', '2015-04-08 21:51:28', '', 1, 3, NULL),
(4, 'meeting', '这是一篇会议论文', '', '', 'cc', '', 0, '', '', '', '', '', '', '', '', 0, 0, 0, 0, '', '', '', '', '', '', '', 1, 1, 2, '2015-04-08 21:14:25', '2015-04-08 21:51:28', '', 0, 0, NULL),
(5, 'Bug Inducing Analysis to Prevent Fault Prone Bug Fixes', '通过对程序中引入的错误分析来预防易注入错误的错误修复', 'Bug fix is an important and challenging task in software development and maintenance. Bug fix is also a dangerous change, because it might induce new bugs. It is difficult to decide whether a bug fix is safe in practice. In this paper, we conducted an empirical study on bug inducing analysis to discover the types and features of fault prone bug fixes. We use a classical algorithm to track the location of the code changes introducing the bugs. The change types of the codes will be checked by an automatic tool and whether this change is a bug fix change is recorded. We analyze the statistics to find out what types of change are most prone to induce new bugs when they are intended to fix a bug. Finally, some guidelines are provided to help developers prevent such fault prone bug fixes.', '这是中文摘要', 'Haoyu Yang, Chen Wang, Qingkai Shi, Yang Feng, Zhenyu Chen', '杨皓宇，王晨，时清凯，冯洋，陈振宇', 2014, 'SEKE', '', 'bug inducing, bug fix, mining software repository, software maintenance', '错误注入，错误修复，程序修复，数据挖掘', 'Toronto', 'State Key Laboratory for Novel Software Technology, Nanjing University', 'Zhenyu Chen', 'English', 6, 0, 0, 0, '', '', '', '', '', '', '/uploaded/p19k9pnukf1mvt38f1snoeh71qcpv.pdf', 1, 1, 2, '2015-04-08 21:17:47', '2015-05-02 15:51:38', 'Bug Inducing Analysis to Prevent Fault Prone Bug Fixes.pdf', 1, 5, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `personalized`
--

DROP TABLE IF EXISTS `personalized`;
CREATE TABLE IF NOT EXISTS `personalized` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `literature_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `uri` varchar(256) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `literature_id` (`literature_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `ppt`
--

DROP TABLE IF EXISTS `ppt`;
CREATE TABLE IF NOT EXISTS `ppt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `literature_id` int(11) DEFAULT NULL,
  `size` float DEFAULT NULL,
  `uri` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `ppt_name` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `literature_id` (`literature_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=9 ;

--
-- 转存表中的数据 `ppt`
--

INSERT INTO `ppt` (`id`, `literature_id`, `size`, `uri`, `ppt_name`) VALUES
(8, 2, 282112, '/uploadedPpt/p19k9pkfa2qn21nqe1aqoctd1cbp7.ppt', '第9章.观察和文档审查.ppt');

-- --------------------------------------------------------

--
-- 表的结构 `report`
--

DROP TABLE IF EXISTS `report`;
CREATE TABLE IF NOT EXISTS `report` (
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
  KEY `updater_id` (`updater_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `report`
--

INSERT INTO `report` (`id`, `title`, `report_date`, `reporter`, `company`, `reporter_title`, `location`, `creator_id`, `updater_id`, `create_time`, `update_time`, `total_rank`, `rank_num`) VALUES
(1, '一个报告', '2015-05-14 00:00:00', '薛', '', '大神', '学校', 1, NULL, '2015-04-19 13:48:50', NULL, 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `report_attachment`
--

DROP TABLE IF EXISTS `report_attachment`;
CREATE TABLE IF NOT EXISTS `report_attachment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `report_id` int(11) DEFAULT NULL,
  `uri` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `attachment_name` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `report_id` (`report_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=6 ;

--
-- 转存表中的数据 `report_attachment`
--

INSERT INTO `report_attachment` (`id`, `report_id`, `uri`, `attachment_name`) VALUES
(4, 1, '/uploadedReportattachment/p19k9smbso4res3oa778l01sje5.pdf', 'Fabric说明文档.pdf'),
(5, 1, '/uploadedReportattachment/p19k9spnpkj4q102rp4r1fv913ho5.docx', 'android 大题整理.docx');

-- --------------------------------------------------------

--
-- 表的结构 `report_code`
--

DROP TABLE IF EXISTS `report_code`;
CREATE TABLE IF NOT EXISTS `report_code` (
  `report_id` int(11) NOT NULL,
  `code_id` int(11) NOT NULL,
  PRIMARY KEY (`report_id`,`code_id`),
  KEY `code_id` (`code_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 表的结构 `report_data_set`
--

DROP TABLE IF EXISTS `report_data_set`;
CREATE TABLE IF NOT EXISTS `report_data_set` (
  `report_id` int(11) NOT NULL,
  `data_set_id` int(11) NOT NULL,
  PRIMARY KEY (`report_id`,`data_set_id`),
  KEY `data_set_id` (`data_set_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 表的结构 `report_literature`
--

DROP TABLE IF EXISTS `report_literature`;
CREATE TABLE IF NOT EXISTS `report_literature` (
  `report_id` int(11) NOT NULL,
  `literature_id` int(11) NOT NULL,
  PRIMARY KEY (`report_id`,`literature_id`),
  KEY `literature_id` (`literature_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- 表的结构 `report_recording`
--

DROP TABLE IF EXISTS `report_recording`;
CREATE TABLE IF NOT EXISTS `report_recording` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `report_id` int(11) DEFAULT NULL,
  `uri` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `recording_name` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `report_id` (`report_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `report_recording`
--

INSERT INTO `report_recording` (`id`, `report_id`, `uri`, `recording_name`) VALUES
(2, 1, '/uploadedReportrecording/p19k9tftgm1p9s5or13la5el1hm55.mp4', 'Miranda Lambert.mp4');

-- --------------------------------------------------------

--
-- 表的结构 `tag`
--

DROP TABLE IF EXISTS `tag`;
CREATE TABLE IF NOT EXISTS `tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `tag`
--

INSERT INTO `tag` (`id`, `name`) VALUES
(1, 'c++'),
(2, 'java');

-- --------------------------------------------------------

--
-- 表的结构 `tag_resource`
--

DROP TABLE IF EXISTS `tag_resource`;
CREATE TABLE IF NOT EXISTS `tag_resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resource_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tag_id` (`tag_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=5 ;

--
-- 转存表中的数据 `tag_resource`
--

INSERT INTO `tag_resource` (`id`, `resource_id`, `type`, `tag_id`) VALUES
(2, 1, 5, 1),
(3, 2, 5, 1),
(4, 2, 5, 2);

-- --------------------------------------------------------

--
-- 表的结构 `type`
--

DROP TABLE IF EXISTS `type`;
CREATE TABLE IF NOT EXISTS `type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  `type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=7 ;

--
-- 转存表中的数据 `type`
--

INSERT INTO `type` (`id`, `name`, `type_id`) VALUES
(1, '期刊', 1),
(2, '会议', 1),
(3, '图片', 2),
(4, '数据', 2),
(5, '赞扬', 3),
(6, '批评', 3);

-- --------------------------------------------------------

--
-- 表的结构 `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) COLLATE utf8_bin NOT NULL,
  `password` varchar(32) COLLATE utf8_bin NOT NULL,
  `privilege` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `user`
--

INSERT INTO `user` (`id`, `name`, `password`, `privilege`) VALUES
(1, 'chen', '123', 0);

-- --------------------------------------------------------

--
-- 表的结构 `video`
--

DROP TABLE IF EXISTS `video`;
CREATE TABLE IF NOT EXISTS `video` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `literature_id` int(11) DEFAULT NULL,
  `size` float DEFAULT NULL,
  `uri` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `video_name` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `literature_id` (`literature_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=10 ;

--
-- 转存表中的数据 `video`
--

INSERT INTO `video` (`id`, `literature_id`, `size`, `uri`, `video_name`) VALUES
(8, 2, 26618600, '/uploadedVideo/p19k9okm0a14dp1btde6r103e16al7.MP4', 'Taylor Swift - Presenting Best New Artist.MP4'),
(9, 2, 58897900, '/uploadedVideo/p19k9oof7j1h871o67v13raf1d0o7.mp4', 'Lady Gaga and Tony Bennett perform Cheek to Cheek.mp4');

--
-- 限制导出的表
--

--
-- 限制表 `cite`
--
ALTER TABLE `cite`
  ADD CONSTRAINT `cite_ibfk_1` FOREIGN KEY (`cite_type_id`) REFERENCES `type` (`id`),
  ADD CONSTRAINT `cite_ibfk_2` FOREIGN KEY (`cited_id`) REFERENCES `literature_meta` (`id`),
  ADD CONSTRAINT `cite_ibfk_3` FOREIGN KEY (`literature_id`) REFERENCES `literature_meta` (`id`);

--
-- 限制表 `code`
--
ALTER TABLE `code`
  ADD CONSTRAINT `code_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `code_ibfk_2` FOREIGN KEY (`updater_id`) REFERENCES `user` (`id`);

--
-- 限制表 `code_literature`
--
ALTER TABLE `code_literature`
  ADD CONSTRAINT `code_literature_ibfk_1` FOREIGN KEY (`code_id`) REFERENCES `code` (`id`),
  ADD CONSTRAINT `code_literature_ibfk_2` FOREIGN KEY (`literature_id`) REFERENCES `literature_meta` (`id`);

--
-- 限制表 `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`commenter_id`) REFERENCES `user` (`id`);

--
-- 限制表 `data_set`
--
ALTER TABLE `data_set`
  ADD CONSTRAINT `data_set_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `data_set_ibfk_2` FOREIGN KEY (`data_set_type_id`) REFERENCES `type` (`id`),
  ADD CONSTRAINT `data_set_ibfk_3` FOREIGN KEY (`updater_id`) REFERENCES `user` (`id`);

--
-- 限制表 `data_set_literature`
--
ALTER TABLE `data_set_literature`
  ADD CONSTRAINT `data_set_literature_ibfk_1` FOREIGN KEY (`data_set_id`) REFERENCES `data_set` (`id`),
  ADD CONSTRAINT `data_set_literature_ibfk_2` FOREIGN KEY (`literature_id`) REFERENCES `literature_meta` (`id`);

--
-- 限制表 `favorite`
--
ALTER TABLE `favorite`
  ADD CONSTRAINT `favorite_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- 限制表 `favorite_resource`
--
ALTER TABLE `favorite_resource`
  ADD CONSTRAINT `favorite_resource_ibfk_1` FOREIGN KEY (`favorite_id`) REFERENCES `favorite` (`id`);

--
-- 限制表 `literature_meta`
--
ALTER TABLE `literature_meta`
  ADD CONSTRAINT `literature_meta_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `literature_meta_ibfk_2` FOREIGN KEY (`literature_type_id`) REFERENCES `type` (`id`),
  ADD CONSTRAINT `literature_meta_ibfk_3` FOREIGN KEY (`updater_id`) REFERENCES `user` (`id`);

--
-- 限制表 `personalized`
--
ALTER TABLE `personalized`
  ADD CONSTRAINT `personalized_ibfk_1` FOREIGN KEY (`literature_id`) REFERENCES `literature_meta` (`id`),
  ADD CONSTRAINT `personalized_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- 限制表 `ppt`
--
ALTER TABLE `ppt`
  ADD CONSTRAINT `ppt_ibfk_1` FOREIGN KEY (`literature_id`) REFERENCES `literature_meta` (`id`);

--
-- 限制表 `report`
--
ALTER TABLE `report`
  ADD CONSTRAINT `report_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `report_ibfk_2` FOREIGN KEY (`updater_id`) REFERENCES `user` (`id`);

--
-- 限制表 `report_attachment`
--
ALTER TABLE `report_attachment`
  ADD CONSTRAINT `report_attachment_ibfk_1` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`);

--
-- 限制表 `report_code`
--
ALTER TABLE `report_code`
  ADD CONSTRAINT `report_code_ibfk_1` FOREIGN KEY (`code_id`) REFERENCES `code` (`id`),
  ADD CONSTRAINT `report_code_ibfk_2` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`);

--
-- 限制表 `report_data_set`
--
ALTER TABLE `report_data_set`
  ADD CONSTRAINT `report_data_set_ibfk_1` FOREIGN KEY (`data_set_id`) REFERENCES `data_set` (`id`),
  ADD CONSTRAINT `report_data_set_ibfk_2` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`);

--
-- 限制表 `report_literature`
--
ALTER TABLE `report_literature`
  ADD CONSTRAINT `report_literature_ibfk_1` FOREIGN KEY (`literature_id`) REFERENCES `literature_meta` (`id`),
  ADD CONSTRAINT `report_literature_ibfk_2` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`);

--
-- 限制表 `report_recording`
--
ALTER TABLE `report_recording`
  ADD CONSTRAINT `report_recording_ibfk_1` FOREIGN KEY (`report_id`) REFERENCES `report` (`id`);

--
-- 限制表 `tag_resource`
--
ALTER TABLE `tag_resource`
  ADD CONSTRAINT `tag_resource_ibfk_1` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`);

--
-- 限制表 `video`
--
ALTER TABLE `video`
  ADD CONSTRAINT `video_ibfk_1` FOREIGN KEY (`literature_id`) REFERENCES `literature_meta` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
