/*
MARIADB Backup
Source Server Version: 10.1.13
Source Database: starter
Date: 5/29/2016 12:57:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
--  Table structure for `auth_assignment`
-- ----------------------------
DROP TABLE IF EXISTS `auth_assignment`;
CREATE TABLE `auth_assignment` (
  `item_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_name`,`user_id`),
  CONSTRAINT `auth_assignment_ibfk_1` FOREIGN KEY (`item_name`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `auth_item`
-- ----------------------------
DROP TABLE IF EXISTS `auth_item`;
CREATE TABLE `auth_item` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `type` int(11) NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `rule_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `rule_name` (`rule_name`),
  KEY `idx-auth_item-type` (`type`),
  CONSTRAINT `auth_item_ibfk_1` FOREIGN KEY (`rule_name`) REFERENCES `auth_rule` (`name`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `auth_item_child`
-- ----------------------------
DROP TABLE IF EXISTS `auth_item_child`;
CREATE TABLE `auth_item_child` (
  `parent` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `child` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`),
  CONSTRAINT `auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `auth_rule`
-- ----------------------------
DROP TABLE IF EXISTS `auth_rule`;
CREATE TABLE `auth_rule` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `menu`
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `parent` int(11) DEFAULT NULL,
  `route` varchar(255) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `data` blob,
  `icon` varchar(100) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `parent` (`parent`),
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `menu` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `migration`
-- ----------------------------
DROP TABLE IF EXISTS `migration`;
CREATE TABLE `migration` (
  `version` varchar(180) NOT NULL,
  `apply_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `profile`
-- ----------------------------
DROP TABLE IF EXISTS `profile`;
CREATE TABLE `profile` (
  `user_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `public_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gravatar_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gravatar_id` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bio` text COLLATE utf8_unicode_ci,
  `language` varchar(25) COLLATE utf8_unicode_ci DEFAULT 'en',
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_user_profile` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `settings`
-- ----------------------------
DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `section` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` text,
  `active` tinyint(1) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_unique_key_section` (`section`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `social_account`
-- ----------------------------
DROP TABLE IF EXISTS `social_account`;
CREATE TABLE `social_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `client_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `code` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` int(11) DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_unique` (`provider`,`client_id`),
  UNIQUE KEY `account_unique_code` (`code`),
  KEY `fk_user_account` (`user_id`),
  CONSTRAINT `fk_user_account` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `token`
-- ----------------------------
DROP TABLE IF EXISTS `token`;
CREATE TABLE `token` (
  `user_id` int(11) NOT NULL,
  `code` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` int(11) NOT NULL,
  `type` smallint(6) NOT NULL,
  UNIQUE KEY `token_unique` (`user_id`,`code`,`type`),
  CONSTRAINT `fk_user_token` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_hash` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `auth_key` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `confirmed_at` int(11) DEFAULT NULL,
  `unconfirmed_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `blocked_at` int(11) DEFAULT NULL,
  `registration_ip` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_unique_email` (`email`),
  UNIQUE KEY `user_unique_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records 
-- ----------------------------
INSERT INTO `auth_assignment` VALUES ('superuser','1','1459680313');
INSERT INTO `auth_item` VALUES ('/admin/*','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/assignment/*','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/assignment/assign','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/assignment/index','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/assignment/revoke','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/assignment/view','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/default/*','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/default/index','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/menu/*','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/menu/create','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/menu/delete','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/menu/index','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/menu/update','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/menu/view','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/permission/*','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/permission/assign','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/permission/create','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/permission/delete','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/permission/index','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/permission/remove','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/permission/update','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/permission/view','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/role/*','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/role/assign','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/role/create','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/role/delete','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/role/index','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/role/remove','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/role/update','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/role/view','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/route/*','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/route/assign','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/route/create','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/route/index','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/route/refresh','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/route/remove','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/rule/*','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/rule/create','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/rule/delete','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/rule/index','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/rule/update','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/rule/view','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/user/*','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/user/activate','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/user/change-password','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/user/delete','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/user/index','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/user/login','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/user/logout','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/user/request-password-reset','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/user/reset-password','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/user/signup','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/admin/user/view','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/settings/*','2',NULL,NULL,NULL,'1459711629','1459711629'), ('/settings/default/*','2',NULL,NULL,NULL,'1459711629','1459711629'), ('/settings/default/create','2',NULL,NULL,NULL,'1459711629','1459711629'), ('/settings/default/delete','2',NULL,NULL,NULL,'1459711629','1459711629'), ('/settings/default/index','2',NULL,NULL,NULL,'1459711629','1459711629'), ('/settings/default/toggle','2',NULL,NULL,NULL,'1459711629','1459711629'), ('/settings/default/update','2',NULL,NULL,NULL,'1459711629','1459711629'), ('/settings/default/view','2',NULL,NULL,NULL,'1459711629','1459711629'), ('/site/*','2',NULL,NULL,NULL,'1459680239','1459680239'), ('/site/error','2',NULL,NULL,NULL,'1459680239','1459680239'), ('/site/index','2',NULL,NULL,NULL,'1459680239','1459680239'), ('/site/login','2',NULL,NULL,NULL,'1459680239','1459680239'), ('/site/logout','2',NULL,NULL,NULL,'1459680239','1459680239'), ('/user/*','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/user/admin/*','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/user/admin/assignments','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/user/admin/block','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/user/admin/confirm','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/user/admin/create','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/user/admin/delete','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/user/admin/index','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/user/admin/info','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/user/admin/update','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/user/admin/update-profile','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/user/profile/*','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/user/profile/index','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/user/profile/show','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/user/recovery/*','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/user/recovery/request','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/user/recovery/reset','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/user/registration/*','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/user/registration/confirm','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/user/registration/connect','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/user/registration/register','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/user/registration/resend','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/user/security/*','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/user/security/auth','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/user/security/login','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/user/security/logout','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/user/settings/*','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/user/settings/account','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/user/settings/confirm','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/user/settings/disconnect','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/user/settings/networks','2',NULL,NULL,NULL,'1459680222','1459680222'), ('/user/settings/profile','2',NULL,NULL,NULL,'1459680222','1459680222'), ('superuser','1','Top User',NULL,NULL,'1459680158','1459680158');
INSERT INTO `auth_item_child` VALUES ('superuser','/admin/*'), ('superuser','/settings/*'), ('superuser','/site/*'), ('superuser','/user/*');
INSERT INTO `menu` VALUES ('1','Dashboard',NULL,'/site/index','0',NULL,'fa fa-dashboard'), ('2','Users',NULL,NULL,'1',NULL,'fa fa-user'), ('3','Create User','2','/user/admin/create',NULL,NULL,''), ('4','Manage Users','2','/user/admin/index',NULL,NULL,''), ('5','Settings',NULL,NULL,'2',NULL,'fa fa-gear'), ('6','Manage Settings','5','/settings/default/index',NULL,NULL,''), ('7','Create Setting','5','/settings/default/create',NULL,NULL,'');
INSERT INTO `migration` VALUES ('m000000_000000_base','1459625255'), ('m140209_132017_init','1459625257'), ('m140403_174025_create_account_table','1459625257'), ('m140504_113157_update_tables','1459625257'), ('m140504_130429_create_token_table','1459625257'), ('m140506_102106_rbac_init','1459625277'), ('m140602_111327_create_menu_table','1459625285'), ('m140618_045255_create_settings','1459710898'), ('m140830_171933_fix_ip_field','1459625257'), ('m140830_172703_change_account_table_name','1459625258'), ('m141222_110026_update_ip_field','1459625258'), ('m141222_135246_alter_username_length','1459625258'), ('m150614_103145_update_social_account_table','1459625258'), ('m150623_212711_fix_username_notnull','1459625258'), ('m151126_091910_add_unique_index','1459710898');
INSERT INTO `profile` VALUES ('1','Ahmad ElSaidy','ahmad.elsaidy@hotmail.com','','d41d8cd98f00b204e9800998ecf8427e','Israel','http://inspireusweb.com/','new company','nl');
INSERT INTO `token` VALUES ('1','U4GBacHpGybNjabW5G0-u6Ih9WLVqrrD','1459625585','0');
INSERT INTO `user` VALUES ('1','admin','abed.m.alzain@gmail.com','$2y$10$jprwtc2WOrxftwSWtGOPEexaF3DdAnohpZ1ziAyq7PgGgxGqzSd92','txiBTY-smw356IF73-rfF0RB1ud8uLHT','1427441344',NULL,NULL,'127.0.0.1','1459625585','1459625585','0');
