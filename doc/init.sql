-- 信托人表
DROP TABLE IF EXISTS `trustee`;

CREATE TABLE `trustee` (
	`id` BIGINT (20) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR (255) NOT NULL COMMENT '姓名',
	`phone` VARCHAR (255) NOT NULL COMMENT '手机号',
	`email` VARCHAR (255) NULL COMMENT 'E-mail',
	`login_pwd` VARCHAR (255) NOT NULL COMMENT '密码',
	`login_salt` VARCHAR (255) NOT NULL COMMENT '加密盐',
	`status` INT (1) NOT NULL COMMENT '持有状态 0持有 1不持有',
	`principal` DECIMAL (10, 3) NOT NULL COMMENT '总投资额(本金)',
	`create_time` DATETIME NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT '信托人表';

-- 信托人每日报表
DROP TABLE IF EXISTS `trustee_by_day`;

CREATE TABLE `trustee_by_day` (
	`id` BIGINT (20) NOT NULL AUTO_INCREMENT,
	`trustee_id` BIGINT (20) NOT NULL,
	`name` VARCHAR (255) NOT NULL COMMENT '姓名',
	`fund_id` BIGINT (20) NOT NULL,
	`fund_name` VARCHAR (255) NOT NULL COMMENT '基金名',
	`date` VARCHAR (20) NOT NULL COMMENT '日期',
	`principal` DECIMAL (10, 3) NOT NULL COMMENT '投资额(本金)',
	`total_unit` INT (8) NOT NULL COMMENT '份额',
	`net_unit_value` DECIMAL (7, 3) NOT NULL COMMENT '净值',
	`total` DECIMAL (10, 3) NOT NULL COMMENT '总资产',
	`income` DECIMAL (10, 3) NOT NULL COMMENT '收益',
	`rate_of_return` DECIMAL (7, 3) NOT NULL COMMENT '收益率',
	`create_time` DATETIME NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT '信托人日报表';

-- 基金信息
DROP TABLE IF EXISTS `fund`;

CREATE TABLE `fund` (
	`id` BIGINT (20) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR (255) NOT NULL COMMENT '名称',
	`banlance` DECIMAL (10, 3) NOT NULL COMMENT '现金余额',
	`principal` DECIMAL (10, 3) NOT NULL COMMENT '总投资额(本金)',
	`position` DECIMAL (10, 3) NOT NULL COMMENT '仓位(百分数)',
	`total_unit` INT (8) NOT NULL COMMENT '总份额',
	`num_of_trustee` INT (3) NOT NULL COMMENT '信托人数',
	`create_time` DATETIME NOT NULL,
	`update_time` DATETIME NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT '基金';

-- 基金每日报表
DROP TABLE IF EXISTS `fund_by_day`;

CREATE TABLE `fund_by_day` (
	`id` BIGINT (20) NOT NULL AUTO_INCREMENT,
	`fund_id` BIGINT (20) NOT NULL,
	`date` VARCHAR (20) NOT NULL COMMENT '日期',
	`name` VARCHAR (255) NOT NULL COMMENT '名称',
	`banlance` DECIMAL (10, 3) NOT NULL COMMENT '现金余额',
	`principal` DECIMAL (10, 3) NOT NULL COMMENT '总投资额(本金)',
	`position` DECIMAL (10, 3) NOT NULL COMMENT '仓位(百分数)',
	`total_unit` INT (8) NOT NULL COMMENT '份额',
	`num_of_trustee` INT (3) NOT NULL COMMENT '信托人数',
	`market_value` DECIMAL (10, 3) NOT NULL COMMENT '股票市值',
	`total` DECIMAL (10, 3) NOT NULL COMMENT '总资产',
	`net_unit_value` DECIMAL (6, 3) NOT NULL COMMENT '净值',
	`income` DECIMAL (10, 3) NOT NULL COMMENT '总收益',
	`rate_of_return` DECIMAL (7, 3) NOT NULL COMMENT '收益率',
	`create_time` DATETIME NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT '基金每日报表';

-- 信托人交易记录
DROP TABLE IF EXISTS `trustee_trade`;

CREATE TABLE `trustee_trade` (
	`id` BIGINT (20) NOT NULL AUTO_INCREMENT,
	`trustee_id` BIGINT (20) NOT NULL,
	`name` VARCHAR (255) NOT NULL COMMENT '姓名',
	`status` INT(1) NOT NULL COMMENT '状态 0确认中 1已确认 2已赎回',
	`fund_id` BIGINT (20) NOT NULL,
	`fund_name` VARCHAR (255) NOT NULL COMMENT '基金名',
	`start_date` DATETIME NULL COMMENT '日期',
	`end_date` DATETIME NULL COMMENT '到期日期',
	`cycle` INT(1) NOT NULL COMMENT '持有周期',
	`unit` INT (8) NOT NULL COMMENT '交易份额',
	`unit_price` DECIMAL (10, 3) NOT NULL COMMENT '认购价',
  `total` DECIMAL (10, 3) NOT NULL COMMENT '认购额',
	`sale_unit_price` DECIMAL (10,3) NULL COMMENT '赎回价',
	`sale_total` DECIMAL (10, 3) NULL COMMENT '赎回额',
	`interest_rate` INT (10) NOT NULL COMMENT '年化利率',
	`income` DECIMAL (10, 3) NULL COMMENT '赎回后盈利',
	`income_rate` DECIMAL (10, 3) NULL COMMENT '赎回后盈利率',
	`create_time` DATETIME NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT '信托人交易记录';

-- 基金股票份额
DROP TABLE IF EXISTS `fund_stock`;

CREATE TABLE `fund_stock` (
	`id` BIGINT (20) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR (6) NOT NULL COMMENT '股票名称',
	`code` VARCHAR (6) NOT NULL COMMENT '股票代码',
	`market_type` INT (1) NOT NULL COMMENT '股票市场 0上证 1深证',
	`status` INT (1) NOT NULL COMMENT '持有状态 0持有 1不持有',
	`fund_id` BIGINT (20) NOT NULL,
	`fund_name` VARCHAR (255) NOT NULL COMMENT '基金名',
	`unit` INT (8) NOT NULL COMMENT '数量',
	`unit_price` DECIMAL (10, 3) NOT NULL COMMENT '成本价',
	`total` DECIMAL (10, 3) NOT NULL COMMENT '总成本',
	`create_time` DATETIME NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT '基金股票份额';

-- 股票交易记录
DROP TABLE IF EXISTS `stock_trade`;

CREATE TABLE `stock_trade` (
	`id` BIGINT (20) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR (6) NOT NULL COMMENT '股票名称',
	`code` VARCHAR (6) NOT NULL COMMENT '股票代码',
	`fund_id` BIGINT (20) NOT NULL,
	`fund_name` VARCHAR (255) NOT NULL COMMENT '基金名',
	`unit` INT (8) NOT NULL COMMENT '数量',
	`unit_price` DECIMAL (10, 3) NOT NULL COMMENT '成交价',
	`total` DECIMAL (10, 3) NOT NULL COMMENT '总成交额',
	`type` INT (1) NOT NULL COMMENT '交易类型 0买入 1卖出',
	`date` VARCHAR (20) NOT NULL COMMENT '日期',
	`create_time` DATETIME NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT '股票交易记录';

-- 股票分红
DROP TABLE IF EXISTS `stock_fix`;

CREATE TABLE `stock_fix` (
	`id` BIGINT (20) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR (6) NOT NULL COMMENT '股票名称',
	`code` VARCHAR (6) NOT NULL COMMENT '股票代码',
	`unit` INT (8) NULL COMMENT '每10股派股数量',
	`cash` DECIMAL (10, 3) NULL COMMENT '每10股派发现金',
	`reason` VARCHAR (255) NOT NULL COMMENT '调整原因',
	`date` VARCHAR (20) NOT NULL COMMENT '除权日期',
	`create_time` DATETIME NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT '股票分红';

-- 股票收盘记录
DROP TABLE IF EXISTS `stock_price`;

CREATE TABLE `stock_price` (
	`id` BIGINT (20) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR (6) NOT NULL COMMENT '股票名称',
	`code` VARCHAR (6) NOT NULL COMMENT '股票代码',
	`price` DECIMAL (10, 3) NULL COMMENT '收盘价',
	`date` VARCHAR (20) NOT NULL COMMENT '日期',
	`create_time` DATETIME NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT '股票收盘记录';

-- 角色
DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
	`id` BIGINT (20) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR (20) NOT NULL COMMENT '角色名',
	`code` VARCHAR (20) NOT NULL COMMENT '代码',
	`status` INT(1) NOT NULL COMMENT '状态 0启用 1禁用',
	`create_time` DATETIME NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT '角色';

-- 权限
DROP TABLE IF EXISTS `permission`;

CREATE TABLE `permission` (
	`id` BIGINT (20) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR (20) NOT NULL COMMENT '权限名',
	`code` VARCHAR (50) NOT NULL COMMENT '代码',
	`url`  VARCHAR (255) NULL COMMENT '资源链接',
	`status` INT(1) NOT NULL COMMENT '状态 0启用 1禁用',
	`create_time` DATETIME NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT '权限';

-- 用户角色表
DROP TABLE IF EXISTS `trustee_role`;

CREATE TABLE `trustee_role` (
	`id` BIGINT (20) NOT NULL AUTO_INCREMENT,
	`trustee_id` BIGINT (20) NOT NULL COMMENT '用户ID',
	`role_id` BIGINT (20) NOT NULL COMMENT '角色ID',
	`create_time` DATETIME NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT '用户角色表';

-- 角色权限表
DROP TABLE IF EXISTS `role_permission`;

CREATE TABLE `role_permission` (
	`id` BIGINT (20) NOT NULL AUTO_INCREMENT,
	`permission_id` BIGINT (20) NOT NULL COMMENT '权限ID',
	`role_id` BIGINT (20) NOT NULL COMMENT '角色ID',
	`create_time` DATETIME NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT '角色权限表';

-- 股票表
DROP TABLE IF EXISTS `stock`;

CREATE TABLE `stock` (
	`id` BIGINT (20) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR (6) NOT NULL COMMENT '股票名称',
	`code` VARCHAR (6) NOT NULL COMMENT '股票代码',
	`create_time` DATETIME NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT '股票';

-- 股票财务信息
DROP TABLE IF EXISTS `stock_finance`;

CREATE TABLE `stock_finance` (
	`id` BIGINT (20) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR (6) NOT NULL COMMENT '股票名称',
	`code` VARCHAR (6) NOT NULL COMMENT '股票代码',
	`date` VARCHAR (10) NOT NULL COMMENT '日期',
	`date_type` INT(1) NOT NULL COMMENT '1 第一季报表 2 半年报表 3 前三季报表 4 全年报表',
	`type` VARCHAR(10) NOT NULL COMMENT 'ZXCWZB 最新财务指标, CWBL 财务比率, ZCFZ 资产负债, LR 利润表, XJLL 现金流量, ZYSRFB 主营收入, ZCJZ 资产减值, YSZK 应收账款, QTYSZK 其他应收账款',
	`info` VARCHAR (2000) NULL COMMENT 'JSON',
	`info_version` INT(2) NULL COMMENT 'JSON数据版本',
	`create_time` DATETIME NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT '股票财务信息';

-- 测试数据 phone:100 pwd:000
INSERT INTO `trustee` VALUES ('1', 'sun', '100', 'sunjx1988@163.com', '0cLUnxHdkemzwUwhCmSYhW4J4hey+mgrFW4onKmMbcw=', 'GdrucpP6szbow28+aFOXSw==', '1', '0.00', '2019-03-08 21:05:54');
INSERT INTO `role` VALUES ('1', '系统管理员', 'admin', '0', '2019-03-08 22:06:53');
INSERT INTO `trustee_role` VALUES ('1', '1', '1', '2019-03-08 22:07:03');

INSERT INTO `fund` VALUES ('1', '企业号', '0.00', '0.00', '0.00', '0', '0', '2019-03-01 00:00:00', '2019-03-01 00:00:00');
