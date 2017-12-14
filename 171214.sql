/*
SQLyog Professional v12.08 (64 bit)
MySQL - 5.7.18-log : Database - blog_mini
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`blog_mini` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `blog_mini`;

/*Table structure for table `alembic_version` */

DROP TABLE IF EXISTS `alembic_version`;

CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `alembic_version` */

insert  into `alembic_version`(`version_num`) values ('051691f120e6');

/*Table structure for table `articles` */

DROP TABLE IF EXISTS `articles`;

CREATE TABLE `articles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) DEFAULT NULL,
  `content` text,
  `summary` text,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `num_of_view` int(11) DEFAULT NULL,
  `articleType_id` int(11) DEFAULT NULL,
  `source_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  KEY `articleType_id` (`articleType_id`),
  KEY `source_id` (`source_id`),
  KEY `ix_articles_create_time` (`create_time`),
  KEY `ix_articles_update_time` (`update_time`),
  CONSTRAINT `articles_ibfk_1` FOREIGN KEY (`articleType_id`) REFERENCES `articletypes` (`id`),
  CONSTRAINT `articles_ibfk_2` FOREIGN KEY (`source_id`) REFERENCES `sources` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `articles` */

insert  into `articles`(`id`,`title`,`content`,`summary`,`create_time`,`update_time`,`num_of_view`,`articleType_id`,`source_id`) values (1,'而沃尔沃是否','<p>十方三世</p>','所放松放松','2017-12-14 07:04:49','2017-12-14 07:04:49',1,1,1);

/*Table structure for table `articletypes` */

DROP TABLE IF EXISTS `articletypes`;

CREATE TABLE `articletypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `introduction` text,
  `menu_id` int(11) DEFAULT NULL,
  `setting_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `menu_id` (`menu_id`),
  KEY `setting_id` (`setting_id`),
  CONSTRAINT `articletypes_ibfk_1` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`),
  CONSTRAINT `articletypes_ibfk_2` FOREIGN KEY (`setting_id`) REFERENCES `articletypesettings` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `articletypes` */

insert  into `articletypes`(`id`,`name`,`introduction`,`menu_id`,`setting_id`) values (1,'未分类','系统默认分类，不可删除。',NULL,1);
insert  into `articletypes`(`id`,`name`,`introduction`,`menu_id`,`setting_id`) values (2,'啊啊啊','啊啊啊',NULL,2);

/*Table structure for table `articletypesettings` */

DROP TABLE IF EXISTS `articletypesettings`;

CREATE TABLE `articletypesettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `protected` tinyint(1) DEFAULT NULL,
  `hide` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `articletypesettings` */

insert  into `articletypesettings`(`id`,`name`,`protected`,`hide`) values (1,'system',1,1);
insert  into `articletypesettings`(`id`,`name`,`protected`,`hide`) values (2,'啊啊啊',0,0);

/*Table structure for table `blog_info` */

DROP TABLE IF EXISTS `blog_info`;

CREATE TABLE `blog_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) DEFAULT NULL,
  `signature` text,
  `navbar` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `blog_info` */

insert  into `blog_info`(`id`,`title`,`signature`,`navbar`) values (1,'开源博客系统Blog_mini','让每个人都轻松拥有可管理的个人博客！— By xpleaf','inverse');

/*Table structure for table `blog_view` */

DROP TABLE IF EXISTS `blog_view`;

CREATE TABLE `blog_view` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `num_of_view` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `blog_view` */

insert  into `blog_view`(`id`,`num_of_view`) values (1,5);

/*Table structure for table `comments` */

DROP TABLE IF EXISTS `comments`;

CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text,
  `timestamp` datetime DEFAULT NULL,
  `author_name` varchar(64) DEFAULT NULL,
  `author_email` varchar(64) DEFAULT NULL,
  `avatar_hash` varchar(32) DEFAULT NULL,
  `article_id` int(11) DEFAULT NULL,
  `disabled` tinyint(1) DEFAULT NULL,
  `comment_type` varchar(64) DEFAULT NULL,
  `reply_to` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `article_id` (`article_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `comments` */

/*Table structure for table `follows` */

DROP TABLE IF EXISTS `follows`;

CREATE TABLE `follows` (
  `follower_id` int(11) NOT NULL,
  `followed_id` int(11) NOT NULL,
  PRIMARY KEY (`follower_id`,`followed_id`),
  KEY `followed_id` (`followed_id`),
  CONSTRAINT `follows_ibfk_1` FOREIGN KEY (`followed_id`) REFERENCES `comments` (`id`),
  CONSTRAINT `follows_ibfk_2` FOREIGN KEY (`follower_id`) REFERENCES `comments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `follows` */

/*Table structure for table `menus` */

DROP TABLE IF EXISTS `menus`;

CREATE TABLE `menus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `order` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `menus` */

/*Table structure for table `plugins` */

DROP TABLE IF EXISTS `plugins`;

CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) DEFAULT NULL,
  `note` text,
  `content` text,
  `order` int(11) DEFAULT NULL,
  `disabled` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `plugins` */

insert  into `plugins`(`id`,`title`,`note`,`content`,`order`,`disabled`) values (1,'博客统计','系统插件','system_plugin',1,0);

/*Table structure for table `sources` */

DROP TABLE IF EXISTS `sources`;

CREATE TABLE `sources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `sources` */

insert  into `sources`(`id`,`name`) values (1,'原创');
insert  into `sources`(`id`,`name`) values (3,'翻译');
insert  into `sources`(`id`,`name`) values (2,'转载');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(64) DEFAULT NULL,
  `username` varchar(64) DEFAULT NULL,
  `password_hash` varchar(128) DEFAULT NULL,
  `avatar_hash` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_user_email` (`email`),
  UNIQUE KEY `ix_user_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`id`,`email`,`username`,`password_hash`,`avatar_hash`) values (1,'blog_mini@163.com','blog_mini','pbkdf2:sha1:1000$JyBBk00z$a6f65308d1e050d6133553023e3c8e761085d876','91450d6c690b3bc5a63ea05999818bbc');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
