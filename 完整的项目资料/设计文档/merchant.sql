/*
Navicat MySQL Data Transfer

Source Server         : 172.16.38.19_3306 翌支付物理机mysql_1
Source Server Version : 50554
Source Host           : 172.16.38.19:3306
Source Database       : suneee_payment

Target Server Type    : MYSQL
Target Server Version : 50554
File Encoding         : 65001

Date: 2017-03-02 14:41:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for merchant
-- ----------------------------
DROP TABLE IF EXISTS `merchant`;
CREATE TABLE `merchant` (
  `merchant_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '平台商家ID ',
  `merchant_name` varchar(64) DEFAULT NULL COMMENT '商家名称',
  `se_payment_code` varchar(32) DEFAULT NULL COMMENT '商户的支付网关号',
  `description` varchar(256) DEFAULT NULL COMMENT '商家描述',
  `memo` varchar(300) DEFAULT NULL COMMENT '备注',
  `active` tinyint(1) DEFAULT '0' COMMENT '是否激活 : 1 激活; 0 未激活;',
  `account` varchar(72) DEFAULT NULL COMMENT '登录账户(email) (限制：唯一)',
  `passwd` char(33) DEFAULT NULL COMMENT '密码/Md5加密存储',
  `reg_ts` datetime DEFAULT NULL COMMENT '注册时间',
  `active_ts` datetime DEFAULT NULL COMMENT '激活时间',
  `stop_ts` datetime DEFAULT NULL COMMENT '停用时间',
  `login_ts` datetime DEFAULT NULL COMMENT '最近登入时间',
  `area_id` varchar(6) DEFAULT NULL COMMENT '地区, ref: area',
  `company_type` int(1) DEFAULT '0' COMMENT '企业类型(1象翌内部, 2象翌外部,3翌商云)',
  `reg_address` varchar(512) DEFAULT NULL COMMENT '注册地址',
  `work_address` varchar(512) DEFAULT NULL COMMENT '办公地址',
  `contact_name` varchar(64) DEFAULT NULL COMMENT '联系人名称',
  `contact_mail` varchar(72) DEFAULT NULL COMMENT '联系人邮件',
  `contact_mobile` varchar(64) DEFAULT NULL COMMENT '联系人移动电话',
  `contact_telphone` varchar(64) DEFAULT NULL COMMENT '联系人固定电话',
  `lisence_image` varchar(72) DEFAULT NULL COMMENT '营业执照图片文件路径',
  `org_image` varchar(72) DEFAULT NULL COMMENT '机构代码图片文件路径',
  `apply_ts` datetime DEFAULT NULL COMMENT '申请时间',
  `audit_status` tinyint(1) DEFAULT '0' COMMENT '是否签约 (0 初始， 1 资料已提交，待审核，2 审核通过，已签约， 3 审核不通过 )',
  `audit_ts` datetime DEFAULT NULL COMMENT '签约日期',
  `audit_user` varchar(72) DEFAULT NULL COMMENT '审核人账户',
  `audit_reason` varchar(72) DEFAULT NULL COMMENT '签约审核通过与否的原因',
  PRIMARY KEY (`merchant_id`),
  UNIQUE KEY `merchant_uk` (`se_payment_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12002 DEFAULT CHARSET=utf8;
