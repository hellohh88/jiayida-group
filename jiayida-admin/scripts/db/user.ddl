CREATE TABLE `USER` (
  `ID` int(11) NOT NULL,
  `CELL_PHONE` varchar(11) COLLATE utf8_bin NOT NULL,
  `PHONE` varchar(16) COLLATE utf8_bin DEFAULT NULL,
  `NAME` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `GENDER` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT 'M/F',
  `AGE` int(11) DEFAULT NULL,
  `ID_CARD` varchar(18) COLLATE utf8_bin DEFAULT NULL,
  `ADDRESS` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `COMMENT` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID`,`CELL_PHONE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
