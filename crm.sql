/*
 Navicat Premium Data Transfer

 Source Server         : MySQL57
 Source Server Type    : MySQL
 Source Server Version : 50722
 Source Host           : localhost:3306
 Source Schema         : crm

 Target Server Type    : MySQL
 Target Server Version : 50722
 File Encoding         : 65001

 Date: 25/05/2022 18:43:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_activity
-- ----------------------------
DROP TABLE IF EXISTS `tbl_activity`;
CREATE TABLE `tbl_activity`  (
  `id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `owner` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `start_date` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `end_date` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cost` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `edit_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `edit_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_activity
-- ----------------------------
INSERT INTO `tbl_activity` VALUES ('0241cad6957945379e1fa1e9d3bee61a', '40f6cdea0bd34aceb77492a1656d9fb3', '测试数据03', '2022-05-03', '2022-06-03', '100002', '测试数据', '2022-04-29 20:07:02', '40f6cdea0bd34aced77492a1656d9ab3', NULL, NULL);
INSERT INTO `tbl_activity` VALUES ('060fc77e48ac45318385aeeeb2fb2492', '06f5fc056eac41558a964f96daa7f27c', '测试数据07', '2022-05-07', '2022-06-07', '100006', '测试数据', '2022-04-29 20:07:02', '40f6cdea0bd34aced77492a1656d9ab3', NULL, NULL);
INSERT INTO `tbl_activity` VALUES ('28de65fa95aa4df7b22c71bd9d4223ca', '40f6cdea0bd34aced77492a1656d9ab3', '测试数据11', '2022-05-11', '2022-06-11', '100010', '测试数据', '2022-04-29 20:07:02', '40f6cdea0bd34aced77492a1656d9ab3', NULL, NULL);
INSERT INTO `tbl_activity` VALUES ('32be7b40841548239d450f6400c9bdce', '40f6cdea0bd34aceb77492a1656d9fb3', 'test06', '2022-04-25', '', '2000', 'dagd', '2022-04-25 15:05:54', '40f6cdea0bd34aced77492a1656d9ab3', NULL, NULL);
INSERT INTO `tbl_activity` VALUES ('355939dec7f84554a8cfa429aa02fbcd', '40f6cdea0bd34aced77492a1656d9ab3', '测试02', '2022-04-04', '2022-04-08', '200', '', '2022-04-24 17:26:09', '40f6cdea0bd34aced77492a1656d9ab3', '2022-04-27 23:46:06', '40f6cdea0bd34aced77492a1656d9ab3');
INSERT INTO `tbl_activity` VALUES ('41691553e88945a68c6546df296ef8c3', '40f6cdea0bd34aceb77492a1656d9fb3', '测试数据01', '2022-05-01', '2022-06-01', '100000', '测试数据', '2022-04-29 20:07:02', '40f6cdea0bd34aced77492a1656d9ab3', NULL, NULL);
INSERT INTO `tbl_activity` VALUES ('52ec5d7f818c44218cf1b555202746ad', '40f6cdea0bd34aced77492a1656d9ab3', 'test01', '2022-04-25', '', '200', '1', '2022-04-25 15:05:12', '40f6cdea0bd34aced77492a1656d9ab3', NULL, NULL);
INSERT INTO `tbl_activity` VALUES ('5ef7f0afc2674c738cb792849c0e840b', '06f5fc056eac41558a964f96daa7f27c', '测试数据06', '2022-05-06', '2022-06-06', '100005', '测试数据', '2022-04-29 20:07:02', '40f6cdea0bd34aced77492a1656d9ab3', NULL, NULL);
INSERT INTO `tbl_activity` VALUES ('6105e2b5143847398000eedc327ce9c0', '40f6cdea0bd34aced77492a1656d9ab3', '测试数据13', '2022-05-13', '2022-06-13', '100012', '测试数据', '2022-04-29 20:07:02', '40f6cdea0bd34aced77492a1656d9ab3', NULL, NULL);
INSERT INTO `tbl_activity` VALUES ('6ef2656072d94661a4d4ce4763fcffc9', '40f6cdea0bd34aceb77492a1656d9fb3', 'test04', '2022-04-25', '2022-04-27', '2000', '5', '2022-04-25 15:05:39', '40f6cdea0bd34aced77492a1656d9ab3', '2022-04-27 10:39:02', '40f6cdea0bd34aced77492a1656d9ab3');
INSERT INTO `tbl_activity` VALUES ('7426f1b5236b4523afc1a52110afad6f', '40f6cdea0bd34aced77492a1656d9ab3', '测试03', '2022-04-04', '2022-04-29', '2000', '测试6', '2022-04-24 17:26:49', '40f6cdea0bd34aced77492a1656d9ab3', NULL, NULL);
INSERT INTO `tbl_activity` VALUES ('7bcddb435c224ed38b08b1ed51d8a99d', '06f5fc056eac41558a964f96daa7f27c', 'test02', '', '', '200', '2', '2022-04-25 15:05:26', '40f6cdea0bd34aced77492a1656d9ab3', NULL, NULL);
INSERT INTO `tbl_activity` VALUES ('95c0d4c9bc6d4b3898edfed4065f8a4d', '40f6cdea0bd34aced77492a1656d9ab3', '测试数据12', '2022-05-12', '2022-06-12', '100011', '测试数据', '2022-04-29 20:07:02', '40f6cdea0bd34aced77492a1656d9ab3', NULL, NULL);
INSERT INTO `tbl_activity` VALUES ('9ea86c87aad24b1497ea008a3b0ce101', '06f5fc056eac41558a964f96daa7f27c', '测试数据09', '2022-05-09', '2022-06-09', '1000088', '测试数据', '2022-04-29 20:07:02', '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-03 14:49:46', '40f6cdea0bd34aced77492a1656d9ab3');
INSERT INTO `tbl_activity` VALUES ('a73d7269b86c4919b51ba68bb7f5ebf2', '40f6cdea0bd34aceb77492a1656d9fb3', '测试数据05', '2022-05-05', '2022-06-05', '100004', '测试数据', '2022-04-29 20:07:02', '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-03 14:49:06', '40f6cdea0bd34aced77492a1656d9ab3');
INSERT INTO `tbl_activity` VALUES ('c7a7282c02ae4a1aa2d874e3c12968b2', '40f6cdea0bd34aced77492a1656d9ab3', '测试数据14', '2022-05-14', '2022-06-14', '100013', '测试数据', '2022-04-29 20:07:02', '40f6cdea0bd34aced77492a1656d9ab3', NULL, NULL);
INSERT INTO `tbl_activity` VALUES ('c8f32e6693264e739aeb12e2fd9e72ce', '40f6cdea0bd34aced77492a1656d9ab3', '测试', '2022-04-28', '2022-04-30', '2000', 'qwerqwer', '2022-04-25 15:06:34', '40f6cdea0bd34aced77492a1656d9ab3', '2022-04-27 10:35:52', '40f6cdea0bd34aced77492a1656d9ab3');
INSERT INTO `tbl_activity` VALUES ('d129ae5781aa44f68d0b99c0b7066aa7', '06f5fc056eac41558a964f96daa7f27c', '测试数据08', '2022-05-08', '2022-06-08', '100007', '测试数据', '2022-04-29 20:07:02', '40f6cdea0bd34aced77492a1656d9ab3', NULL, NULL);
INSERT INTO `tbl_activity` VALUES ('d500bcc5932d44cd858cf24d75740638', '40f6cdea0bd34aceb77492a1656d9fb3', '测试数据04', '2022-05-04', '2022-06-04', '100003', '测试数据', '2022-04-29 20:07:02', '40f6cdea0bd34aced77492a1656d9ab3', NULL, NULL);
INSERT INTO `tbl_activity` VALUES ('dc9cc4ccc9984dcc821c75beaabf2f14', '40f6cdea0bd34aceb77492a1656d9fb3', '测试数据02', '2022-05-02', '2022-06-02', '100001', '测试数据', '2022-04-29 20:07:02', '40f6cdea0bd34aced77492a1656d9ab3', NULL, NULL);
INSERT INTO `tbl_activity` VALUES ('e1b79b3705a44508a9af8b475e12719c', '06f5fc056eac41558a964f96daa7f27c', '测试数据10', '2022-05-10', '2022-06-10', '100009', '测试数据', '2022-04-29 20:07:02', '40f6cdea0bd34aced77492a1656d9ab3', NULL, NULL);
INSERT INTO `tbl_activity` VALUES ('f308243031914d3ab98173bd8dab2c13', '40f6cdea0bd34aced77492a1656d9ab3', '测试01', '2022-04-27', '2022-05-07', '200', '', '2022-04-24 17:25:46', '40f6cdea0bd34aced77492a1656d9ab3', '2022-04-27 10:36:21', '40f6cdea0bd34aced77492a1656d9ab3');

-- ----------------------------
-- Table structure for tbl_activity_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_activity_remark`;
CREATE TABLE `tbl_activity_remark`  (
  `id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `note_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `edit_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `edit_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `edit_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '0??ʾδ?޸ģ?1??ʾ???޸',
  `activity_id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_activity_remark
-- ----------------------------
INSERT INTO `tbl_activity_remark` VALUES ('088646f603774f93a3f8d3693694a35b', '测试', '2022-05-04 20:37:13', '40f6cdea0bd34aced77492a1656d9ab3', NULL, NULL, '0', 'dc9cc4ccc9984dcc821c75beaabf2f14');
INSERT INTO `tbl_activity_remark` VALUES ('138e07391c1f4e0e8cec28d3d5940172', 'test', '2022-05-03 14:48:16', '40f6cdea0bd34aced77492a1656d9ab3', NULL, NULL, '0', 'd129ae5781aa44f68d0b99c0b7066aa7');
INSERT INTO `tbl_activity_remark` VALUES ('13a50b9361ee4bf5854b274af73be01e', 'khkj', '2022-05-09 17:41:16', '40f6cdea0bd34aced77492a1656d9ab3', NULL, NULL, '0', 'c7a7282c02ae4a1aa2d874e3c12968b2');
INSERT INTO `tbl_activity_remark` VALUES ('29403e09dde749a89fc9cb2f69b433cc', '测试保存按钮2', '2022-05-03 11:52:22', '40f6cdea0bd34aced77492a1656d9ab3', NULL, NULL, '0', '95c0d4c9bc6d4b3898edfed4065f8a4d');
INSERT INTO `tbl_activity_remark` VALUES ('53928672df984b1b986cbf27e41d8407', '测试保存按钮03q1234', '2022-05-04 11:35:20', '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-05 14:10:56', '40f6cdea0bd34aced77492a1656d9ab3', '1', '95c0d4c9bc6d4b3898edfed4065f8a4d');
INSERT INTO `tbl_activity_remark` VALUES ('69ce5b6656944c41be272866d40fd72e', '测试添加', '2022-05-03 11:46:02', '40f6cdea0bd34aced77492a1656d9ab3', NULL, NULL, '0', '28de65fa95aa4df7b22c71bd9d4223ca');
INSERT INTO `tbl_activity_remark` VALUES ('84ad709647bb41b281f8a7ba233ed637', 'cdcw', '2022-05-04 11:43:26', '40f6cdea0bd34aced77492a1656d9ab3', NULL, NULL, '0', 'dc9cc4ccc9984dcc821c75beaabf2f14');
INSERT INTO `tbl_activity_remark` VALUES ('8e35569158ad4450b5ca7ef4e2922d27', '测试隐藏', '2022-05-04 11:41:24', '40f6cdea0bd34aced77492a1656d9ab3', NULL, NULL, '0', 'dc9cc4ccc9984dcc821c75beaabf2f14');
INSERT INTO `tbl_activity_remark` VALUES ('ab05875af28e41349f63f422c0224364', '测试保存', '2022-05-04 11:29:36', '40f6cdea0bd34aced77492a1656d9ab3', NULL, NULL, '0', 'dc9cc4ccc9984dcc821c75beaabf2f14');
INSERT INTO `tbl_activity_remark` VALUES ('c78893494e23429785948bd3a2fb3166', '测试添加', '2022-05-04 11:36:27', '40f6cdea0bd34aced77492a1656d9ab3', NULL, NULL, '0', '95c0d4c9bc6d4b3898edfed4065f8a4d');
INSERT INTO `tbl_activity_remark` VALUES ('db9b32bbb57b4733a54db4e99cc3cf95', '测试修改数据01', '2022-05-05 14:12:25', '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-05 14:12:31', '40f6cdea0bd34aced77492a1656d9ab3', '1', '95c0d4c9bc6d4b3898edfed4065f8a4d');
INSERT INTO `tbl_activity_remark` VALUES ('ee98c031ef81419391f869348e7035cc', '测试', '2022-05-03 11:49:40', '40f6cdea0bd34aced77492a1656d9ab3', NULL, NULL, '0', '28de65fa95aa4df7b22c71bd9d4223ca');

-- ----------------------------
-- Table structure for tbl_clue
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue`;
CREATE TABLE `tbl_clue`  (
  `id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `fullname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `appellation` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `owner` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `company` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `job` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `website` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `mphone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `state` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `source` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `edit_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `edit_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `contact_summary` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `next_contact_time` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_clue
-- ----------------------------
INSERT INTO `tbl_clue` VALUES ('50ae87cb27624ab889a31f149f64b889', '黄文晶', 'e5f383d2622b4fc0959f4fe131dafc80', '06f5fc056eac41558a964f96daa7f27c', '吉姆餐厅', '前端工程师', '897629678@qq.com', '086-45662222', 'www.dreem.com', '13133838726', '310e6a49bd8a4962b3f95a1d92eb76f4', 'db867ea866bc44678ac20c8a4a8bfefb', '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-06 11:25:18', NULL, NULL, 'test', 'test', '2022-05-27', '安远县版石镇');
INSERT INTO `tbl_clue` VALUES ('5704492740414d678ec05430ae1ce503', '山姆', '59795c49896947e1ab61b7312bd0597c', '06f5fc056eac41558a964f96daa7f27c', '百度', '开发工程师', 'shanmu@163.com', '086-63456345', 'www.baidu.com', '15045678912', '310e6a49bd8a4962b3f95a1d92eb76f4', '3a39605d67da48f2a3ef52e19d243953', '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-13 13:05:21', NULL, NULL, 'test', 'test', '2022-05-23', '赣新大道东段105号');
INSERT INTO `tbl_clue` VALUES ('7fc5a26bd2a1407fba5162b76d51404a', '彭骏', '59795c49896947e1ab61b7312bd0597c', '40f6cdea0bd34aceb77492a1656d9fb3', '吉姆餐厅', '开发工程师', '1808457651@qq.com', '086-45662222', 'www.dreem.com', '15083903668', '1e0bd307e6ee425599327447f8387285', 'ff802a03ccea4ded8731427055681d48', '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-06 11:25:18', '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-07 10:11:20', 'test', 'test', '2022-05-17', '皇后东大街3号');

-- ----------------------------
-- Table structure for tbl_clue_activity_relation
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue_activity_relation`;
CREATE TABLE `tbl_clue_activity_relation`  (
  `id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `clue_id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `activity_id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_clue_activity_relation
-- ----------------------------
INSERT INTO `tbl_clue_activity_relation` VALUES ('6674ebfd8eee44208ba5f73961bb02e9', '50ae87cb27624ab889a31f149f64b889', '060fc77e48ac45318385aeeeb2fb2492');
INSERT INTO `tbl_clue_activity_relation` VALUES ('6c866d137b6042e08d7917cc6ea45d15', '50ae87cb27624ab889a31f149f64b889', '0241cad6957945379e1fa1e9d3bee61a');
INSERT INTO `tbl_clue_activity_relation` VALUES ('8cfabba42d274859a358183a32ddd78e', '7fc5a26bd2a1407fba5162b76d51404a', '060fc77e48ac45318385aeeeb2fb2492');
INSERT INTO `tbl_clue_activity_relation` VALUES ('a2bf677083a84da29b009d3cd67f8fa9', '50ae87cb27624ab889a31f149f64b889', '28de65fa95aa4df7b22c71bd9d4223ca');
INSERT INTO `tbl_clue_activity_relation` VALUES ('a94a2328cf384ae2aa1fe15aaeae17e1', '7fc5a26bd2a1407fba5162b76d51404a', '32be7b40841548239d450f6400c9bdce');
INSERT INTO `tbl_clue_activity_relation` VALUES ('b5440cf42bd94345bfd662c60fde934e', '7fc5a26bd2a1407fba5162b76d51404a', '28de65fa95aa4df7b22c71bd9d4223ca');
INSERT INTO `tbl_clue_activity_relation` VALUES ('cf38575c2e4c4ce185f8bafdc63113d0', '7fc5a26bd2a1407fba5162b76d51404a', '41691553e88945a68c6546df296ef8c3');
INSERT INTO `tbl_clue_activity_relation` VALUES ('f0472c0d7a754b5b9ec416ccd954f961', '7fc5a26bd2a1407fba5162b76d51404a', '5ef7f0afc2674c738cb792849c0e840b');
INSERT INTO `tbl_clue_activity_relation` VALUES ('f5940bdc385d43a09e69ca509681acb9', '7fc5a26bd2a1407fba5162b76d51404a', '0241cad6957945379e1fa1e9d3bee61a');

-- ----------------------------
-- Table structure for tbl_clue_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue_remark`;
CREATE TABLE `tbl_clue_remark`  (
  `id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `note_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `edit_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `edit_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `edit_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `clue_id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_clue_remark
-- ----------------------------
INSERT INTO `tbl_clue_remark` VALUES ('3f59a62eecb94ae4a4ee9271cf1cc614', 'test', '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-09 12:46:10', NULL, NULL, '0', '7fc5a26bd2a1407fba5162b76d51404a');
INSERT INTO `tbl_clue_remark` VALUES ('c5a1fa34075f449e85150e4eb3a3ed33', 'test01', '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-12 19:54:38', '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-12 19:54:43', '1', '50ae87cb27624ab889a31f149f64b889');
INSERT INTO `tbl_clue_remark` VALUES ('f37f73f77a9949dfa0a1de7a84c8991f', 'testeafd0', '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-12 19:13:52', '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-12 19:37:02', '1', '7fc5a26bd2a1407fba5162b76d51404a');

-- ----------------------------
-- Table structure for tbl_contacts
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts`;
CREATE TABLE `tbl_contacts`  (
  `id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `owner` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `source` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `customer_id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `fullname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `appellation` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `birth` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `mphone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `job` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `edit_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `edit_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `contact_summary` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `next_contact_time` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_contacts
-- ----------------------------
INSERT INTO `tbl_contacts` VALUES ('2257a01ece2947f2a4ed38247bb5581f', '40f6cdea0bd34aced77492a1656d9ab3', '4d03a42898684135809d380597ed3268', '2215f66fb3f14aa0aaea011d7ca8229f', '珍妮', '31539e7ed8c848fc913e1c2c93d76fd1', '2000-10-01', 'zhenni@163.com', '15045673812', '项目经理', '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-15 11:01:25', NULL, NULL, 'test', 'test', '2022-05-18', '皇后东大街37号');
INSERT INTO `tbl_contacts` VALUES ('2e78a88b474c46cf89a20273ef6e65ab', '40f6cdea0bd34aceb77492a1656d9fb3', 'fd677cc3b5d047d994e16f6ece4d3d45', '3f86eff726ae4e21b909fecda42e9fba', 'jim', NULL, NULL, NULL, NULL, NULL, '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-19 16:46:55', NULL, NULL, '创建交易时新建的联系人', '测试创建交易02', '2022-05-20', NULL);
INSERT INTO `tbl_contacts` VALUES ('66ef4182854f4b829fd18d59c2cf54fa', '06f5fc056eac41558a964f96daa7f27c', 'fd677cc3b5d047d994e16f6ece4d3d45', '3f86eff726ae4e21b909fecda42e9fba', 'jack', NULL, NULL, NULL, NULL, NULL, '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-19 16:21:19', NULL, NULL, '创建交易时新建的联系人', '测试创建交易', '2022-05-21', NULL);
INSERT INTO `tbl_contacts` VALUES ('9c6e001480a9493fb8de1cceb62553b0', '06f5fc056eac41558a964f96daa7f27c', '72f13af8f5d34134b5b3f42c5d477510', '3f86eff726ae4e21b909fecda42e9fba', 'sam', NULL, NULL, NULL, NULL, NULL, '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-19 16:52:59', NULL, NULL, '创建交易时新建的联系人', '测试创建交易03', '2022-05-21', NULL);
INSERT INTO `tbl_contacts` VALUES ('e05bcfb869a14e3090becbc9d7ba250b', '40f6cdea0bd34aced77492a1656d9ab3', '72f13af8f5d34134b5b3f42c5d477510', '2015876ea1e34e4091e1789eadc428ad', '黄小晶', NULL, NULL, NULL, NULL, NULL, '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-20 17:20:39', NULL, NULL, '创建交易时新建的联系人', '华为交易01', '2022-05-25', NULL);
INSERT INTO `tbl_contacts` VALUES ('f08bb0fa56a34104a845acfec535b1a3', '06f5fc056eac41558a964f96daa7f27c', '72f13af8f5d34134b5b3f42c5d477510', '3f86eff726ae4e21b909fecda42e9fba', '巴斯', NULL, NULL, NULL, NULL, NULL, '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-19 17:46:43', NULL, NULL, '创建交易时新建的联系人', '09', '2022-05-18', NULL);

-- ----------------------------
-- Table structure for tbl_contacts_activity_relation
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts_activity_relation`;
CREATE TABLE `tbl_contacts_activity_relation`  (
  `id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `contacts_id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `activity_id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_contacts_activity_relation
-- ----------------------------
INSERT INTO `tbl_contacts_activity_relation` VALUES ('815a178fe6694232bbddfc9a726241ce', '2257a01ece2947f2a4ed38247bb5581f', '28de65fa95aa4df7b22c71bd9d4223ca');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('e4c7ac44e1f9493f9302529f77bb638a', '2257a01ece2947f2a4ed38247bb5581f', '060fc77e48ac45318385aeeeb2fb2492');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('fd076fd83095417db0cbcc9cefc4530a', '2257a01ece2947f2a4ed38247bb5581f', 'e1b79b3705a44508a9af8b475e12719c');

-- ----------------------------
-- Table structure for tbl_contacts_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts_remark`;
CREATE TABLE `tbl_contacts_remark`  (
  `id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `note_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `edit_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `edit_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `edit_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `contacts_id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_contacts_remark
-- ----------------------------
INSERT INTO `tbl_contacts_remark` VALUES ('4cdabc17eb8841cf8035d4ba6327ae58', '测试转换备注二', '吉姆', '2022-05-15 10:42:22', NULL, NULL, '0', '2215f66fb3f14aa0aaea011d7ca8229f');
INSERT INTO `tbl_contacts_remark` VALUES ('bd005736cb1b4b49b74c543eb90cb542', '测试转换备注', '吉姆', '2022-05-15 10:42:13', NULL, NULL, '0', '2215f66fb3f14aa0aaea011d7ca8229f');

-- ----------------------------
-- Table structure for tbl_customer
-- ----------------------------
DROP TABLE IF EXISTS `tbl_customer`;
CREATE TABLE `tbl_customer`  (
  `id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `owner` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `website` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `edit_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `edit_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `contact_summary` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `next_contact_time` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_customer
-- ----------------------------
INSERT INTO `tbl_customer` VALUES ('2015876ea1e34e4091e1789eadc428ad', '06f5fc056eac41558a964f96daa7f27c', '华为技术有限公司', 'http://www.huawei.com', '010-12344321', '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-19 17:36:43', '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-25 11:01:17', 'test07', '2022-05-28', '创建交易时新建的客户', '');
INSERT INTO `tbl_customer` VALUES ('2215f66fb3f14aa0aaea011d7ca8229f', '40f6cdea0bd34aced77492a1656d9ab3', '吉姆餐厅', 'www.dreem.com', '086-63456675', '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-15 11:01:25', NULL, NULL, 'test', '2022-05-18', 'test', '皇后东大街37号');
INSERT INTO `tbl_customer` VALUES ('3f86eff726ae4e21b909fecda42e9fba', '06f5fc056eac41558a964f96daa7f27c', '百度科技有限公司', 'http://www.baidu.com', '010-89764321', '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-19 16:21:19', '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-25 11:17:26', '测试创建交易', '2022-05-24', '创建交易时新建的客户', '');

-- ----------------------------
-- Table structure for tbl_customer_contacts_relation
-- ----------------------------
DROP TABLE IF EXISTS `tbl_customer_contacts_relation`;
CREATE TABLE `tbl_customer_contacts_relation`  (
  `id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `customer_id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `contacts_id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_customer_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_customer_remark`;
CREATE TABLE `tbl_customer_remark`  (
  `id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `note_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `edit_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `edit_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `edit_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `customer_id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_customer_remark
-- ----------------------------
INSERT INTO `tbl_customer_remark` VALUES ('9c1adffecdf740e2b1655ce6b844009c', '测试转换备注二', '吉姆', '2022-05-15 10:42:22', NULL, NULL, '0', '2215f66fb3f14aa0aaea011d7ca8229f');
INSERT INTO `tbl_customer_remark` VALUES ('bee9a6c9c56a4569bb0dab5d02ade6c8', '测试转换备注', '吉姆', '2022-05-15 10:42:13', NULL, NULL, '0', '2215f66fb3f14aa0aaea011d7ca8229f');

-- ----------------------------
-- Table structure for tbl_dic_type
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dic_type`;
CREATE TABLE `tbl_dic_type`  (
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '????????????????Ϊ?գ????ܺ??????ġ?',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_dic_type
-- ----------------------------
INSERT INTO `tbl_dic_type` VALUES ('appellation', '称呼', '');
INSERT INTO `tbl_dic_type` VALUES ('clueState', '线索状态', '');
INSERT INTO `tbl_dic_type` VALUES ('returnPriority', '回访优先级', '');
INSERT INTO `tbl_dic_type` VALUES ('returnState', '回访状态', '');
INSERT INTO `tbl_dic_type` VALUES ('source', '线索来源', '');
INSERT INTO `tbl_dic_type` VALUES ('stage', '阶段', '');
INSERT INTO `tbl_dic_type` VALUES ('transactionType', '交易类型', '');

-- ----------------------------
-- Table structure for tbl_dic_value
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dic_value`;
CREATE TABLE `tbl_dic_value`  (
  `id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '??????????UUID',
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '????Ϊ?գ?????Ҫ??ͬһ???ֵ????????ֵ?ֵ?????ظ???????Ψһ?ԡ?',
  `text` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '????Ϊ?',
  `order_no` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '????Ϊ?գ?????Ϊ?յ?ʱ????Ҫ??????????????',
  `type_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '????',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_dic_value
-- ----------------------------
INSERT INTO `tbl_dic_value` VALUES ('06e3cbdf10a44eca8511dddfc6896c55', '虚假线索', '虚假线索', '4', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('0fe33840c6d84bf78df55d49b169a894', '销售邮件', '销售邮件', '8', 'source');
INSERT INTO `tbl_dic_value` VALUES ('12302fd42bd349c1bb768b19600e6b20', '交易会', '交易会', '11', 'source');
INSERT INTO `tbl_dic_value` VALUES ('1615f0bb3e604552a86cde9a2ad45bea', '最高', '最高', '2', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('176039d2a90e4b1a81c5ab8707268636', '教授', '教授', '5', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('1e0bd307e6ee425599327447f8387285', '将来联系', '将来联系', '2', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('2173663b40b949ce928db92607b5fe57', '丢失线索', '丢失线索', '5', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('2876690b7e744333b7f1867102f91153', '未启动', '未启动', '1', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('29805c804dd94974b568cfc9017b2e4c', '成交', '成交', '7', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('310e6a49bd8a4962b3f95a1d92eb76f4', '试图联系', '试图联系', '1', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('31539e7ed8c848fc913e1c2c93d76fd1', '博士', '博士', '4', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('37ef211719134b009e10b7108194cf46', '资质审查', '资质审查', '1', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('391807b5324d4f16bd58c882750ee632', '丢失的线索', '丢失的线索', '8', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('3a39605d67da48f2a3ef52e19d243953', '聊天', '聊天', '14', 'source');
INSERT INTO `tbl_dic_value` VALUES ('474ab93e2e114816abf3ffc596b19131', '低', '低', '3', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('48512bfed26145d4a38d3616e2d2cf79', '广告', '广告', '1', 'source');
INSERT INTO `tbl_dic_value` VALUES ('4d03a42898684135809d380597ed3268', '合作伙伴研讨会', '合作伙伴研讨会', '9', 'source');
INSERT INTO `tbl_dic_value` VALUES ('59795c49896947e1ab61b7312bd0597c', '先生', '先生', '1', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('5c6e9e10ca414bd499c07b886f86202a', '高', '高', '1', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('67165c27076e4c8599f42de57850e39c', '夫人', '夫人', '2', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('68a1b1e814d5497a999b8f1298ace62b', '因竞争丢失关闭', '因竞争丢失关闭', '9', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('6b86f215e69f4dbd8a2daa22efccf0cf', 'web调研', 'web调研', '13', 'source');
INSERT INTO `tbl_dic_value` VALUES ('72f13af8f5d34134b5b3f42c5d477510', '合作伙伴', '合作伙伴', '6', 'source');
INSERT INTO `tbl_dic_value` VALUES ('7c07db3146794c60bf975749952176df', '未联系', '未联系', '6', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('86c56aca9eef49058145ec20d5466c17', '内部研讨会', '内部研讨会', '10', 'source');
INSERT INTO `tbl_dic_value` VALUES ('9095bda1f9c34f098d5b92fb870eba17', '进行中', '进行中', '3', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('954b410341e7433faa468d3c4f7cf0d2', '已有业务', '已有业务', '1', 'transactionType');
INSERT INTO `tbl_dic_value` VALUES ('966170ead6fa481284b7d21f90364984', '已联系', '已联系', '3', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('96b03f65dec748caa3f0b6284b19ef2f', '推迟', '推迟', '2', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('97d1128f70294f0aac49e996ced28c8a', '新业务', '新业务', '2', 'transactionType');
INSERT INTO `tbl_dic_value` VALUES ('9ca96290352c40688de6596596565c12', '完成', '完成', '4', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('9e6d6e15232549af853e22e703f3e015', '需要条件', '需要条件', '7', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('9ff57750fac04f15b10ce1bbb5bb8bab', '需求分析', '需求分析', '2', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('a70dc4b4523040c696f4421462be8b2f', '等待某人', '等待某人', '5', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('a83e75ced129421dbf11fab1f05cf8b4', '推销电话', '推销电话', '2', 'source');
INSERT INTO `tbl_dic_value` VALUES ('ab8472aab5de4ae9b388b2f1409441c1', '常规', '常规', '5', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('ab8c2a3dc05f4e3dbc7a0405f721b040', '提案/报价', '提案/报价', '5', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('b924d911426f4bc5ae3876038bc7e0ad', 'web下载', 'web下载', '12', 'source');
INSERT INTO `tbl_dic_value` VALUES ('c13ad8f9e2f74d5aa84697bb243be3bb', '价值建议', '价值建议', '3', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('c83c0be184bc40708fd7b361b6f36345', '最低', '最低', '4', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('db867ea866bc44678ac20c8a4a8bfefb', '员工介绍', '员工介绍', '3', 'source');
INSERT INTO `tbl_dic_value` VALUES ('e44be1d99158476e8e44778ed36f4355', '确定决策者', '确定决策者', '4', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('e5f383d2622b4fc0959f4fe131dafc80', '女士', '女士', '3', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('e81577d9458f4e4192a44650a3a3692b', '谈判/复审', '谈判/复审', '6', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('fb65d7fdb9c6483db02713e6bc05dd19', '在线商场', '在线商场', '5', 'source');
INSERT INTO `tbl_dic_value` VALUES ('fd677cc3b5d047d994e16f6ece4d3d45', '公开媒介', '公开媒介', '7', 'source');
INSERT INTO `tbl_dic_value` VALUES ('ff802a03ccea4ded8731427055681d48', '外部介绍', '外部介绍', '4', 'source');

-- ----------------------------
-- Table structure for tbl_tran
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran`;
CREATE TABLE `tbl_tran`  (
  `id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `owner` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `money` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `expected_date` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `customer_id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `stage` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `source` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `activity_id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `contacts_id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `edit_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `edit_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `contact_summary` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `next_contact_time` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_tran
-- ----------------------------
INSERT INTO `tbl_tran` VALUES ('30e3c91ae97e4438bff081ab1fca7000', '40f6cdea0bd34aced77492a1656d9ab3', '99999', '百度-创建交易05', '2022-07-01', '3f86eff726ae4e21b909fecda42e9fba', 'c13ad8f9e2f74d5aa84697bb243be3bb', '97d1128f70294f0aac49e996ced28c8a', 'a83e75ced129421dbf11fab1f05cf8b4', '060fc77e48ac45318385aeeeb2fb2492', '9c6e001480a9493fb8de1cceb62553b0', '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-19 17:07:42', NULL, NULL, '测试创建交易05', '测试创建交易05', '2022-05-21');
INSERT INTO `tbl_tran` VALUES ('3a6f6a2a7bcb4d3c9eb6a8eb251e97aa', '40f6cdea0bd34aced77492a1656d9ab3', '100000', '华为-交易01', '2022-09-01', '2015876ea1e34e4091e1789eadc428ad', 'e44be1d99158476e8e44778ed36f4355', '97d1128f70294f0aac49e996ced28c8a', '72f13af8f5d34134b5b3f42c5d477510', '41691553e88945a68c6546df296ef8c3', 'e05bcfb869a14e3090becbc9d7ba250b', '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-20 17:20:39', NULL, NULL, '华为交易01', '华为交易01', '2022-05-25');
INSERT INTO `tbl_tran` VALUES ('575b4682f76f4b80aab7642ad3ad19d5', '06f5fc056eac41558a964f96daa7f27c', '9999', '百度-test06', '2022-06-04', '3f86eff726ae4e21b909fecda42e9fba', 'c13ad8f9e2f74d5aa84697bb243be3bb', '954b410341e7433faa468d3c4f7cf0d2', 'a83e75ced129421dbf11fab1f05cf8b4', '6105e2b5143847398000eedc327ce9c0', '9c6e001480a9493fb8de1cceb62553b0', '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-19 17:15:10', NULL, NULL, 'test06', 'test06', '2022-05-26');
INSERT INTO `tbl_tran` VALUES ('58fa4b3b947547c3bba97bcacc0188e2', '06f5fc056eac41558a964f96daa7f27c', '9999999', 'test07', '2022-12-01', '2015876ea1e34e4091e1789eadc428ad', 'ab8c2a3dc05f4e3dbc7a0405f721b040', '97d1128f70294f0aac49e996ced28c8a', 'ff802a03ccea4ded8731427055681d48', '6105e2b5143847398000eedc327ce9c0', '2257a01ece2947f2a4ed38247bb5581f', '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-19 17:36:43', NULL, NULL, 'test07', 'test07', '2022-05-28');
INSERT INTO `tbl_tran` VALUES ('7666adee439f48ed8f8c8ec01ee69eee', '06f5fc056eac41558a964f96daa7f27c', '9', '09', '2022-06-03', '3f86eff726ae4e21b909fecda42e9fba', 'ab8c2a3dc05f4e3dbc7a0405f721b040', '97d1128f70294f0aac49e996ced28c8a', '72f13af8f5d34134b5b3f42c5d477510', '0241cad6957945379e1fa1e9d3bee61a', 'f08bb0fa56a34104a845acfec535b1a3', '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-19 17:46:43', NULL, NULL, '09', '09', '2022-05-18');
INSERT INTO `tbl_tran` VALUES ('7cdbdde9bd514fb7af799334195748c1', '06f5fc056eac41558a964f96daa7f27c', '10000', '百度', '2022-06-01', '3f86eff726ae4e21b909fecda42e9fba', '9ff57750fac04f15b10ce1bbb5bb8bab', '97d1128f70294f0aac49e996ced28c8a', 'fd677cc3b5d047d994e16f6ece4d3d45', 'd129ae5781aa44f68d0b99c0b7066aa7', '66ef4182854f4b829fd18d59c2cf54fa', '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-19 16:21:18', NULL, NULL, '测试创建交易', '测试创建交易', '2022-05-21');
INSERT INTO `tbl_tran` VALUES ('94482656ecdf4c799ed387f02c5ba5ce', '06f5fc056eac41558a964f96daa7f27c', '100000', '百度-测试创建03', '2022-06-04', '3f86eff726ae4e21b909fecda42e9fba', 'ab8c2a3dc05f4e3dbc7a0405f721b040', '97d1128f70294f0aac49e996ced28c8a', '72f13af8f5d34134b5b3f42c5d477510', 'a73d7269b86c4919b51ba68bb7f5ebf2', '9c6e001480a9493fb8de1cceb62553b0', '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-19 16:52:59', NULL, NULL, '测试创建交易03', '测试创建交易03', '2022-05-21');
INSERT INTO `tbl_tran` VALUES ('ae1a1147ec6b4a0792677635e76685a9', '40f6cdea0bd34aceb77492a1656d9fb3', '100000', '百度-测试交易02', '2022-06-02', '3f86eff726ae4e21b909fecda42e9fba', 'e81577d9458f4e4192a44650a3a3692b', '97d1128f70294f0aac49e996ced28c8a', 'fd677cc3b5d047d994e16f6ece4d3d45', '9ea86c87aad24b1497ea008a3b0ce101', '2e78a88b474c46cf89a20273ef6e65ab', '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-19 16:46:55', NULL, NULL, '测试创建交易02', '测试创建交易02', '2022-05-20');
INSERT INTO `tbl_tran` VALUES ('bd3dd9655dc94e8587fbccf7ee1c7eb2', '06f5fc056eac41558a964f96daa7f27c', '11', '11', '2022-06-03', '3f86eff726ae4e21b909fecda42e9fba', 'e44be1d99158476e8e44778ed36f4355', '954b410341e7433faa468d3c4f7cf0d2', '72f13af8f5d34134b5b3f42c5d477510', '28de65fa95aa4df7b22c71bd9d4223ca', 'f08bb0fa56a34104a845acfec535b1a3', '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-19 17:52:32', NULL, NULL, '11', '11', '2022-05-22');
INSERT INTO `tbl_tran` VALUES ('d4bf14906a144a97bddcd5517bd6a4b3', '06f5fc056eac41558a964f96daa7f27c', '9', '10', '2022-06-01', '3f86eff726ae4e21b909fecda42e9fba', 'e81577d9458f4e4192a44650a3a3692b', '954b410341e7433faa468d3c4f7cf0d2', '12302fd42bd349c1bb768b19600e6b20', '41691553e88945a68c6546df296ef8c3', 'f08bb0fa56a34104a845acfec535b1a3', '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-19 17:48:18', NULL, NULL, '10', '10', '2022-05-20');
INSERT INTO `tbl_tran` VALUES ('f8c3d4dd334a414a9d4998c771db1e2f', '40f6cdea0bd34aced77492a1656d9ab3', '5000', '吉姆餐厅-测试交易01', '2022-05-28', '2215f66fb3f14aa0aaea011d7ca8229f', 'e44be1d99158476e8e44778ed36f4355', NULL, NULL, '28de65fa95aa4df7b22c71bd9d4223ca', '2257a01ece2947f2a4ed38247bb5581f', '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-15 11:01:25', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `tbl_tran` VALUES ('fe646038822c4a4498ee8736761a8df8', '40f6cdea0bd34aced77492a1656d9ab3', '19999', '百度-测试创建交易04', '2022-06-23', '3f86eff726ae4e21b909fecda42e9fba', 'c13ad8f9e2f74d5aa84697bb243be3bb', '97d1128f70294f0aac49e996ced28c8a', 'ff802a03ccea4ded8731427055681d48', '41691553e88945a68c6546df296ef8c3', 'd48994fbd73843a790a7d2492ce1286f', '40f6cdea0bd34aced77492a1656d9ab3', '2022-05-19 16:57:21', NULL, NULL, '测试创建交易04', '测试创建交易04', '2022-05-24');

-- ----------------------------
-- Table structure for tbl_tran_history
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran_history`;
CREATE TABLE `tbl_tran_history`  (
  `id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `stage` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `money` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `expected_date` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tran_id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_tran_history
-- ----------------------------
INSERT INTO `tbl_tran_history` VALUES ('2f5c505efe3f492a8f4f8208836a2075', 'ab8c2a3dc05f4e3dbc7a0405f721b040', '9999999', '2022-12-01', '2022-05-19 17:36:43', '40f6cdea0bd34aced77492a1656d9ab3', '58fa4b3b947547c3bba97bcacc0188e2');
INSERT INTO `tbl_tran_history` VALUES ('40cb165479ff4aee9198793eed6f73b8', 'c13ad8f9e2f74d5aa84697bb243be3bb', '99999', '2022-07-01', '2022-05-19 17:07:42', '40f6cdea0bd34aced77492a1656d9ab3', '30e3c91ae97e4438bff081ab1fca7000');
INSERT INTO `tbl_tran_history` VALUES ('47187e48759e4fecb177a30b19f09b4a', 'e44be1d99158476e8e44778ed36f4355', '11', '2022-06-03', '2022-05-19 17:52:32', '40f6cdea0bd34aced77492a1656d9ab3', 'bd3dd9655dc94e8587fbccf7ee1c7eb2');
INSERT INTO `tbl_tran_history` VALUES ('48feef96928d4d1d8cc92701293a5678', 'e81577d9458f4e4192a44650a3a3692b', '9', '2022-06-01', '2022-05-19 17:48:18', '40f6cdea0bd34aced77492a1656d9ab3', 'd4bf14906a144a97bddcd5517bd6a4b3');
INSERT INTO `tbl_tran_history` VALUES ('511044f79d5441618e63cb60473e7f73', 'e44be1d99158476e8e44778ed36f4355', '100000', '2022-09-01', '2022-05-20 17:20:39', '40f6cdea0bd34aced77492a1656d9ab3', '3a6f6a2a7bcb4d3c9eb6a8eb251e97aa');
INSERT INTO `tbl_tran_history` VALUES ('60a33bb3a00044ec8ebe81223817dc85', 'e81577d9458f4e4192a44650a3a3692b', '100000', '2022-06-02', '2022-05-19 16:46:55', '40f6cdea0bd34aced77492a1656d9ab3', 'ae1a1147ec6b4a0792677635e76685a9');
INSERT INTO `tbl_tran_history` VALUES ('7ce54c32e0bd438e856187e1060afb8a', 'c13ad8f9e2f74d5aa84697bb243be3bb', '9999', '2022-06-04', '2022-05-19 17:15:10', '40f6cdea0bd34aced77492a1656d9ab3', '575b4682f76f4b80aab7642ad3ad19d5');
INSERT INTO `tbl_tran_history` VALUES ('ad470c2a15004f1198c105deb238bd3e', 'ab8c2a3dc05f4e3dbc7a0405f721b040', '9', '2022-06-03', '2022-05-19 17:46:43', '40f6cdea0bd34aced77492a1656d9ab3', '7666adee439f48ed8f8c8ec01ee69eee');
INSERT INTO `tbl_tran_history` VALUES ('d8febcec4f7142b3a9d693b6971f8612', 'ab8c2a3dc05f4e3dbc7a0405f721b040', '100000', '2022-06-04', '2022-05-19 16:52:59', '40f6cdea0bd34aced77492a1656d9ab3', '94482656ecdf4c799ed387f02c5ba5ce');
INSERT INTO `tbl_tran_history` VALUES ('ea8eaebe34f2474fb6c6578c0bc79901', '9ff57750fac04f15b10ce1bbb5bb8bab', '10000', '2022-06-01', '2022-05-19 16:21:19', '40f6cdea0bd34aced77492a1656d9ab3', '7cdbdde9bd514fb7af799334195748c1');
INSERT INTO `tbl_tran_history` VALUES ('ffb2e957980d4814b8422d08f0dfdc38', 'c13ad8f9e2f74d5aa84697bb243be3bb', '19999', '2022-06-23', '2022-05-19 16:57:21', '40f6cdea0bd34aced77492a1656d9ab3', 'fe646038822c4a4498ee8736761a8df8');

-- ----------------------------
-- Table structure for tbl_tran_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran_remark`;
CREATE TABLE `tbl_tran_remark`  (
  `id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `note_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `edit_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `edit_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `edit_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `tran_id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_tran_remark
-- ----------------------------
INSERT INTO `tbl_tran_remark` VALUES ('c329d80ac79041e1824f7aa436ae9cbe', '测试转换备注', '吉姆', '2022-05-15 10:42:13', NULL, NULL, '0', 'f8c3d4dd334a414a9d4998c771db1e2f');
INSERT INTO `tbl_tran_remark` VALUES ('e1a55ecf77b54bf8ba83d94d6ee1b62c', '测试转换备注二', '吉姆', '2022-05-15 10:42:22', NULL, NULL, '0', 'f8c3d4dd334a414a9d4998c771db1e2f');

-- ----------------------------
-- Table structure for tbl_user
-- ----------------------------
DROP TABLE IF EXISTS `tbl_user`;
CREATE TABLE `tbl_user`  (
  `id` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'uuid\r\n            ',
  `login_act` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `login_pwd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码不能采用明文存储，采用密文，MD5加密之后的数据',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `expire_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '失效时间为空的时候表示永不失效，失效时间为2018-10-10 10:10:10，则表示在该时间之前该账户可用。',
  `lock_state` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '锁定状态为空时表示启用，为0时表示锁定，为1时表示启用。',
  `deptno` char(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `allow_ips` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '允许访问的IP为空时表示IP地址永不受限，允许访问的IP可以是一个，也可以是多个，当多个IP地址的时候，采用半角逗号分隔。允许IP是192.168.100.2，表示该用户只能在IP地址为192.168.100.2的机器上使用。',
  `createTime` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `edit_time` char(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `edit_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_user
-- ----------------------------
INSERT INTO `tbl_user` VALUES ('06f5fc056eac41558a964f96daa7f27c', 'ls', '李四', 'yf123', 'ls@163.com', '2100-11-27 21:50:05', '1', 'A001', '192.168.1.1,0:0:0:0:0:0:0:1', '2018-11-22 12:11:40', '李四', NULL, NULL);
INSERT INTO `tbl_user` VALUES ('40f6cdea0bd34aceb77492a1656d9fb3', 'zs', '张三', '123456', 'zs@qq.com', '2100-11-30 23:50:55', '1', 'A001', '192.168.1.1,192.168.1.2,127.0.0.1,0:0:0:0:0:0:0:1', '2018-11-22 11:37:34', '张三', NULL, NULL);
INSERT INTO `tbl_user` VALUES ('40f6cdea0bd34aced77492a1656d9ab3', 'dreem', '吉姆', '1', 'ddddreem@163.com', '2100-11-30 23:50:55', '1', 'D001', '192.168.1.1,192.168.1.2,127.0.0.1', '2022-04-23 21:44:00', '吉姆', NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
