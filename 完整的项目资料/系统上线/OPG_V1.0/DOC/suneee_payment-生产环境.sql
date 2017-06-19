/*
Navicat MySQL Data Transfer

Source Server         : 测试 172.19.6.115
Source Server Version : 50549
Source Host           : 172.19.6.115:3306
Source Database       : suneee_payment

Target Server Type    : MYSQL
Target Server Version : 50549
File Encoding         : 65001

Date: 2016-10-18 10:53:13
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for abnormal_request
-- ----------------------------
DROP TABLE IF EXISTS `abnormal_request`;
CREATE TABLE `abnormal_request` (
  `pay_request_id` int(1) NOT NULL COMMENT '关联pay_request表的pay_request_id键',
  `apply_user` varchar(72) NOT NULL DEFAULT '',
  `apply_ts` datetime NOT NULL,
  `apply_reason` varchar(2000) NOT NULL DEFAULT '' COMMENT '申请异常描述',
  `audit_user` varchar(72) NOT NULL DEFAULT '' COMMENT '异常处理人',
  `audit_ts` datetime DEFAULT NULL COMMENT '异常处理时间',
  `audit_reason` varchar(2000) NOT NULL DEFAULT '' COMMENT '异常处理描述',
  `abnormal_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '订单异常状态,1:异常已反馈,2:异常已解决,3:异常未能解决',
  `abnormal_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '订单异类型,0:其他,1:支付状态正常为收到款,2:退款状态正常未退回客户款项',
  UNIQUE KEY `pay_request_id` (`pay_request_id`),
  CONSTRAINT `abnormal_request_ibfk_1` FOREIGN KEY (`pay_request_id`) REFERENCES `pay_request` (`pay_request_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for app_payment_channel
-- ----------------------------
DROP TABLE IF EXISTS `app_payment_channel`;
CREATE TABLE `app_payment_channel` (
  `app_payment_channel_id` int(11) NOT NULL AUTO_INCREMENT,
  `merchant_app_id` int(11) DEFAULT NULL,
  `payment_type_id` int(11) DEFAULT NULL,
  `scenary_id` int(11) DEFAULT NULL,
  `active_status` tinyint(1) DEFAULT '0' COMMENT '状态（1 草稿， 2 请求启用，3 启用， 4禁用）',
  `apply_user` varchar(72) DEFAULT NULL,
  `apply_ts` datetime DEFAULT NULL,
  `audit_user` varchar(72) DEFAULT NULL,
  `audit_reason` varchar(300) DEFAULT NULL,
  `audit_ts` datetime DEFAULT NULL,
  `admin_op` tinyint(1) DEFAULT '0' COMMENT '是否管理员操作(禁用) 1:是,0:否',
  PRIMARY KEY (`app_payment_channel_id`),
  UNIQUE KEY `app_payment_channel_uk` (`merchant_app_id`,`payment_type_id`,`scenary_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for area
-- ----------------------------
DROP TABLE IF EXISTS `area`;
CREATE TABLE `area` (
  `area_id` varchar(6) NOT NULL COMMENT '地区代码, 省、市、县/区',
  `name` varchar(72) DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`area_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of area
-- ----------------------------

-- ----------------------------
-- Table structure for merchant
-- ----------------------------
DROP TABLE IF EXISTS `merchant`;
CREATE TABLE `merchant` (
  `merchant_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '平台商家ID ',
  `name` varchar(64) DEFAULT NULL COMMENT '商家名称',
  `is_merchant` tinyint(4) DEFAULT NULL COMMENT '是否是商家, 如果为0默认为SE支付网关默认账户，1 是',
  `se_payment_code` varchar(32) DEFAULT NULL COMMENT '商户的支付网关号',
  `description` varchar(256) DEFAULT NULL COMMENT '商家描述',
  `is_scode` tinyint(1) DEFAULT '0' COMMENT '是否是手机扫码支付商户',
  `admin_account` varchar(72) DEFAULT NULL COMMENT '企业账户/首次注册者的登录账户',
  `memo` varchar(300) DEFAULT NULL COMMENT '备注',
  `active` tinyint(1) DEFAULT '0' COMMENT '是否激活 : 1 激活; 0 未激活;',
  PRIMARY KEY (`merchant_id`),
  UNIQUE KEY `merchant_uk` (`se_payment_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for merchant_app
-- ----------------------------
DROP TABLE IF EXISTS `merchant_app`;
CREATE TABLE `merchant_app` (
  `merchant_app_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商户App的ID',
  `merchant_id` int(11) DEFAULT NULL COMMENT '商家id (关联merchant表)',
  `app_name` varchar(72) DEFAULT NULL COMMENT '应用名称',
  `apply_date` datetime DEFAULT NULL COMMENT '申请日期',
  `status_flag` tinyint(1) DEFAULT '0' COMMENT '状态(0草稿, 1 申请开通, 2 通过，3 拒绝)',
  `status_ts` datetime DEFAULT NULL COMMENT '最新状态的时间',
  `auth_app_id` varchar(200) DEFAULT NULL COMMENT '授权应用ID ',
  `app_code` varchar(200) DEFAULT NULL COMMENT '应用Code',
  `status_del` tinyint(1) DEFAULT '0',
  `app_image` varchar(200) NOT NULL COMMENT '应用logo',
  PRIMARY KEY (`merchant_app_id`),
  UNIQUE KEY `merchant_app_uk` (`auth_app_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for merchant_info
-- ----------------------------
DROP TABLE IF EXISTS `merchant_info`;
CREATE TABLE `merchant_info` (
  `merchant_info_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'merchant_info_id',
  `merchant_id` int(11) DEFAULT NULL,
  `area_id` varchar(6) DEFAULT NULL,
  `member_id` varchar(32) DEFAULT NULL,
  `company_type` tinyint(1) DEFAULT '0' COMMENT '企业类型 (1象翌内部, 2象翌外部,3翌商云) ',
  `actual_name` varchar(64) DEFAULT NULL,
  `reg_address` varchar(512) DEFAULT NULL,
  `work_address` varchar(512) DEFAULT NULL,
  `contact_name` varchar(64) DEFAULT NULL,
  `contact_mail` varchar(72) DEFAULT NULL,
  `contact_mobile` varchar(64) DEFAULT NULL,
  `contact_telphone` varchar(512) DEFAULT NULL,
  `lisence_image` varchar(200) DEFAULT NULL,
  `org_image` varchar(200) DEFAULT NULL,
  `apply_user` varchar(72) DEFAULT NULL,
  `apply_ts` datetime DEFAULT NULL,
  `audit_status` tinyint(1) DEFAULT '0' COMMENT '是否签约 (0 初始， 1 资料已提交，待审核，2 审核通过，已签约， 3 审核不通过 )',
  `audit_ts` datetime DEFAULT NULL,
  `audit_user` varchar(72) DEFAULT NULL,
  `audit_reason` varchar(200) DEFAULT NULL COMMENT '签约审核通过与否的原因',
  PRIMARY KEY (`merchant_info_id`),
  UNIQUE KEY `merchant_info_uk` (`merchant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for merchant_info_action
-- ----------------------------
DROP TABLE IF EXISTS `merchant_info_action`;
CREATE TABLE `merchant_info_action` (
  `merchant_id` int(11) DEFAULT NULL COMMENT '关联merchant_info表的merchant_id键',
  `merchant_name` varchar(64) DEFAULT NULL COMMENT '商家名称',
  `area_id` varchar(6) DEFAULT NULL,
  `member_id` varchar(32) DEFAULT NULL,
  `company_type` tinyint(1) DEFAULT '0' COMMENT '企业类型 (1象翌内部, 2象翌外部,3翌商云) ',
  `actual_name` varchar(64) DEFAULT NULL,
  `reg_address` varchar(512) DEFAULT NULL,
  `work_address` varchar(512) DEFAULT NULL,
  `contact_name` varchar(64) DEFAULT NULL,
  `contact_mail` varchar(72) DEFAULT NULL,
  `contact_mobile` varchar(64) DEFAULT NULL,
  `contact_telphone` varchar(512) DEFAULT NULL,
  `lisence_image` varchar(200) DEFAULT NULL,
  `org_image` varchar(200) DEFAULT NULL,
  `apply_user` varchar(72) DEFAULT NULL,
  `apply_ts` datetime DEFAULT NULL,
  `audit_status` tinyint(1) DEFAULT '0' COMMENT '是否签约 (0 初始， 1 资料已提交，待审核，2 审核通过，已签约， 3 审核不通过 )',
  `audit_ts` datetime DEFAULT NULL,
  `audit_user` varchar(72) DEFAULT NULL,
  `audit_reason` varchar(200) DEFAULT NULL COMMENT '签约审核通过与否的原因',
  `account` varchar(200) DEFAULT NULL COMMENT '提交审核的登入邮箱',
  `admin_op` tinyint(1) DEFAULT '0' COMMENT '是否管理员操作',
  KEY `merchant_id` (`merchant_id`),
  CONSTRAINT `merchant_info_action_ibfk_1` FOREIGN KEY (`merchant_id`) REFERENCES `merchant_info` (`merchant_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for merchant_info_log
-- ----------------------------
DROP TABLE IF EXISTS `merchant_info_log`;
CREATE TABLE `merchant_info_log` (
  `merchant_id` int(11) DEFAULT NULL COMMENT '关联merchant表的merchant_id键',
  `merchant_name` varchar(64) DEFAULT NULL COMMENT '商家名称',
  `area_id` varchar(6) DEFAULT NULL,
  `member_id` varchar(32) DEFAULT NULL,
  `company_type` tinyint(1) DEFAULT '0' COMMENT '企业类型 (1象翌内部, 2象翌外部,3翌商云) ',
  `actual_name` varchar(64) DEFAULT NULL,
  `reg_address` varchar(512) DEFAULT NULL,
  `work_address` varchar(512) DEFAULT NULL,
  `contact_name` varchar(64) DEFAULT NULL,
  `contact_mail` varchar(72) DEFAULT NULL,
  `contact_mobile` varchar(64) DEFAULT NULL,
  `contact_telphone` varchar(512) DEFAULT NULL,
  `lisence_image` varchar(200) DEFAULT NULL,
  `org_image` varchar(200) DEFAULT NULL,
  `apply_user` varchar(72) DEFAULT NULL,
  `apply_ts` datetime DEFAULT NULL,
  `audit_status` tinyint(1) DEFAULT '1' COMMENT '是否签约 ( 1 资料已提交，待审核，2 审核通过，已签约， 3 审核不通过 )',
  `audit_ts` datetime DEFAULT NULL,
  `audit_user` varchar(72) DEFAULT NULL,
  `audit_reason` varchar(200) DEFAULT NULL COMMENT '签约审核通过与否的原因',
  `account` varchar(200) DEFAULT NULL COMMENT '提交审核的登入邮箱',
  `admin_op` tinyint(1) DEFAULT '0' COMMENT '是否管理员操作',
  KEY `merchant_id` (`merchant_id`),
  CONSTRAINT `merchant_info_action_ibfk_2` FOREIGN KEY (`merchant_id`) REFERENCES `merchant_info` (`merchant_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for merchant_payment_channel
-- ----------------------------
DROP TABLE IF EXISTS `merchant_payment_channel`;
CREATE TABLE `merchant_payment_channel` (
  `merchant_payment_channel_id` int(11) NOT NULL AUTO_INCREMENT,
  `merchant_id` int(11) DEFAULT NULL,
  `payment_type_id` int(11) DEFAULT NULL,
  `active_status` tinyint(1) DEFAULT '0' COMMENT '状态（1 草稿， 2 请求启用，3 启用， 4禁用）',
  `apply_user` varchar(72) DEFAULT NULL,
  `apply_ts` datetime DEFAULT NULL,
  `audit_user` varchar(72) DEFAULT NULL,
  `audit_reason` varchar(300) DEFAULT NULL,
  `audit_ts` datetime DEFAULT NULL,
  `admin_op` tinyint(1) unsigned DEFAULT '0' COMMENT '是否管理员操作(禁用) 1:是,0:否',
  PRIMARY KEY (`merchant_payment_channel_id`),
  UNIQUE KEY `merchant_payment_channel_uk` (`merchant_id`,`payment_type_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for merchant_payment_config
-- ----------------------------
DROP TABLE IF EXISTS `merchant_payment_config`;
CREATE TABLE `merchant_payment_config` (
  `config_id` int(11) NOT NULL AUTO_INCREMENT,
  `merchant_app_id` int(11) DEFAULT NULL,
  `para_define_id` int(11) DEFAULT NULL,
  `para_value` varchar(2000) DEFAULT NULL,
  `created_ts` datetime DEFAULT NULL COMMENT '配置新增时间',
  `modified_ts` datetime DEFAULT NULL COMMENT '配置修改时间',
  PRIMARY KEY (`config_id`),
  UNIQUE KEY `merchant_payment_config_uk` (`merchant_app_id`,`para_define_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for merchant_payment_key
-- ----------------------------
DROP TABLE IF EXISTS `merchant_payment_key`;
CREATE TABLE `merchant_payment_key` (
  `payment_key_id` int(11) NOT NULL AUTO_INCREMENT,
  `merchant_id` int(11) DEFAULT NULL,
  `se_payment_key` varchar(2000) DEFAULT NULL,
  `expired_ts` datetime DEFAULT NULL,
  `active` tinyint(1) DEFAULT '0',
  `created_ts` datetime DEFAULT NULL,
  `se_private_key` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`payment_key_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for pay_request
-- ----------------------------
DROP TABLE IF EXISTS `pay_request`;
CREATE TABLE `pay_request` (
  `pay_request_id` int(11) NOT NULL AUTO_INCREMENT,
  `auth_app_id` varchar(32) DEFAULT NULL,
  `payment_type_id` int(11) DEFAULT NULL,
  `scenary_id` int(11) DEFAULT NULL,
  `pay_no` varchar(32) DEFAULT NULL,
  `bill_id` varchar(32) DEFAULT NULL,
  `bill_type_id` varchar(32) DEFAULT NULL,
  `se_payment_code` varchar(2000) DEFAULT NULL,
  `subject` varchar(32) DEFAULT NULL,
  `description` varchar(256) DEFAULT NULL,
  `third_trade_no` varchar(32) DEFAULT NULL,
  `return_url` varchar(512) DEFAULT NULL,
  `notify_url` varchar(512) DEFAULT NULL,
  `show_url` varchar(512) DEFAULT NULL,
  `sessionId` varchar(2000) DEFAULT NULL,
  `pay_client` varchar(32) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `merchant_id` int(11) DEFAULT NULL,
  `pay_account` varchar(50) DEFAULT NULL COMMENT '付款号(用户配置的account)',
  `currency_code` varchar(3) DEFAULT NULL,
  `amount` float DEFAULT NULL,
  `created_ts` datetime DEFAULT NULL,
  `modified_ts` datetime DEFAULT NULL,
  `abnormal_status` tinyint(4) DEFAULT '0' COMMENT '订单异常状态,0:无异常,1:异常已反馈,2:异常已解决,3:异常未能解决',
  PRIMARY KEY (`pay_request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000000 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for pay_request_flow
-- ----------------------------
DROP TABLE IF EXISTS `pay_request_flow`;
CREATE TABLE `pay_request_flow` (
  `pay_request_flow_id` int(11) NOT NULL AUTO_INCREMENT,
  `pay_request_id` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `result` text,
  `created_ts` datetime DEFAULT NULL,
  PRIMARY KEY (`pay_request_flow_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for payment_parameter_define
-- ----------------------------
DROP TABLE IF EXISTS `payment_parameter_define`;
CREATE TABLE `payment_parameter_define` (
  `para_define_id` int(11) NOT NULL AUTO_INCREMENT,
  `payment_type_id` int(11) DEFAULT NULL,
  `scenary_id` int(11) DEFAULT NULL,
  `para_name` varchar(32) DEFAULT NULL,
  `para_type` smallint(6) DEFAULT NULL,
  `para_length` smallint(6) DEFAULT NULL COMMENT '1整数,2数字,3字符串,4 日期 (yyyy-mm-dd),5 时间 ,6 时间戳,7文件，9 二进制字节',
  `input_tips` varchar(32) DEFAULT NULL,
  `input_desc` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`para_define_id`),
  UNIQUE KEY `payment_parameter_define_uk` (`payment_type_id`,`scenary_id`,`para_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of payment_parameter_define
-- ----------------------------
INSERT INTO `payment_parameter_define` VALUES ('1', '1', '1', 'alipay_partner', '1', '16', '以2088开头的16位纯数字', '合作身份者id');
INSERT INTO `payment_parameter_define` VALUES ('2', '1', '1', 'alipay_seller', '3', '100', 'string', '收款支付宝账号');
INSERT INTO `payment_parameter_define` VALUES ('3', '1', '1', 'key', '3', '32', '数字和字母组成的32位字符', '安全检验码');
INSERT INTO `payment_parameter_define` VALUES ('4', '1', '2', 'alipay_partner', '1', '16', '以2088开头的16位纯数字', '合作身份者id');
INSERT INTO `payment_parameter_define` VALUES ('5', '1', '2', 'alipay_seller', '1', '100', 'String', '收款支付宝账号');
INSERT INTO `payment_parameter_define` VALUES ('6', '1', '2', 'key', '3', '32', '数字和字母组成的32位字符', '安全检验码');
INSERT INTO `payment_parameter_define` VALUES ('7', '1', '3', 'alipay_partner', '1', '16', '以2088开头的16位纯数字', '合作身份者id');
INSERT INTO `payment_parameter_define` VALUES ('8', '1', '3', 'alipay_seller', '3', '100', 'string', '收款支付宝账号');
INSERT INTO `payment_parameter_define` VALUES ('9', '1', '3', 'key', '3', '32', '数字和字母组成的32位字符', '安全检验码');
INSERT INTO `payment_parameter_define` VALUES ('10', '1', '3', 'rsa_private_key.pem', '3', '100', 'string', '商户私钥文件内容');
INSERT INTO `payment_parameter_define` VALUES ('11', '1', '3', 'alipay_public_key.pem', '3', '100', 'string', '支付宝的公钥文件内容');
INSERT INTO `payment_parameter_define` VALUES ('12', '1', '4', 'alipay_partner', '1', '16', '以2088开头的16位纯数字', '合作身份者id');
INSERT INTO `payment_parameter_define` VALUES ('13', '1', '4', 'alipay_seller', '3', '100', 'string', '收款支付宝账号');
INSERT INTO `payment_parameter_define` VALUES ('14', '1', '4', 'key', '3', '32', '数字和字母组成的32位字符', '安全检验码');
INSERT INTO `payment_parameter_define` VALUES ('15', '1', '4', 'rsa_private_key.pem', '3', '100', 'string', '商户私钥文件内容');
INSERT INTO `payment_parameter_define` VALUES ('16', '1', '4', 'alipay_public_key.pem', '3', '100', 'string', '支付宝的公钥文件内容');
INSERT INTO `payment_parameter_define` VALUES ('17', '3', '1', 'appid', '3', '100', 'string', '微信公众号身份的唯一标识');
INSERT INTO `payment_parameter_define` VALUES ('18', '3', '1', 'mchid', '3', '100', 'string', '受理商ID，身份标识');
INSERT INTO `payment_parameter_define` VALUES ('19', '3', '1', 'key', '3', '100', 'string', '商户支付密钥Key');
INSERT INTO `payment_parameter_define` VALUES ('20', '3', '1', 'appsecret', '3', '100', 'string', '应用密钥，JSAPI接口(wap)中获取openid');
INSERT INTO `payment_parameter_define` VALUES ('21', '3', '1', 'apiclient_cert.pem', '3', '100', 'string', '证书');
INSERT INTO `payment_parameter_define` VALUES ('22', '3', '1', 'apiclient_key.pem', '3', '100', 'string', '证书');
INSERT INTO `payment_parameter_define` VALUES ('23', '3', '1', 'rootca.pem', '3', '100', 'string', '证书');
INSERT INTO `payment_parameter_define` VALUES ('24', '3', '2', 'appid', '3', '100', 'string', '微信公众号身份的唯一标识');
INSERT INTO `payment_parameter_define` VALUES ('25', '3', '2', 'mchid', '3', '100', 'string', '受理商ID，身份标识');
INSERT INTO `payment_parameter_define` VALUES ('26', '3', '2', 'key', '3', '100', 'string', '商户支付密钥Key');
INSERT INTO `payment_parameter_define` VALUES ('27', '3', '2', 'appsecret', '3', '100', 'string', '应用密钥，JSAPI接口(wap)中获取openid');
INSERT INTO `payment_parameter_define` VALUES ('28', '3', '2', 'apiclient_cert.pem', '3', '100', 'string', '证书');
INSERT INTO `payment_parameter_define` VALUES ('29', '3', '2', 'apiclient_key.pem', '3', '100', 'string', '证书');
INSERT INTO `payment_parameter_define` VALUES ('30', '3', '2', 'rootca.pem', '3', '100', 'string', '证书');
INSERT INTO `payment_parameter_define` VALUES ('31', '3', '3', 'appid', '3', '100', 'string', '微信公众号身份的唯一标识');
INSERT INTO `payment_parameter_define` VALUES ('32', '3', '3', 'mchid', '3', '100', 'string', '受理商ID，身份标识');
INSERT INTO `payment_parameter_define` VALUES ('33', '3', '3', 'key', '3', '100', 'string', '商户支付密钥Key');
INSERT INTO `payment_parameter_define` VALUES ('34', '3', '4', 'appid', '3', '100', 'string', '微信公众号身份的唯一标识');
INSERT INTO `payment_parameter_define` VALUES ('35', '3', '4', 'mchid', '3', '100', 'string', '受理商ID，身份标识');
INSERT INTO `payment_parameter_define` VALUES ('36', '3', '4', 'key', '3', '100', 'string', '商户支付密钥Key');
INSERT INTO `payment_parameter_define` VALUES ('37', '1', '1', 'cacert', '3', '10000', 'string', '支付宝证书');
INSERT INTO `payment_parameter_define` VALUES ('38', '2', '1', 'merid', '3', '100', 'string', '商户秘钥文件');
INSERT INTO `payment_parameter_define` VALUES ('39', '2', '1', 'busiid', '3', '100', 'string', '分支机构号');
INSERT INTO `payment_parameter_define` VALUES ('40', '2', '2', 'merid', '3', '100', 'string', '商户号');
INSERT INTO `payment_parameter_define` VALUES ('41', '2', '2', 'SDK_SIGN_CERT_PWD', '3', '100', 'string', '签名证书密码');
INSERT INTO `payment_parameter_define` VALUES ('42', '2', '1', 'prikeyS', '3', '1000', 'string', '商户秘钥S');
INSERT INTO `payment_parameter_define` VALUES ('43', '2', '1', 'prikeyE', '3', '1000', 'string', '商户秘钥E');
INSERT INTO `payment_parameter_define` VALUES ('44', '2', '2', 'SDK_SIGN_CERT_PATH', '7', '1000', 'string', '公钥和私钥的二进制格式的证书形式');
INSERT INTO `payment_parameter_define` VALUES ('45', '99', '1', 'rsa_private_key.pem', '3', '1000', 'string', '商户私钥文件内容');
INSERT INTO `payment_parameter_define` VALUES ('46', '99', '1', 'alipay_public_key.pem', '3', '1000', 'string', '支付宝的公钥文件内容');
INSERT INTO `payment_parameter_define` VALUES ('47', '3', '1', 'account', '3', '1000', 'string', '微信公众号名');
INSERT INTO `payment_parameter_define` VALUES ('48', '3', '2', 'account', '3', '1000', 'string', '微信公众号名');
INSERT INTO `payment_parameter_define` VALUES ('49', '3', '3', 'account', '3', '1000', 'string', '微信公众号名');
INSERT INTO `payment_parameter_define` VALUES ('50', '3', '4', 'account', '3', '1000', 'string', '微信公众号名');
INSERT INTO `payment_parameter_define` VALUES ('51', '1', '1', 'account', '3', '1000', 'string', '支付宝账户名');
INSERT INTO `payment_parameter_define` VALUES ('52', '1', '2', 'account', '3', '1000', 'string', '支付宝账户名');
INSERT INTO `payment_parameter_define` VALUES ('53', '1', '3', 'account', '3', '1000', 'string', '支付宝账户名');
INSERT INTO `payment_parameter_define` VALUES ('54', '1', '4', 'account', '3', '1000', 'string', '支付宝账户名');
INSERT INTO `payment_parameter_define` VALUES ('55', '2', '3', 'merId', '3', '100', 'string', '商户代码');
INSERT INTO `payment_parameter_define` VALUES ('56', '2', '3', 'SDK_SIGN_CERT_PWD', '3', '100', 'string', '签名证书密码');
INSERT INTO `payment_parameter_define` VALUES ('57', '2', '4', 'merId', '3', '100', 'string', '商户代码');
INSERT INTO `payment_parameter_define` VALUES ('58', '2', '4', 'SDK_SIGN_CERT_PWD', '3', '100', 'string', '签名证书密码');

-- ----------------------------
-- Table structure for payment_scenary
-- ----------------------------
DROP TABLE IF EXISTS `payment_scenary`;
CREATE TABLE `payment_scenary` (
  `scenary_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`scenary_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of payment_scenary
-- ----------------------------
INSERT INTO `payment_scenary` VALUES ('1', 'PC');
INSERT INTO `payment_scenary` VALUES ('2', 'WAP');
INSERT INTO `payment_scenary` VALUES ('3', 'IOS');
INSERT INTO `payment_scenary` VALUES ('4', 'Android');

-- ----------------------------
-- Table structure for payment_type
-- ----------------------------
DROP TABLE IF EXISTS `payment_type`;
CREATE TABLE `payment_type` (
  `payment_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `code` varchar(32) DEFAULT NULL,
  `active` tinyint(4) DEFAULT NULL COMMENT '启用状态,（0禁用,1 启用）',
  `is_transfer` tinyint(1) DEFAULT '0',
  `created_ts` datetime DEFAULT NULL,
  `modified_ts` datetime DEFAULT NULL,
  `type` tinyint(1) DEFAULT '0' COMMENT '类型(1 第三方支付, 2 银行，3 银联)',
  `op_user` varchar(72) DEFAULT NULL,
  `op_ts` datetime DEFAULT NULL,
  `op_reason` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`payment_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of payment_type
-- ----------------------------
INSERT INTO `payment_type` VALUES ('1', '支付宝', 'AliPay', '1', '1', '2015-08-31 12:00:00', '2015-08-31 12:00:00', '1', 'adminli', '2016-10-10 13:59:08', '发的');
INSERT INTO `payment_type` VALUES ('2', '银联支付', 'ChinaPay', '1', '1', '2015-08-31 12:00:00', '2015-08-31 12:00:00', '3', 'adminli', '2016-10-15 14:11:56', '股份个非官方和 好股份个非官方和 好股份个非官方和 好v股份');
INSERT INTO `payment_type` VALUES ('3', '微信支付', 'WeChatPay', '1', '1', '2015-08-31 12:00:00', '2015-08-31 12:00:00', '1', 'adminli', '2016-10-17 10:37:21', '212');
INSERT INTO `payment_type` VALUES ('4', '工商银行', 'IcbankPay', '1', '1', '2015-08-31 12:00:00', '2015-08-31 12:00:00', '2', 'admin', '2016-10-15 13:54:14', '重新启用');
INSERT INTO `payment_type` VALUES ('5', '招商银行', 'CmbankPay', '1', '1', '2015-08-31 12:00:00', '2015-08-31 12:00:00', '2', 'admin', '2015-08-31 23:00:00', '同意启用');
INSERT INTO `payment_type` VALUES ('6', '中金支付', 'ZjinPay', '0', '0', '2016-07-18 16:00:00', '2016-07-18 16:00:00', '2', 'adminli', '2016-10-15 14:05:06', '范德萨');

-- ----------------------------
-- Table structure for payment_type_scenary
-- ----------------------------
DROP TABLE IF EXISTS `payment_type_scenary`;
CREATE TABLE `payment_type_scenary` (
  `payment_type_id` int(11) NOT NULL,
  `scenary_id` int(11) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL COMMENT '启用状态,（0禁用， 1 启用）',
  `op_user` varchar(72) DEFAULT NULL,
  `op_ts` datetime DEFAULT NULL,
  `op_reason` varchar(300) DEFAULT NULL,
  UNIQUE KEY `payment_type_scenary_uk` (`payment_type_id`,`scenary_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of payment_type_scenary
-- ----------------------------
INSERT INTO `payment_type_scenary` VALUES ('1', '1', '1', 'admin', '2015-08-31 23:00:00', '同意');
INSERT INTO `payment_type_scenary` VALUES ('1', '2', '1', 'admin', '2015-08-31 23:00:00', '同意');
INSERT INTO `payment_type_scenary` VALUES ('1', '3', '0', 'admin', '2015-08-31 23:00:00', '不同意');
INSERT INTO `payment_type_scenary` VALUES ('1', '4', '0', 'admin', '2015-08-31 23:00:00', '不同意');
INSERT INTO `payment_type_scenary` VALUES ('3', '1', '1', 'admin', '2015-08-31 23:00:00', '同意');
INSERT INTO `payment_type_scenary` VALUES ('2', '1', '1', 'admin', '2015-08-31 23:00:00', '同意');
INSERT INTO `payment_type_scenary` VALUES ('2', '2', '1', 'admin', '2015-08-31 23:00:00', '同意');
INSERT INTO `payment_type_scenary` VALUES ('4', '3', '1', 'admin', '2015-08-31 23:00:00', '同意');
INSERT INTO `payment_type_scenary` VALUES ('4', '1', '0', 'admin', '2015-08-31 23:00:00', '不同意');
INSERT INTO `payment_type_scenary` VALUES ('2', '3', '1', 'admin', '2015-08-31 23:00:00', '同意');
INSERT INTO `payment_type_scenary` VALUES ('2', '4', '0', 'admin', '2015-08-31 23:00:00', '不同意');

-- ----------------------------
-- Table structure for refund_request
-- ----------------------------
DROP TABLE IF EXISTS `refund_request`;
CREATE TABLE `refund_request` (
  `refund_request_id` int(11) NOT NULL AUTO_INCREMENT,
  `merchant_id` int(11) DEFAULT NULL,
  `auth_app_id` varchar(32) DEFAULT NULL,
  `payment_type_id` int(11) DEFAULT NULL,
  `scenary_id` int(11) DEFAULT NULL,
  `refund_no` varchar(32) DEFAULT NULL,
  `pay_request_id` int(11) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `third_batch_no` varchar(32) DEFAULT NULL,
  `batch_no` varchar(32) NOT NULL DEFAULT '',
  `return_url` varchar(512) DEFAULT NULL,
  `notify_url` varchar(512) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `currency_code` varchar(3) DEFAULT NULL,
  `amount` float DEFAULT NULL,
  `is_send_email` tinyint(1) DEFAULT '0',
  `created_ts` datetime DEFAULT NULL,
  `modified_ts` datetime DEFAULT NULL,
  PRIMARY KEY (`refund_request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for refund_request_flow
-- ----------------------------
DROP TABLE IF EXISTS `refund_request_flow`;
CREATE TABLE `refund_request_flow` (
  `refund_request_flow_id` int(11) NOT NULL AUTO_INCREMENT,
  `refund_request_id` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `result` text,
  `created_ts` datetime DEFAULT NULL,
  PRIMARY KEY (`refund_request_flow_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for reg_user
-- ----------------------------
DROP TABLE IF EXISTS `reg_user`;
CREATE TABLE `reg_user` (
  `reg_user_id` int(11) NOT NULL AUTO_INCREMENT,
  `merchant_id` int(11) DEFAULT NULL,
  `account` varchar(72) DEFAULT NULL,
  `passwd` varchar(32) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0' COMMENT '状态：0 未激活, 1 已经激活, 2 停用',
  `reg_ts` datetime DEFAULT NULL,
  `active_ts` datetime DEFAULT NULL,
  `stop_ts` datetime DEFAULT NULL,
  `login_ts` datetime DEFAULT NULL,
  `short_message` varchar(20) DEFAULT NULL,
  `time_message` bigint(20) NOT NULL DEFAULT '0' COMMENT '验证码生成时间戳',
  PRIMARY KEY (`reg_user_id`),
  UNIQUE KEY `reg_user_account` (`account`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for status
-- ----------------------------
DROP TABLE IF EXISTS `status`;
CREATE TABLE `status` (
  `status_id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(16) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of status
-- ----------------------------
INSERT INTO `status` VALUES ('1', '10', '新增支付记录');
INSERT INTO `status` VALUES ('2', '11', '新支付记录成功');
INSERT INTO `status` VALUES ('3', '12', '新支付验证失败');
INSERT INTO `status` VALUES ('4', '13', '支付号请求验证成功');
INSERT INTO `status` VALUES ('5', '14', '支付号请求验证失败');
INSERT INTO `status` VALUES ('6', '20', '提交支付类型');
INSERT INTO `status` VALUES ('7', '21', '支付类型验证成功');
INSERT INTO `status` VALUES ('8', '22', '支付类型验证失败');
INSERT INTO `status` VALUES ('9', '30', '发送支付请求到第三方支付平台');
INSERT INTO `status` VALUES ('10', '31', '得到成功的支付结果');
INSERT INTO `status` VALUES ('11', '32', '得到失败的支付结果');
INSERT INTO `status` VALUES ('12', '40', '发送结果回执到第三方平台');
INSERT INTO `status` VALUES ('13', '41', '得到结果回执响应');
INSERT INTO `status` VALUES ('14', '42', '未得到结果回执响应');
INSERT INTO `status` VALUES ('15', '51', '返回成功支付结果到商户站点');
INSERT INTO `status` VALUES ('16', '52', '返回失败支付结果到商户站点');
INSERT INTO `status` VALUES ('17', '201', '商户站点发送成功结果回执');
INSERT INTO `status` VALUES ('18', '202', '商户站点发送失败结果回执');
INSERT INTO `status` VALUES ('19', '203', '商户站点发送失败结果回执15');
INSERT INTO `status` VALUES ('20', '301', '异步回调验证成功');
INSERT INTO `status` VALUES ('21', '302', '异步回调验证失败');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `sys_config_id` int(1) NOT NULL AUTO_INCREMENT COMMENT '系统配置表主键ID ',
  `config_name` varchar(24) DEFAULT '' COMMENT '配置项名称',
  `config_key` varchar(24) DEFAULT '' COMMENT '配置项键',
  `config_value` varchar(2000) DEFAULT '' COMMENT '配置项取值',
  `type` tinyint(1) DEFAULT '1' COMMENT '配置项类型,1:一般系统配置,2:邮件内容配置,3:短信内容配置',
  `apply_user` varchar(72) DEFAULT 'system' COMMENT '配置更改人',
  `modify_ts` datetime DEFAULT '2000-01-01 00:00:00' COMMENT '配置更改时间',
  PRIMARY KEY (`sys_config_id`),
  UNIQUE KEY `config_name` (`config_name`),
  UNIQUE KEY `config_key` (`config_key`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES ('1', '文件上传地址', 'UPLOAD_URL', 'http://uc.weilian.cn/file-service/file-api.upload?domain=OPG&type=user', '1', 'oscar', '2016-09-27 16:28:19');
INSERT INTO `sys_config` VALUES ('2', '文件下载地址', 'DOWNLOAD_URL', 'http://uc.weilian.cn/file-service/file-service/file-api.download?domain=OPG&type=user', '1', 'system', '2000-01-01 00:00:00');
INSERT INTO `sys_config` VALUES ('3', '短信接口地址', 'MESSAGE_HOST', 'http://172.16.1.9:8280/sms_frontend/services/senderPhpWebService?wsdl', '1', 'system', '2000-01-01 00:00:00');
INSERT INTO `sys_config` VALUES ('4', '短信平台接入号', 'SERVICECODE', 'WL_COMMUNITY', '1', 'system', '2000-01-01 00:00:00');
INSERT INTO `sys_config` VALUES ('5', '短信验证码时效(秒)', 'SHORT_MESSAGE_TIME', '600', '1', 'system', '2000-01-01 00:00:00');
INSERT INTO `sys_config` VALUES ('6', '邮箱host', 'mail_host', 'mail.suneee.com', '1', 'system', '2000-01-01 00:00:00');
INSERT INTO `sys_config` VALUES ('7', '邮箱username', 'mail_username', 'opg888@suneee.com', '1', 'system', '2000-01-01 00:00:00');
INSERT INTO `sys_config` VALUES ('8', '邮箱password', 'mail_password', 'yizhifu0919', '1', 'system', '2000-01-01 00:00:00');
INSERT INTO `sys_config` VALUES ('9', '邮箱replyTo', 'mail_replyTo', 'opg888@suneee.com', '1', 'system', '2000-01-01 00:00:00');
INSERT INTO `sys_config` VALUES ('10', '邮箱from', 'mail_from', 'opg888@suneee.com', '1', 'system', '2000-01-01 00:00:00');
INSERT INTO `sys_config` VALUES ('11', '平台名称', 'SE_PAYMENT_NAME', 'SUNEEE Payment', '1', 'system', '2000-01-01 00:00:00');
INSERT INTO `sys_config` VALUES ('12', '站点域名', 'site_url', 'http://opg.suneee.com', '1', 'system', '2000-01-01 00:00:00');
INSERT INTO `sys_config` VALUES ('13', '版本号', 'SE_PAYMENT_VERSION', '1.0.1', '1', 'system', '2000-01-01 00:00:00');
INSERT INTO `sys_config` VALUES ('14', '应用编码前缀', 'APP_CODE_PREFIX', 'SUNEEE', '1', 'system', '2000-01-01 00:00:00');
INSERT INTO `sys_config` VALUES ('15', '退款时效(天)', 'REFUNDDAY', 's:2:\"15\";', '1', 'admin', '2016-08-25 17:47:39');
INSERT INTO `sys_config` VALUES ('16', '邮件过期时间(秒)', 'EMAIL_TIMEOUT', '7200', '1', 'system', '2000-01-01 00:00:00');
INSERT INTO `sys_config` VALUES ('17', 'se_code过期时间', 'SE_CODE_TIMEOUT', '1800', '1', 'w操作人w', '2016-08-19 15:39:06');
INSERT INTO `sys_config` VALUES ('18', '注册账户邮件', 'REGISTER', 'a:3:{s:7:\"subject\";s:12:\"注册账户\";s:6:\"active\";i:1;s:7:\"content\";s:318:\"<h2>欢迎加入翌支付</h2>\n<div><br /> 请点击以下按钮进行邮箱账号确认，24小时内确认均有效。<br /> <a href=\"{#register_url}\">确认账号</a><br /> 如果按钮无效，请复制以下链接在浏览器中打开完成账号确认。<br /> <a href=\"{#register_url}\">{#register_url}</a></div>\";}', '2', 'admin', '2016-10-15 14:03:58');
INSERT INTO `sys_config` VALUES ('19', '重置密码邮件', 'RESET', 'a:3:{s:7:\"subject\";s:12:\"重置密码\";s:6:\"active\";i:1;s:7:\"content\";s:437:\"<h2>重置密码</h2>\n<div><br /> 你可以在2小时内点击下方重置密码按钮进行密码的重置。<br /><br /> 如果这不是你本人发起的动作，请检查你的信息是否泄露。如有疑问，请联系象翌QQ客服。<br /><br /> <a href=\"{#reset_url}\">重置密码</a><br /> 如果按钮无效，请复制以下链接到浏览器打开进行密码重置！！<br /> <a href=\"{#reset_url}\">{#reset_url}</a></div>\";}', '2', 'adminli', '2016-10-17 10:02:40');
INSERT INTO `sys_config` VALUES ('20', '修改登入邮箱邮件', 'RESET_ACCOUNT', 'a:3:{s:7:\"subject\";s:18:\"修改登入邮箱\";s:6:\"active\";i:1;s:7:\"content\";s:423:\"<h2>您的登入账号发生更改！！！</h2>\n<div><br /> 原此邮箱所登入的翌支付平台账号已经失效。新的登入邮箱为:{#account}<br /><br /> 如果这不是你本人发起的动作，请检查你的信息是否泄露。如有疑问，请联系象翌QQ客服。<img src=\"http://172.19.6.133:8898/file-service/image/OPG/user/a20bcc3e000009ac.png\" alt=\"\" width=\"1184\" height=\"656\" /><br /><br /></div>\";}', '2', 'admin2', '2016-10-08 11:15:57');
INSERT INTO `sys_config` VALUES ('21', 'liveKey激活成功邮件', 'LIVEKEY_SUCCESS', 'a:3:{s:7:\"subject\";s:19:\"liveKey激活结果\";s:6:\"active\";i:1;s:7:\"content\";s:327:\"<h2>{#merchant_name}，您好！<h2><br>\n                        您提交的企业签约资料已审核通过，现已签约成功，可进行支付渠道开通。请知悉！<br><br>\n                        如有疑问，请联系象翌QQ客服。<br><br>\n                        <div style=\"float:right\">翌支付</div><br>\";}', '2', 'admin', '2016-09-30 16:29:49');
INSERT INTO `sys_config` VALUES ('22', 'liveKey激活失败邮件', 'LIVEKEY_FAIL', 'a:3:{s:7:\"subject\";s:19:\"liveKey激活结果\";s:6:\"active\";i:1;s:7:\"content\";s:393:\"<h2>{#merchant_name}，您好！</h2>\n<h2><br /> 遗憾, 您在翌支付提交的企业签约资料信息经审核未通过。<br /><br /> 原因 : {#reason}。<br /><br /> 如有疑问，请联系象翌QQ客服。<img src=\"http://172.19.6.133:8898/file-service/image/OPG/user/a20bcc3e000007ac.png\" alt=\"\" width=\"653\" height=\"395\" /><br /><br /></h2>\n<div style=\"float: right;\">翌支付</div>\";}', '2', 'admin2', '2016-10-08 11:01:46');
INSERT INTO `sys_config` VALUES ('23', '我的资料修改成功邮件', 'INFO_SUCCESS', 'a:3:{s:7:\"subject\";s:24:\"我的资料修改结果\";s:6:\"active\";i:1;s:7:\"content\";s:331:\"<h2>{#merchant_name}，您好！<h2><br>\n                        恭喜, 您在翌支付提交的\"我的资料\"信息已经审核通过。<br><br>\n                        现在企业签约资料信息已更新。如有疑问，请联系象翌QQ客服。<br><br>\n                        <div style=\"float:right\">翌支付</div><br>\";}', '2', 'system', '2016-08-19 16:21:01');
INSERT INTO `sys_config` VALUES ('24', '我的资料修改失败邮件', 'INFO_FAIL', 'a:3:{s:7:\"subject\";s:24:\"我的资料修改结果\";s:6:\"active\";i:1;s:7:\"content\";s:314:\"<h2>{#merchant_name}，您好！<h2><br>\n                        遗憾, 您在翌支付提交的企业签约资料信息经审核未通过。<br><br>\n                        原因 : {#reason}。如有疑问，请联系象翌QQ客服。<br><br>\n                        <div style=\"float:right\">翌支付</div><br>\";}', '2', 'adminli', '2016-10-13 10:50:46');
INSERT INTO `sys_config` VALUES ('25', '验证码短信', 'SMSCONTENT', 's:94:\"【翌支付】您的手机验证码为{#number}，请尽快验证！系统短信请勿回复!\";', '99', 'adminli', '2016-10-13 10:47:32');
INSERT INTO `sys_config` VALUES ('26', '支付渠道类型定义', 'PAYMENT_TYPE_NAME', 'a:4:{i:1;s:15:\"第三方支付\";i:2;s:6:\"银行\";i:3;s:6:\"银联\";i:4;s:4:\"test\";}', '1', 'system', '2016-08-22 11:12:18');
INSERT INTO `sys_config` VALUES ('27', '文件服务器地址', 'URL', 'http://uc.weilian.cn/file-service/', '1', 'xT_admin', '2016-09-27 16:41:27');
INSERT INTO `sys_config` VALUES ('30', '前端端口', 'PORT', '84', '1', 'system', '2000-01-01 00:00:00');
INSERT INTO `sys_config` VALUES ('31', '订单及退款单的状态码', 'PAYMENTSTATUS', 'a:3:{s:9:\"处理中\";a:8:{i:0;i:1;i:1;i:2;i:2;i:4;i:3;i:6;i:4;i:7;i:5;i:9;i:6;i:12;i:7;i:13;}s:6:\"失败\";a:6:{i:0;i:3;i:1;i:5;i:2;i:8;i:3;i:11;i:4;i:14;i:5;i:16;}s:6:\"成功\";a:4:{i:0;i:10;i:1;i:15;i:2;i:17;i:3;i:18;}}', '1', 'system', '2016-08-23 16:45:52');
INSERT INTO `sys_config` VALUES ('32', '批量转账模版', 'TRANSFER_BATCH', 'http://172.19.6.133:8898/file-service/image/OPG/user/6a4565df000037ac.xlsx', '4', 'system', '2000-01-01 00:00:00');
INSERT INTO `sys_config` VALUES ('33', '短信', 'SMS', 'a:2:{s:7:\"content\";s:94:\"【翌支付】您的手机验证码为{#number}，请尽快验证！系统短信请勿回复!\";s:6:\"active\";i:1;}', '3', 'adminli', '2016-10-17 17:28:10');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `sys_user_id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(72) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `passwd` varchar(32) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '状态（0 未激活, 1 已经激活, 2 停用）',
  `reg_ts` datetime DEFAULT NULL,
  `login_ts` datetime DEFAULT NULL,
  PRIMARY KEY (`sys_user_id`),
  UNIQUE KEY `sys_user_account` (`account`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', '14e1b600b1fd579f47433b88e8d85291', '1', null, '2016-10-18 09:59:32');
INSERT INTO `sys_user` VALUES ('2', 'xT_admin', '14e1b600b1fd579f47433b88e8d85291', '1', null, '2016-10-17 13:34:08');
INSERT INTO `sys_user` VALUES ('3', 'html_admin', '14e1b600b1fd579f47433b88e8d85291', '1', null, '2016-10-18 10:07:27');
INSERT INTO `sys_user` VALUES ('4', 'admin2', '14e1b600b1fd579f47433b88e8d85291', '1', null, '2016-10-09 15:43:21');
INSERT INTO `sys_user` VALUES ('5', 'oscar', '14e1b600b1fd579f47433b88e8d85291', '1', null, '2016-09-29 14:43:35');
INSERT INTO `sys_user` VALUES ('6', 'daoyin', '14e1b600b1fd579f47433b88e8d85291', '1', null, '2016-10-15 18:15:04');
INSERT INTO `sys_user` VALUES ('7', 'adminli', '14e1b600b1fd579f47433b88e8d85291', '1', null, '2016-10-18 09:53:59');
INSERT INTO `sys_user` VALUES ('8', 'admin001', '14e1b600b1fd579f47433b88e8d85291', '1', null, '2016-10-15 13:58:46');

-- ----------------------------
-- Table structure for transfer_request
-- ----------------------------
DROP TABLE IF EXISTS `transfer_request`;
CREATE TABLE `transfer_request` (
  `transfer_request_id` int(11) NOT NULL AUTO_INCREMENT,
  `transfer_no` varchar(32) DEFAULT NULL,
  `payment_type_id` int(11) DEFAULT NULL,
  `se_payment_code` varchar(32) DEFAULT NULL,
  `subject` varchar(32) NOT NULL,
  `description` varchar(256) DEFAULT NULL,
  `third_trade_no` varchar(32) DEFAULT NULL,
  `return_url` varchar(512) DEFAULT NULL,
  `notify_url` varchar(512) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `merchant_id` int(11) DEFAULT NULL,
  `pay_account` varchar(200) DEFAULT NULL COMMENT '付款号(用户配置的account)',
  `rec_account_no` varchar(34) DEFAULT NULL,
  `rec_account_name` varchar(34) DEFAULT NULL,
  `currency_code` varchar(3) DEFAULT NULL,
  `amount` float DEFAULT NULL,
  `created_ts` datetime DEFAULT NULL,
  `modified_ts` datetime DEFAULT NULL,
  `scenary_id` int(11) DEFAULT NULL COMMENT '转账场景id',
  `auth_app_id` int(11) DEFAULT NULL COMMENT 'merchant_app_id',
  `batch_no` bigint(1) DEFAULT NULL COMMENT '批量付款批次号',
  PRIMARY KEY (`transfer_request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for transfer_request_batch
-- ----------------------------
DROP TABLE IF EXISTS `transfer_request_batch`;
CREATE TABLE `transfer_request_batch` (
  `transfer_request_batch_id` bigint(1) NOT NULL AUTO_INCREMENT COMMENT '批量付款批次号',
  `payment_type_id` int(1) DEFAULT NULL,
  `scenary_id` int(1) DEFAULT NULL COMMENT '转账场景id',
  `se_payment_code` varchar(32) DEFAULT NULL,
  `merchant_id` int(1) DEFAULT NULL,
  `auth_app_id` int(1) DEFAULT NULL COMMENT 'merchant_app_id',
  `subject` varchar(32) NOT NULL,
  `description` varchar(256) DEFAULT NULL,
  `return_url` varchar(512) DEFAULT NULL,
  `notify_url` varchar(512) DEFAULT NULL,
  `status_id` tinyint(1) DEFAULT '0' COMMENT '批量付款状态（1 已支付, 0 未支付）',
  `num` int(1) DEFAULT NULL COMMENT '批量付款总笔数（最少1笔，最多1000笔）',
  `amount` float DEFAULT NULL COMMENT '批量付款总金额',
  `created_ts` datetime DEFAULT NULL,
  `modified_ts` datetime DEFAULT NULL,
  PRIMARY KEY (`transfer_request_batch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100000017000 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for transfer_request_flow
-- ----------------------------
DROP TABLE IF EXISTS `transfer_request_flow`;
CREATE TABLE `transfer_request_flow` (
  `transfer_request_flow_id` int(11) NOT NULL AUTO_INCREMENT,
  `transfer_request_id` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `result` text,
  `created_ts` datetime DEFAULT NULL,
  PRIMARY KEY (`transfer_request_flow_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
