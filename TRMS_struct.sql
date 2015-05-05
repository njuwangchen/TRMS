-- phpMyAdmin SQL Dump
-- version 4.0.8
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2015-05-05 14:58:51
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

-- --------------------------------------------------------

--
-- 表的结构 `attribute`
--

DROP TABLE IF EXISTS `attribute`;
CREATE TABLE IF NOT EXISTS `attribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  `type` int(11) NOT NULL,
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=19 ;

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
  `from_literature_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `updater_id` (`updater_id`),
  KEY `from_literature_id` (`from_literature_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=4 ;

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
  `from_literature_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `data_set_type_id` (`data_set_type_id`),
  KEY `updater_id` (`updater_id`),
  KEY `from_literature_id` (`from_literature_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=3 ;

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
-- 表的结构 `KB__conference`
--

DROP TABLE IF EXISTS `KB__conference`;
CREATE TABLE IF NOT EXISTS `KB__conference` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `abbreviation` varchar(128) COLLATE utf8_bin NOT NULL,
  `full` varchar(256) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- 表的结构 `KB__conference__year`
--

DROP TABLE IF EXISTS `KB__conference__year`;
CREATE TABLE IF NOT EXISTS `KB__conference__year` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `abbreviation` varchar(128) COLLATE utf8_bin NOT NULL,
  `year` int(11) NOT NULL,
  `location` varchar(256) COLLATE utf8_bin NOT NULL,
  `editor` varchar(256) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- 表的结构 `KB__journal`
--

DROP TABLE IF EXISTS `KB__journal`;
CREATE TABLE IF NOT EXISTS `KB__journal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `abbreviation` varchar(128) COLLATE utf8_bin NOT NULL,
  `full` varchar(256) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- 表的结构 `KB__journal__year__issue`
--

DROP TABLE IF EXISTS `KB__journal__year__issue`;
CREATE TABLE IF NOT EXISTS `KB__journal__year__issue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `abbreviation` varchar(128) COLLATE utf8_bin NOT NULL,
  `year` int(11) NOT NULL,
  `issue` int(11) NOT NULL,
  `editor` varchar(256) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=3 ;

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
  `publisher_abbreviation` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  KEY `literature_type_id` (`literature_type_id`),
  KEY `updater_id` (`updater_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=13 ;

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
  `fileName` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `literature_id` (`literature_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=9 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=5 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `tag`
--

DROP TABLE IF EXISTS `tag`;
CREATE TABLE IF NOT EXISTS `tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_bin NOT NULL,
  `type` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=3 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=3 ;

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
  ADD CONSTRAINT `code_ibfk_3` FOREIGN KEY (`from_literature_id`) REFERENCES `literature_meta` (`id`),
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
  ADD CONSTRAINT `data_set_ibfk_4` FOREIGN KEY (`from_literature_id`) REFERENCES `literature_meta` (`id`),
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
