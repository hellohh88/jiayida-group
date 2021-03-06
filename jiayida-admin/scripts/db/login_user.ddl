CREATE TABLE `LOGIN_USER` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `LOGIN_NAME` varchar(40) COLLATE utf8_bin NOT NULL,
  `PASSWORD` varchar(40) COLLATE utf8_bin NOT NULL,
  `SALT` varchar(8) COLLATE utf8_bin NOT NULL DEFAULT '0',
  `IM_ID` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `CELL_PHONE` varchar(11) COLLATE utf8_bin NOT NULL,
  `CELL_PHONE_TYPE` char(1) COLLATE utf8_bin DEFAULT NULL,
  `NAME` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `GENDER` char(1) COLLATE utf8_bin DEFAULT NULL,
  `ADDRESS` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `POSTAL_CODE` varchar(6) COLLATE utf8_bin DEFAULT NULL,
  `EMAIL` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `QQ` varchar(15) COLLATE utf8_bin DEFAULT NULL,
  `LOGIN_COUNT` mediumint(9) DEFAULT '0',
  `STATUS` char(1) COLLATE utf8_bin NOT NULL DEFAULT 'Y',
  `LAST_LOGIN_TIME` datetime DEFAULT NULL,
  `CREATE_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`,`LOGIN_NAME`,`CELL_PHONE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;



/*
CREATE TABLE `LOGIN_USER` (
  `USER_ID` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `EMAIL` VARCHAR(60) NOT NULL DEFAULT '',
  `USER_NAME` VARCHAR(60) NOT NULL DEFAULT '',
  `PASSWORD` VARCHAR(32) NOT NULL DEFAULT '',
  `QUESTION` VARCHAR(255) NOT NULL DEFAULT '',
  `ANSWER` VARCHAR(255) NOT NULL DEFAULT '',
  `SEX` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
  `BIRTHDAY` DATE DEFAULT NULL,
  `USER_MONEY` DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  `FROZEN_MONEY` DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  `PAY_POINTS` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `RANK_POINTS` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `ADDRESS_ID` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `REG_TIME` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `LAST_LOGIN` INT(11) UNSIGNED NOT NULL DEFAULT '0',
  `LAST_TIME` DATETIME DEFAULT NULL,
  `LAST_IP` VARCHAR(15) NOT NULL DEFAULT '',
  `VISIT_COUNT` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `USER_RANK` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `IS_SPECIAL` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `EC_SALT` VARCHAR(10) DEFAULT NULL,
  `SALT` VARCHAR(10) NOT NULL DEFAULT '0',
  `PARENT_ID` MEDIUMINT(9) NOT NULL DEFAULT '0',
  `FLAG` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `ALIAS` VARCHAR(60) NOT NULL,
  `MSN` VARCHAR(60) DEFAULT NULL,
  `QQ` VARCHAR(20) DEFAULT NULL,
  `OFFICE_PHONE` VARCHAR(20) DEFAULT NULL,
  `HOME_PHONE` VARCHAR(20) DEFAULT NULL,
  `MOBILE_PHONE` VARCHAR(20) DEFAULT NULL,
  `IS_VALIDATED` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `CREDIT_LINE` DECIMAL(10,2) UNSIGNED NOT NULL,
  `PASSWD_QUESTION` VARCHAR(50) DEFAULT NULL,
  `PASSWD_ANSWER` VARCHAR(255) DEFAULT NULL,
  `IM_ID` VARCHAR(45) DEFAULT NULL,
  `CELL_PHONE_TYPE` CHAR(1) DEFAULT NULL,
  PRIMARY KEY (`USER_ID`),
  UNIQUE KEY `USER_NAME` (`USER_NAME`),
  KEY `EMAIL` (`EMAIL`),
  KEY `PARENT_ID` (`PARENT_ID`),
  KEY `FLAG` (`FLAG`)
) ENGINE=FEDERATED DEFAULT CHARSET=UTF8 CONNECTION='mysql://dalianhunlian:dalianhunliancom@106.186.31.59:3306/jiayidashop/jydshop_users';
*/
