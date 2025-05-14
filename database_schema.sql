/*
 Navicat Premium Dump SQL

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80037 (8.0.37)
 Source Host           : localhost:3306
 Source Schema         : book_manager

 Target Server Type    : MySQL
 Target Server Version : 80037 (8.0.37)
 File Encoding         : 65001

 Date: 14/05/2025 15:53:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for books
-- ----------------------------
DROP TABLE IF EXISTS `books`;
CREATE TABLE `books`  (
  `book_id` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `authors` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `cover_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `publisher` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `categories` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`book_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of books
-- ----------------------------
INSERT INTO `books` VALUES ('5sla0EEIXQkC', '2005上半年试题分析与解答', '', 'Ben shu shi zhen dui quan guo ji suan ji ji shu yu ruan jian zhuan ye ji shu zi ge(shui ping)Kao shi bian xie de, Fen xi yu jie da le 2005 nian shang ban nian de cheng xu yuan ji, Ruan jian she ji shi ji, Ruan jian ping ce shi ji gong 10 ge ji bie de shi ti.', 'http://books.google.com/books/content?id=5sla0EEIXQkC&printsec=frontcover&img=1&zoom=1&edge=curl&imgtk=AFLRE71KyOHug1ymZn8EYvXjbcXX5_aWoC1de7cn0VRX8at3zQ-7-L_e_aI4dvDLT7Qe9PpshqKHtYwGyCdFM9D1CSqnK3sZf8Gw8wHq2IfW3xR_f7vs6u0F9N7WrHOLqcatUN5xqiOn&source=gbs_', '清华大学出版社有限公司', '');
INSERT INTO `books` VALUES ('CEL-twEACAAJ', '一个人的朝圣', 'Rachel Joyce, 乔伊斯 ((女, Joyce, Rachel))', 'Ha luo de·Fu lai,Liu shi wu sui,Zai bei jiu chang gan le si shi lai nian xiao shou dai biao hou mo mo wu wen tui xiu.Ta gen qi zi zhu zai ying guo xiang jian,Sheng huo ping jing,Fu qi shu li,Ri fu yi ri.', 'http://books.google.com/books/content?id=CEL-twEACAAJ&printsec=frontcover&img=1&zoom=1&imgtk=AFLRE71vao7Gn8VS-J4ER6ptm14ghpojyBH6ixB4uUwO_X7zC4fFRtInuWJjFW1cIFAatM9fEN-nadQ9Ijge_EWTLEnlqyWFBi3su_KJlPHttD3GVKpOJUqBqIHgUWpGhaA6bQACrNCr&source=gbs_api', '北京联合出版公司', '');
INSERT INTO `books` VALUES ('OKWIEAAAQBAJ', '大理遗爱', 'Fu Ye', '《大理遗爱》<wbr>主要讲述一个外企高管的上海大龄女在大理碰到一个让她怦然心动的<wbr>男人，在更多了解后更进一步，<wbr>但是由于种种原因最后错过的爱情故事。故事情节简单，<wbr>但是人物身份和社会地位对比强烈，<wbr>主要人物和次要人物对白深刻反映出社会现实，<wbr>一段令人伤感落泪又无法忘却的情感经历。此小说描写细腻，<wbr>用字却恰到好处，充分表现出一个文字大家的极高水平，<wbr>对社会对现实生活的抽丝剥茧暴露无遗。', 'http://books.google.com/books/publisher/content?id=OKWIEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&imgtk=AFLRE72_ZCq8WTYICA_FlH3q1Kgnsmeo7o4XAbmSBsSEZD2PCkUQXfilTchf60nfuwKQmZ4qgTOycny0nVG1vpspnxzmlJUtkYHxV5ZJEGrUAadM4j7lRbQbId5bu0qLTtLr1_Ohrqwu&s', 'Canada International Press', 'Fiction / City Life');
INSERT INTO `books` VALUES ('QVv40AEACAAJ', '我胆小如鼠', '余华', '<p>\"余华的长篇小说《活着》1992年发表于《收获》，2008年由作家出版社出版，迄今销售逾700万册，已成为中国当代文学的经典。他的长篇小说太过优秀，以至于遮蔽了精致的中短篇的光芒，实际上它们与其长篇一样优秀，是可以一读再读的精品。余华在中短篇小说中，对命运的叩问、对人性的探究和对自然的敬畏，让我们看到了他对生命的无限怜悯和对现实的深沉思考。 </p><p>内容简介</p><p>收入了中国当代经典名著《活着》作者余华在1986-1998年创作的中短篇小说《我胆小如鼠》《夏季台风》《四月三日事件》共3篇。</p><p>作者简介</p><p>余华，1960年4月出生，1983年开始写作，主要作品有《兄弟》《活着》《许三观卖血记》《在细雨中呼喊》《第七天》等。作品已被翻译成40多种语言在美国、英国、澳大利亚、法国、德国、意大利、西班牙、葡萄牙、荷兰、瑞典、挪威、丹麦、芬兰、希腊、俄罗斯、保加利亚、匈牙利、捷克、斯洛伐克、塞尔维亚、斯洛文尼亚、波兰、罗马尼亚、土耳其、巴西、以色列、埃及、科威特、日本、韩国、越南、泰国、印度和印尼等40多个国家和地区出版。曾获意大利格林扎纳-卡佛文学奖（1998年），法国文学和艺术骑士勋章（2004年），法国国际信使外国小说奖（2008年），意大利朱塞佩-阿切尔比国际文学奖（2014年）等。 </p>', 'http://books.google.com/books/content?id=QVv40AEACAAJ&printsec=frontcover&img=1&zoom=1&imgtk=AFLRE72MfUzkMOhd7trJBe7HRmdFpFET1djM5U3Yh7eHgCjlremSkkOGFgdcCnz0W3bJwr-qMwsvla775LMwd_MWhmwWIoIgxWzP9YB-xXTer6GmyoaU7TIoHuXwCqSDRMLzW4FpYQxw&source=gbs_api', '作家出版社', 'Fiction / General');

-- ----------------------------
-- Table structure for userbooks
-- ----------------------------
DROP TABLE IF EXISTS `userbooks`;
CREATE TABLE `userbooks`  (
  `userbook_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `book_id` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `tags` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `notes` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `status` enum('未开始','进行中','已完成') CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT '未开始',
  `rating` tinyint NULL DEFAULT NULL,
  `saved_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`userbook_id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  INDEX `book_id`(`book_id` ASC) USING BTREE,
  CONSTRAINT `userbooks_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `userbooks_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of userbooks
-- ----------------------------
INSERT INTO `userbooks` VALUES (5, 1, 'OKWIEAAAQBAJ', NULL, NULL, '未开始', NULL, '2025-05-13 16:36:07');
INSERT INTO `userbooks` VALUES (7, 1, 'CEL-twEACAAJ', NULL, NULL, '未开始', NULL, '2025-05-13 16:40:52');
INSERT INTO `userbooks` VALUES (8, 1, '5sla0EEIXQkC', NULL, NULL, '未开始', NULL, '2025-05-13 19:36:23');
INSERT INTO `userbooks` VALUES (9, 1, 'QVv40AEACAAJ', NULL, NULL, '未开始', NULL, '2025-05-14 13:16:59');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `avatar_url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `is_admin` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `email`(`email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, '111', '111@qq.com', '$2b$10$68NNwyhEJKII8UVMXdm1eO9nL1Iho1gi4XFNuwXTzgElu1R4J.4JW', '', 0);
INSERT INTO `users` VALUES (4, 'admin', 'admin@qq.com', '$2b$10$sMqHmbQCMZgdrVvNQxDRz.Rf.N5MtEHp8huFwAQzayEtdcAwMqSCy', '', 1);
INSERT INTO `users` VALUES (5, '222', '222@qq.com', '$2b$10$g3tTowFhO6Idt9X5mQdDneHqYjVkROA6OBtzi.8XRHxedR2f2baOK', '', 0);

SET FOREIGN_KEY_CHECKS = 1;
