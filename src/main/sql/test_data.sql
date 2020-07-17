#
# TABLE STRUCTURE FOR: labels
#

DROP TABLE IF EXISTS `labels`;

CREATE TABLE `labels` (
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('School','Course','Other') COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `labels` (`title`, `type`) VALUES ('accusantium', 'School');
INSERT INTO `labels` (`title`, `type`) VALUES ('aliquam', 'School');
INSERT INTO `labels` (`title`, `type`) VALUES ('amet', 'School');
INSERT INTO `labels` (`title`, `type`) VALUES ('animi', 'Course');
INSERT INTO `labels` (`title`, `type`) VALUES ('aut', 'School');
INSERT INTO `labels` (`title`, `type`) VALUES ('consectetur', 'School');
INSERT INTO `labels` (`title`, `type`) VALUES ('dolor', 'Course');
INSERT INTO `labels` (`title`, `type`) VALUES ('doloremque', 'Course');
INSERT INTO `labels` (`title`, `type`) VALUES ('eligendi', 'Other');
INSERT INTO `labels` (`title`, `type`) VALUES ('eos', 'Course');
INSERT INTO `labels` (`title`, `type`) VALUES ('est', 'School');
INSERT INTO `labels` (`title`, `type`) VALUES ('et', 'Course');
INSERT INTO `labels` (`title`, `type`) VALUES ('exercitationem', 'School');
INSERT INTO `labels` (`title`, `type`) VALUES ('expedita', 'Course');
INSERT INTO `labels` (`title`, `type`) VALUES ('in', 'School');
INSERT INTO `labels` (`title`, `type`) VALUES ('incidunt', 'School');
INSERT INTO `labels` (`title`, `type`) VALUES ('inventore', 'Course');
INSERT INTO `labels` (`title`, `type`) VALUES ('itaque', 'Other');
INSERT INTO `labels` (`title`, `type`) VALUES ('iusto', 'Course');
INSERT INTO `labels` (`title`, `type`) VALUES ('laboriosam', 'Other');
INSERT INTO `labels` (`title`, `type`) VALUES ('necessitatibus', 'Other');
INSERT INTO `labels` (`title`, `type`) VALUES ('nemo', 'Course');
INSERT INTO `labels` (`title`, `type`) VALUES ('nesciunt', 'Other');
INSERT INTO `labels` (`title`, `type`) VALUES ('numquam', 'Course');
INSERT INTO `labels` (`title`, `type`) VALUES ('officia', 'School');
INSERT INTO `labels` (`title`, `type`) VALUES ('provident', 'School');
INSERT INTO `labels` (`title`, `type`) VALUES ('quaerat', 'School');
INSERT INTO `labels` (`title`, `type`) VALUES ('quis', 'Other');
INSERT INTO `labels` (`title`, `type`) VALUES ('quo', 'Course');
INSERT INTO `labels` (`title`, `type`) VALUES ('repellendus', 'School');
INSERT INTO `labels` (`title`, `type`) VALUES ('reprehenderit', 'School');
INSERT INTO `labels` (`title`, `type`) VALUES ('sapiente', 'School');
INSERT INTO `labels` (`title`, `type`) VALUES ('sed', 'Other');
INSERT INTO `labels` (`title`, `type`) VALUES ('similique', 'School');
INSERT INTO `labels` (`title`, `type`) VALUES ('sit', 'Course');
INSERT INTO `labels` (`title`, `type`) VALUES ('temporibus', 'Other');
INSERT INTO `labels` (`title`, `type`) VALUES ('ut', 'Other');
INSERT INTO `labels` (`title`, `type`) VALUES ('voluptas', 'Course');
INSERT INTO `labels` (`title`, `type`) VALUES ('voluptatem', 'Course');
INSERT INTO `labels` (`title`, `type`) VALUES ('voluptatum', 'Other');

#
# TABLE STRUCTURE FOR: users
#

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `display_picture` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `display_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_joined` date DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `points` int(11) NOT NULL,
  `school` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `school` (`school`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`school`) REFERENCES `labels` (`title`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `users` (`id`, `display_picture`, `display_name`, `date_joined`, `email`, `points`, `school`) VALUES (1, NULL, 'non', '1979-09-03', 'nellie27@example.net', 996, 'accusantium');
INSERT INTO `users` (`id`, `display_picture`, `display_name`, `date_joined`, `email`, `points`, `school`) VALUES (2, NULL, 'exercitationem', '1993-02-14', 'mcdermott.osborne@example.com', 747, 'aliquam');
INSERT INTO `users` (`id`, `display_picture`, `display_name`, `date_joined`, `email`, `points`, `school`) VALUES (3, NULL, 'iure', '1993-02-17', 'hammes.elliot@example.org', 728, 'amet');
INSERT INTO `users` (`id`, `display_picture`, `display_name`, `date_joined`, `email`, `points`, `school`) VALUES (4, NULL, 'suscipit', '1975-12-28', 'fpaucek@example.org', 588, 'animi');
INSERT INTO `users` (`id`, `display_picture`, `display_name`, `date_joined`, `email`, `points`, `school`) VALUES (5, NULL, 'odio', '1996-11-11', 'idella.grimes@example.org', 935, 'aut');
INSERT INTO `users` (`id`, `display_picture`, `display_name`, `date_joined`, `email`, `points`, `school`) VALUES (6, NULL, 'qui', '2020-03-02', 'carolyne04@example.org', 833, 'consectetur');
INSERT INTO `users` (`id`, `display_picture`, `display_name`, `date_joined`, `email`, `points`, `school`) VALUES (7, NULL, 'distinctio', '1991-08-09', 'ara.rolfson@example.com', 441, 'dolor');
INSERT INTO `users` (`id`, `display_picture`, `display_name`, `date_joined`, `email`, `points`, `school`) VALUES (8, NULL, 'velit', '1994-10-08', 'arippin@example.com', 731, 'doloremque');
INSERT INTO `users` (`id`, `display_picture`, `display_name`, `date_joined`, `email`, `points`, `school`) VALUES (9, NULL, 'magnam', '2013-06-12', 'tprice@example.org', 69, 'eligendi');
INSERT INTO `users` (`id`, `display_picture`, `display_name`, `date_joined`, `email`, `points`, `school`) VALUES (10, NULL, 'mollitia', '1990-12-12', 'gideon30@example.org', 19, 'eos');
INSERT INTO `users` (`id`, `display_picture`, `display_name`, `date_joined`, `email`, `points`, `school`) VALUES (11, NULL, 'animi', '2017-04-06', 'albin.blanda@example.org', 436, 'est');
INSERT INTO `users` (`id`, `display_picture`, `display_name`, `date_joined`, `email`, `points`, `school`) VALUES (12, NULL, 'ea', '1975-11-03', 'heath.abshire@example.org', 111, 'et');
INSERT INTO `users` (`id`, `display_picture`, `display_name`, `date_joined`, `email`, `points`, `school`) VALUES (13, NULL, 'a', '2006-06-14', 'hamill.dino@example.net', 969, 'exercitationem');
INSERT INTO `users` (`id`, `display_picture`, `display_name`, `date_joined`, `email`, `points`, `school`) VALUES (14, NULL, 'inventore', '2016-03-12', 'tromp.trey@example.org', 752, 'expedita');
INSERT INTO `users` (`id`, `display_picture`, `display_name`, `date_joined`, `email`, `points`, `school`) VALUES (15, NULL, 'ut', '2011-03-07', 'morton66@example.org', 3, 'in');
INSERT INTO `users` (`id`, `display_picture`, `display_name`, `date_joined`, `email`, `points`, `school`) VALUES (16, NULL, 'vero', '1976-07-06', 'iwilkinson@example.net', 537, 'incidunt');
INSERT INTO `users` (`id`, `display_picture`, `display_name`, `date_joined`, `email`, `points`, `school`) VALUES (17, NULL, 'molestiae', '2014-07-11', 'quentin.moore@example.net', 535, 'inventore');
INSERT INTO `users` (`id`, `display_picture`, `display_name`, `date_joined`, `email`, `points`, `school`) VALUES (18, NULL, 'aut', '1995-03-30', 'sherman63@example.org', 64, 'itaque');
INSERT INTO `users` (`id`, `display_picture`, `display_name`, `date_joined`, `email`, `points`, `school`) VALUES (19, NULL, 'voluptates', '1995-06-04', 'rhianna76@example.org', 922, 'iusto');
INSERT INTO `users` (`id`, `display_picture`, `display_name`, `date_joined`, `email`, `points`, `school`) VALUES (20, NULL, 'qui', '1982-01-05', 'dibbert.elizabeth@example.net', 581, 'laboriosam');
INSERT INTO `users` (`id`, `display_picture`, `display_name`, `date_joined`, `email`, `points`, `school`) VALUES (21, NULL, 'rem', '1979-10-09', 'abernathy.skyla@example.net', 172, 'necessitatibus');
INSERT INTO `users` (`id`, `display_picture`, `display_name`, `date_joined`, `email`, `points`, `school`) VALUES (22, NULL, 'doloremque', '2012-05-26', 'ned.marquardt@example.com', 968, 'nemo');
INSERT INTO `users` (`id`, `display_picture`, `display_name`, `date_joined`, `email`, `points`, `school`) VALUES (23, NULL, 'ullam', '1981-12-08', 'klein.heber@example.org', 174, 'nesciunt');
INSERT INTO `users` (`id`, `display_picture`, `display_name`, `date_joined`, `email`, `points`, `school`) VALUES (24, NULL, 'perferendis', '1991-08-24', 'johnson.tevin@example.net', 829, 'numquam');
INSERT INTO `users` (`id`, `display_picture`, `display_name`, `date_joined`, `email`, `points`, `school`) VALUES (25, NULL, 'amet', '2012-03-08', 'jschowalter@example.net', 992, 'officia');

#
# TABLE STRUCTURE FOR: notes
#

DROP TABLE IF EXISTS `notes`;

CREATE TABLE `notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author_id` int(11) NOT NULL,
  `school` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `course` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `source_url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `pdf_source` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `date_created` date NOT NULL,
  `num_downloads` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  KEY `school` (`school`),
  KEY `course` (`course`),
  CONSTRAINT `notes_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `notes_ibfk_2` FOREIGN KEY (`school`) REFERENCES `labels` (`title`),
  CONSTRAINT `notes_ibfk_3` FOREIGN KEY (`course`) REFERENCES `labels` (`title`),
  CONSTRAINT `pdf_or_source_url_not_null` CHECK (`source_url` is not null or `pdf_source` is not null)
) ENGINE=InnoDB AUTO_INCREMENT=551 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (1, 1, 'accusantium', 'incidunt', 'Quibusdam odit et porro sit.', 'http://hodkiewicz.com/', NULL, '2008-10-07', 478);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (2, 2, 'aliquam', 'necessitatibus', 'Enim cupiditate magnam voluptatem iure.', 'http://rohan.com/', NULL, '1972-04-18', 291);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (3, 3, 'amet', 'laboriosam', 'Et nihil corrupti.', 'http://www.fisher.com/', NULL, '1986-09-16', 85);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (4, 4, 'animi', 'accusantium', 'Eos expedita adipisci.', 'http://www.auer.net/', NULL, '1988-04-28', 363);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (5, 5, 'aut', 'amet', 'Numquam sit aut accusamus.', 'http://www.ferry.com/', NULL, '1978-09-13', 473);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (6, 6, 'consectetur', 'accusantium', 'Et occaecati officia dolorem.', 'http://hellerhermann.com/', NULL, '1988-06-17', 359);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (7, 7, 'dolor', 'expedita', 'Eos debitis occaecati.', 'http://schadenaltenwerth.com/', NULL, '1973-02-03', 330);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (8, 8, 'doloremque', 'reprehenderit', 'Reprehenderit eaque aut.', 'http://www.hartmann.com/', NULL, '2009-02-02', 289);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (9, 9, 'eligendi', 'itaque', 'Voluptatem amet sit.', 'http://www.paucek.biz/', NULL, '2017-08-02', 79);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (10, 10, 'eos', 'officia', 'Tenetur voluptatem nemo.', 'http://www.dickinson.org/', NULL, '1982-02-20', 435);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (11, 11, 'est', 'inventore', 'Iste officia voluptatem.', 'http://www.wardcorkery.com/', NULL, '2006-02-10', 309);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (12, 12, 'et', 'reprehenderit', 'Ipsam voluptatem rerum sed.', 'http://hettinger.com/', NULL, '1985-08-22', 195);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (13, 13, 'exercitationem', 'voluptatem', 'Aut corrupti in.', 'http://www.legros.com/', NULL, '1989-09-19', 292);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (14, 14, 'expedita', 'quis', 'Ea natus omnis ut consequatur.', 'http://www.batz.com/', NULL, '1980-08-19', 355);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (15, 15, 'in', 'expedita', 'Nihil ab voluptatem nisi.', 'http://swaniawski.com/', NULL, '1992-03-01', 299);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (16, 16, 'incidunt', 'voluptatem', 'Eum rerum veritatis.', 'http://daniel.biz/', NULL, '2017-04-06', 492);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (17, 17, 'inventore', 'necessitatibus', 'Exercitationem in architecto.', 'http://carter.com/', NULL, '1997-11-02', 356);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (18, 18, 'itaque', 'consectetur', 'Ullam veritatis soluta.', 'http://heller.biz/', NULL, '2016-02-17', 188);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (19, 19, 'iusto', 'ut', 'Praesentium eaque illum.', 'http://www.ziemann.net/', NULL, '2019-07-01', 334);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (20, 20, 'laboriosam', 'repellendus', 'Quidem sed officia quod.', 'http://rogahn.com/', NULL, '1977-09-24', 69);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (21, 21, 'necessitatibus', 'nesciunt', 'Sed soluta ut at adipisci.', 'http://morissettemueller.com/', NULL, '1998-02-03', 498);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (22, 22, 'nemo', 'similique', 'Sit dolore laboriosam tempora.', 'http://www.skilesferry.com/', NULL, '2016-04-02', 356);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (23, 23, 'nesciunt', 'et', 'Culpa enim quia ut.', 'http://www.bartell.org/', NULL, '2017-09-22', 464);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (24, 24, 'numquam', 'consectetur', 'Id nostrum delectus sint.', 'http://goodwin.com/', NULL, '2015-04-29', 50);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (25, 25, 'officia', 'voluptas', 'Debitis ut est illo fugit.', 'http://www.streich.biz/', NULL, '1996-05-04', 369);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (26, 1, 'provident', 'voluptatem', 'Deleniti nemo iure.', 'http://lakinpollich.com/', NULL, '1973-02-27', 280);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (27, 2, 'quaerat', 'eos', 'Consequuntur dolorem animi non doloremque.', 'http://bergstrom.com/', NULL, '1978-01-22', 305);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (28, 3, 'quis', 'nemo', 'Voluptate nostrum eveniet.', 'http://berge.org/', NULL, '1977-08-06', 109);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (29, 4, 'quo', 'necessitatibus', 'Id sed.', 'http://douglaskerluke.com/', NULL, '1988-06-21', 86);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (30, 5, 'repellendus', 'voluptatum', 'Ut perferendis.', 'http://www.mcclure.org/', NULL, '2012-07-25', 212);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (31, 6, 'reprehenderit', 'voluptas', 'Voluptates reprehenderit quis nulla.', 'http://www.gerlach.org/', NULL, '1984-04-12', 359);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (32, 7, 'sapiente', 'ut', 'Eos sequi rerum est.', 'http://schneider.com/', NULL, '2007-01-10', 40);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (33, 8, 'sed', 'laboriosam', 'Ex omnis itaque explicabo.', 'http://www.wymanheller.com/', NULL, '1998-05-17', 341);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (34, 9, 'similique', 'itaque', 'Rerum nemo expedita sint.', 'http://bernier.com/', NULL, '1983-10-23', 171);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (35, 10, 'sit', 'voluptas', 'Voluptas temporibus corrupti.', 'http://beier.com/', NULL, '1995-04-25', 209);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (36, 11, 'temporibus', 'nemo', 'Veritatis cupiditate et.', 'http://langworth.biz/', NULL, '1987-05-17', 84);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (37, 12, 'ut', 'itaque', 'Nobis et nostrum ut et.', 'http://www.bogannader.org/', NULL, '1986-12-01', 335);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (38, 13, 'voluptas', 'est', 'Iusto non et veritatis.', 'http://www.eichmannkilback.org/', NULL, '2003-12-11', 303);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (39, 14, 'voluptatem', 'et', 'Ducimus voluptatem officiis deserunt enim.', 'http://www.hodkiewicz.com/', NULL, '1987-11-22', 442);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (40, 15, 'voluptatum', 'sit', 'Assumenda laborum enim occaecati.', 'http://www.corkery.info/', NULL, '1986-12-10', 296);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (41, 16, 'accusantium', 'sit', 'Reiciendis modi reiciendis.', 'http://www.conroy.com/', NULL, '1985-08-30', 196);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (42, 17, 'aliquam', 'quis', 'Assumenda enim et aspernatur.', 'http://rooblynch.biz/', NULL, '1973-08-14', 441);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (43, 18, 'amet', 'officia', 'Harum enim illo numquam vel.', 'http://www.hermannnolan.com/', NULL, '2001-02-20', 487);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (44, 19, 'animi', 'similique', 'Id quam cumque repellendus.', 'http://www.ritchieblanda.com/', NULL, '1994-04-17', 154);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (45, 20, 'aut', 'in', 'Enim praesentium et voluptatem eligendi.', 'http://wiegandtromp.com/', NULL, '2012-04-23', 330);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (46, 21, 'consectetur', 'voluptatem', 'Veritatis ullam aut.', 'http://walker.org/', NULL, '2018-11-22', 36);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (47, 22, 'dolor', 'sapiente', 'Cupiditate odio sunt iure.', 'http://mills.com/', NULL, '2006-01-07', 38);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (48, 23, 'doloremque', 'temporibus', 'Aperiam non perferendis aliquid.', 'http://purdy.net/', NULL, '1997-05-01', 476);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (49, 24, 'eligendi', 'aut', 'Enim minima et enim.', 'http://framianderson.com/', NULL, '2004-05-02', 27);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (50, 25, 'eos', 'quis', 'Officiis mollitia at.', 'http://schowalter.com/', NULL, '2016-11-07', 44);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (51, 1, 'est', 'officia', 'Et delectus blanditiis libero.', 'http://www.stiedemannjohnston.com/', NULL, '1978-05-30', 355);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (52, 2, 'et', 'quaerat', 'Facilis delectus quasi voluptatibus.', 'http://reichelblock.com/', NULL, '2001-02-21', 467);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (53, 3, 'exercitationem', 'nemo', 'Unde neque architecto sed.', 'http://rowetremblay.org/', NULL, '1987-06-06', 249);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (54, 4, 'expedita', 'ut', 'Sint quae vitae aut necessitatibus.', 'http://kirlin.com/', NULL, '1987-07-01', 465);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (55, 5, 'in', 'sed', 'Doloribus et est enim.', 'http://renner.com/', NULL, '1978-02-17', 184);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (56, 6, 'incidunt', 'laboriosam', 'Ea id autem molestiae.', 'http://ondricka.net/', NULL, '1999-05-22', 43);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (57, 7, 'inventore', 'temporibus', 'Exercitationem et eos.', 'http://www.hilpertdicki.com/', NULL, '2019-04-03', 293);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (58, 8, 'itaque', 'aliquam', 'Vel hic.', 'http://www.kutch.org/', NULL, '1984-06-02', 389);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (59, 9, 'iusto', 'accusantium', 'Quidem voluptate tenetur illum.', 'http://dicki.com/', NULL, '1971-02-21', 148);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (60, 10, 'laboriosam', 'incidunt', 'Praesentium at velit excepturi.', 'http://jastspencer.com/', NULL, '2016-04-07', 264);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (61, 11, 'necessitatibus', 'accusantium', 'Dolorem at et ipsa.', 'http://www.balistrerichristiansen.com/', NULL, '1970-01-09', 377);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (62, 12, 'nemo', 'voluptatem', 'Tempora dolorem ipsum.', 'http://roob.com/', NULL, '2005-01-05', 207);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (63, 13, 'nesciunt', 'et', 'Tenetur aperiam accusamus.', 'http://www.towneleffler.org/', NULL, '1999-12-26', 22);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (64, 14, 'numquam', 'necessitatibus', 'Dolore voluptate sequi.', 'http://www.homenick.org/', NULL, '2000-05-09', 286);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (65, 15, 'officia', 'inventore', 'Velit sint quia.', 'http://reilly.biz/', NULL, '2013-09-04', 185);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (66, 16, 'provident', 'eligendi', 'Non natus quam pariatur.', 'http://www.von.biz/', NULL, '2005-02-16', 99);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (67, 17, 'quaerat', 'aliquam', 'Similique illo praesentium.', 'http://www.gerhold.com/', NULL, '1979-12-19', 13);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (68, 18, 'quis', 'similique', 'Voluptas vel deserunt.', 'http://cormier.info/', NULL, '2002-09-09', 117);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (69, 19, 'quo', 'laboriosam', 'Excepturi rem qui sequi.', 'http://www.gislason.com/', NULL, '2012-04-13', 383);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (70, 20, 'repellendus', 'expedita', 'Odio sequi exercitationem.', 'http://kovacek.com/', NULL, '2005-12-12', 55);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (71, 21, 'reprehenderit', 'quo', 'Tenetur et qui nesciunt.', 'http://www.bruenmoore.com/', NULL, '2011-10-15', 354);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (72, 22, 'sapiente', 'in', 'Ut dolorem odio dicta.', 'http://hermann.com/', NULL, '1989-04-06', 260);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (73, 23, 'sed', 'aliquam', 'Ipsam placeat et asperiores nobis.', 'http://www.wiegand.com/', NULL, '1973-01-16', 10);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (74, 24, 'similique', 'expedita', 'Accusantium explicabo consequatur voluptas.', 'http://www.carrolllynch.info/', NULL, '1996-07-19', 175);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (75, 25, 'sit', 'doloremque', 'Magni quod.', 'http://goldner.info/', NULL, '2003-01-21', 241);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (76, 1, 'temporibus', 'inventore', 'Autem laboriosam labore dignissimos.', 'http://www.bradtke.org/', NULL, '2001-10-20', 280);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (77, 2, 'ut', 'et', 'Reprehenderit magnam sunt sed.', 'http://www.weber.biz/', NULL, '1978-02-28', 22);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (78, 3, 'voluptas', 'voluptatum', 'Minima ut et assumenda.', 'http://www.treutelhammes.biz/', NULL, '1989-02-15', 332);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (79, 4, 'voluptatem', 'et', 'Est et ut velit.', 'http://schuster.info/', NULL, '1996-12-14', 166);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (80, 5, 'voluptatum', 'incidunt', 'Occaecati ratione similique debitis.', 'http://www.beckerskiles.com/', NULL, '2018-03-17', 41);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (81, 6, 'accusantium', 'quis', 'Repellat eos dolores.', 'http://graham.com/', NULL, '2019-08-08', 411);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (82, 7, 'aliquam', 'temporibus', 'Ea similique quia.', 'http://www.rosenbaumrau.net/', NULL, '1998-02-19', 357);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (83, 8, 'amet', 'amet', 'Quia sint itaque dolorem.', 'http://www.reichertharris.info/', NULL, '1978-11-28', 267);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (84, 9, 'animi', 'eligendi', 'Voluptatem sit.', 'http://lakin.com/', NULL, '1972-06-19', 30);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (85, 10, 'aut', 'sed', 'Reiciendis ipsa omnis.', 'http://hilll.com/', NULL, '1977-09-03', 349);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (86, 11, 'consectetur', 'sit', 'Voluptatem doloribus aut magnam.', 'http://zboncak.info/', NULL, '1971-03-04', 237);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (87, 12, 'dolor', 'quis', 'Quia non veritatis.', 'http://harvey.com/', NULL, '1983-01-10', 189);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (88, 13, 'doloremque', 'quis', 'Sunt enim est et velit.', 'http://ohara.com/', NULL, '1993-09-15', 39);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (89, 14, 'eligendi', 'ut', 'Non possimus aut minus.', 'http://www.connellytorphy.org/', NULL, '1996-10-08', 141);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (90, 15, 'eos', 'quo', 'Doloremque ullam omnis.', 'http://bahringer.org/', NULL, '2007-11-25', 255);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (91, 16, 'est', 'amet', 'Aperiam officia eligendi facere.', 'http://www.hodkiewicz.com/', NULL, '2000-10-19', 130);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (92, 17, 'et', 'voluptas', 'Dignissimos expedita deserunt.', 'http://www.hartmannrohan.com/', NULL, '2009-12-01', 478);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (93, 18, 'exercitationem', 'quaerat', 'Consequatur aut rem in.', 'http://www.welchkuvalis.org/', NULL, '1992-11-28', 232);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (94, 19, 'expedita', 'in', 'Alias quisquam numquam.', 'http://wuckert.com/', NULL, '1991-04-11', 153);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (95, 20, 'in', 'itaque', 'Nemo id iste deleniti.', 'http://vonrueden.info/', NULL, '1988-02-22', 187);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (96, 21, 'incidunt', 'animi', 'Vel quis repellendus.', 'http://fritschfay.biz/', NULL, '2017-10-14', 370);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (97, 22, 'inventore', 'numquam', 'Est nulla mollitia.', 'http://kirlin.net/', NULL, '1994-02-04', 103);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (98, 23, 'itaque', 'iusto', 'Et sapiente vitae commodi.', 'http://cruickshank.com/', NULL, '2007-07-24', 35);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (99, 24, 'iusto', 'ut', 'Cupiditate quam minus qui.', 'http://lynch.com/', NULL, '1972-06-17', 18);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (100, 25, 'laboriosam', 'amet', 'Sed qui reprehenderit odit.', 'http://www.hirthe.com/', NULL, '2009-12-04', 50);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (101, 1, 'necessitatibus', 'sed', 'Vero totam voluptatum tempora.', 'http://www.windler.info/', NULL, '2005-03-29', 251);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (102, 2, 'nemo', 'officia', 'Impedit quod laudantium et.', 'http://nolan.com/', NULL, '2006-03-08', 298);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (103, 3, 'nesciunt', 'inventore', 'Rerum ut est est.', 'http://fay.com/', NULL, '2016-09-30', 48);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (104, 4, 'numquam', 'similique', 'Voluptates et non.', 'http://kuhic.org/', NULL, '1990-06-04', 68);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (105, 5, 'officia', 'voluptatem', 'Ad maxime veniam consequatur aut.', 'http://spinkawintheiser.biz/', NULL, '1990-02-28', 300);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (106, 6, 'provident', 'officia', 'Itaque rem distinctio.', 'http://leschmckenzie.net/', NULL, '2015-04-18', 382);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (107, 7, 'quaerat', 'eos', 'Nam ea aut ut.', 'http://www.kovacekaufderhar.com/', NULL, '1974-09-05', 440);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (108, 8, 'quis', 'eos', 'Explicabo eos sed et.', 'http://monahan.com/', NULL, '2012-01-10', 299);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (109, 9, 'quo', 'numquam', 'Blanditiis non molestias est.', 'http://www.dicki.biz/', NULL, '2007-07-29', 175);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (110, 10, 'repellendus', 'necessitatibus', 'Reprehenderit voluptas aliquid.', 'http://www.herzogrosenbaum.com/', NULL, '2016-09-14', 372);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (111, 11, 'reprehenderit', 'provident', 'Architecto sint iste.', 'http://swift.com/', NULL, '2020-02-06', 440);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (112, 12, 'sapiente', 'est', 'Aspernatur et corporis.', 'http://www.rolfson.com/', NULL, '1984-09-13', 446);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (113, 13, 'sed', 'inventore', 'Veniam vitae id voluptatum.', 'http://toybarton.com/', NULL, '1989-02-28', 10);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (114, 14, 'similique', 'quo', 'Iure qui nisi qui.', 'http://ryan.com/', NULL, '1970-01-21', 45);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (115, 15, 'sit', 'iusto', 'Ratione magnam amet.', 'http://www.schulisteffertz.net/', NULL, '2000-04-12', 201);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (116, 16, 'temporibus', 'eligendi', 'Delectus consequuntur ad at officiis.', 'http://cormier.com/', NULL, '1981-06-03', 356);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (117, 17, 'ut', 'numquam', 'Sint quos minus repellat.', 'http://ernser.com/', NULL, '1973-03-09', 23);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (118, 18, 'voluptas', 'dolor', 'Earum fugiat non.', 'http://www.funk.net/', NULL, '1999-11-02', 209);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (119, 19, 'voluptatem', 'ut', 'Recusandae ipsam voluptas.', 'http://www.wittingschimmel.com/', NULL, '1970-02-24', 487);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (120, 20, 'voluptatum', 'laboriosam', 'Id officia eum.', 'http://grantconsidine.com/', NULL, '1986-09-14', 199);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (121, 21, 'accusantium', 'sit', 'Et dignissimos autem.', 'http://macejkovicreinger.info/', NULL, '1973-10-31', 428);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (122, 22, 'aliquam', 'voluptatum', 'Minus nemo quibusdam iusto.', 'http://stoltenbergarmstrong.com/', NULL, '2003-01-21', 56);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (123, 23, 'amet', 'inventore', 'Dolores tempore soluta modi.', 'http://www.satterfieldtrantow.org/', NULL, '2018-11-04', 332);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (124, 24, 'animi', 'nemo', 'Fugit repellat minus repellat.', 'http://altenwerthweissnat.com/', NULL, '2002-02-04', 379);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (125, 25, 'aut', 'expedita', 'Error sit rem impedit.', 'http://www.jacobiferry.biz/', NULL, '1984-05-07', 489);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (126, 1, 'consectetur', 'sit', 'Animi necessitatibus ipsum.', 'http://turcotteturner.net/', NULL, '1977-04-15', 32);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (127, 2, 'dolor', 'officia', 'Suscipit nihil corrupti.', 'http://lind.biz/', NULL, '2019-11-30', 268);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (128, 3, 'doloremque', 'ut', 'Id debitis.', 'http://feeneykoelpin.com/', NULL, '1975-02-26', 68);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (129, 4, 'eligendi', 'expedita', 'Quasi eveniet doloremque in harum.', 'http://www.quitzonmacejkovic.com/', NULL, '2003-07-25', 239);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (130, 5, 'eos', 'necessitatibus', 'Sed cum facilis.', 'http://schneider.com/', NULL, '2006-06-26', 365);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (131, 6, 'est', 'voluptatum', 'Aut perferendis dolor consequatur.', 'http://www.binsstark.info/', NULL, '1971-07-23', 322);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (132, 7, 'et', 'consectetur', 'Veniam mollitia nemo.', 'http://www.carterreichert.com/', NULL, '2018-11-16', 265);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (133, 8, 'exercitationem', 'consectetur', 'Architecto placeat repudiandae qui.', 'http://www.lockman.com/', NULL, '2001-12-13', 80);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (134, 9, 'expedita', 'inventore', 'Molestiae ut id.', 'http://www.pfefferpacocha.net/', NULL, '1980-01-12', 172);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (135, 10, 'in', 'voluptatem', 'Ex velit doloribus unde.', 'http://www.russel.com/', NULL, '1980-01-09', 337);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (136, 11, 'incidunt', 'animi', 'Aliquam praesentium ut ut.', 'http://www.hudson.com/', NULL, '2009-04-03', 15);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (137, 12, 'inventore', 'accusantium', 'Excepturi maiores quod qui.', 'http://bradtke.com/', NULL, '2019-12-20', 161);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (138, 13, 'itaque', 'eligendi', 'Rerum quasi voluptatum quia.', 'http://www.lemke.com/', NULL, '1975-02-27', 16);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (139, 14, 'iusto', 'expedita', 'Id veritatis ut.', 'http://jaskolskiokon.com/', NULL, '2000-02-11', 52);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (140, 15, 'laboriosam', 'numquam', 'Vel voluptatem facilis voluptates.', 'http://www.rice.com/', NULL, '2019-11-05', 386);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (141, 16, 'necessitatibus', 'quo', 'Consequatur minima.', 'http://www.heidenreichorn.org/', NULL, '1982-05-07', 314);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (142, 17, 'nemo', 'voluptatum', 'Voluptas omnis voluptatibus.', 'http://hamill.net/', NULL, '2002-02-21', 328);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (143, 18, 'nesciunt', 'sit', 'Consequuntur pariatur fugiat.', 'http://cummerata.com/', NULL, '2018-01-27', 301);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (144, 19, 'numquam', 'consectetur', 'Earum sit consequuntur saepe.', 'http://spencer.info/', NULL, '2012-10-21', 21);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (145, 20, 'officia', 'quis', 'Adipisci ea molestias tempora.', 'http://rohan.com/', NULL, '2003-07-07', 329);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (146, 21, 'provident', 'exercitationem', 'Perspiciatis voluptates laudantium vero.', 'http://www.leffler.com/', NULL, '1972-08-24', 31);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (147, 22, 'quaerat', 'in', 'Reiciendis repudiandae ducimus.', 'http://www.shanahanwitting.biz/', NULL, '1982-10-03', 236);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (148, 23, 'quis', 'est', 'Ut ab expedita.', 'http://www.kulas.info/', NULL, '1980-01-23', 159);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (149, 24, 'quo', 'laboriosam', 'Facere sit maxime.', 'http://www.simonis.com/', NULL, '1987-01-09', 196);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (150, 25, 'repellendus', 'est', 'Aut saepe aut corporis.', 'http://www.boehm.com/', NULL, '1983-06-15', 68);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (151, 1, 'reprehenderit', 'reprehenderit', 'Neque et et.', 'http://www.hoppe.com/', NULL, '1988-07-21', 76);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (152, 2, 'sapiente', 'expedita', 'Recusandae ut id.', 'http://www.mraz.org/', NULL, '2017-03-31', 193);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (153, 3, 'sed', 'est', 'Magni incidunt fugiat magnam.', 'http://bins.com/', NULL, '1995-11-20', 480);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (154, 4, 'similique', 'doloremque', 'Quia consequatur dolor quibusdam occaecati.', 'http://ebertraynor.com/', NULL, '2004-06-19', 175);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (155, 5, 'sit', 'sit', 'Dolor voluptas ipsa consequuntur.', 'http://marksmann.com/', NULL, '1987-01-06', 59);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (156, 6, 'temporibus', 'numquam', 'Esse aliquam voluptates.', 'http://brakus.com/', NULL, '1984-01-29', 140);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (157, 7, 'ut', 'amet', 'Consectetur ut amet.', 'http://www.oconner.info/', NULL, '1992-08-03', 171);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (158, 8, 'voluptas', 'laboriosam', 'Rem quidem quis.', 'http://sipesyundt.com/', NULL, '2009-02-13', 316);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (159, 9, 'voluptatem', 'necessitatibus', 'Sequi est atque officia.', 'http://www.cartwrightwolff.com/', NULL, '2005-05-19', 377);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (160, 10, 'voluptatum', 'incidunt', 'Repudiandae quasi.', 'http://osinski.com/', NULL, '1987-02-15', 164);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (161, 11, 'accusantium', 'accusantium', 'Rem culpa et accusamus aliquam.', 'http://bahringer.com/', NULL, '1971-01-22', 219);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (162, 12, 'aliquam', 'laboriosam', 'Distinctio ea itaque vel.', 'http://hilll.com/', NULL, '1980-10-29', 350);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (163, 13, 'amet', 'necessitatibus', 'Dolore culpa quo.', 'http://www.kreiger.info/', NULL, '1995-05-14', 484);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (164, 14, 'animi', 'consectetur', 'Ad perspiciatis voluptatem.', 'http://bayer.org/', NULL, '2008-04-29', 293);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (165, 15, 'aut', 'temporibus', 'Delectus commodi incidunt.', 'http://www.reynoldsreynolds.com/', NULL, '1986-12-24', 29);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (166, 16, 'consectetur', 'iusto', 'In veniam voluptas enim qui.', 'http://nolanbalistreri.biz/', NULL, '2019-06-13', 242);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (167, 17, 'dolor', 'eos', 'Dolorum laudantium qui.', 'http://larson.org/', NULL, '2012-04-27', 47);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (168, 18, 'doloremque', 'ut', 'Voluptas laudantium inventore.', 'http://rodriguezdubuque.com/', NULL, '2019-06-15', 297);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (169, 19, 'eligendi', 'quaerat', 'Inventore culpa nostrum nihil doloribus.', 'http://www.bayer.com/', NULL, '1991-05-17', 124);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (170, 20, 'eos', 'numquam', 'Voluptatem hic eos.', 'http://www.beer.net/', NULL, '2010-02-04', 222);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (171, 21, 'est', 'laboriosam', 'Error rerum.', 'http://hauck.com/', NULL, '2004-09-28', 125);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (172, 22, 'et', 'incidunt', 'Cum illum deserunt delectus.', 'http://brakus.com/', NULL, '1998-04-03', 446);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (173, 23, 'exercitationem', 'nesciunt', 'Aut molestiae dolore ut.', 'http://thiel.com/', NULL, '1989-10-05', 367);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (174, 24, 'expedita', 'expedita', 'Et et est.', 'http://www.lindgrencummings.com/', NULL, '1973-07-17', 339);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (175, 25, 'in', 'nemo', 'Rerum sed qui et eos.', 'http://grimes.com/', NULL, '1977-12-14', 78);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (176, 1, 'incidunt', 'est', 'Dolor ipsam quia.', 'http://von.com/', NULL, '2006-11-08', 87);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (177, 2, 'inventore', 'quaerat', 'Dolores id laborum aspernatur.', 'http://www.wintheiserquitzon.info/', NULL, '1983-08-14', 498);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (178, 3, 'itaque', 'ut', 'Rerum consequuntur optio.', 'http://www.hartmann.biz/', NULL, '1977-01-18', 414);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (179, 4, 'iusto', 'nemo', 'Molestiae necessitatibus odit cupiditate.', 'http://www.heaney.info/', NULL, '2009-03-09', 497);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (180, 5, 'laboriosam', 'consectetur', 'Cum at qui.', 'http://www.abbott.info/', NULL, '2011-01-08', 255);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (181, 6, 'necessitatibus', 'dolor', 'Non ab aliquam et nesciunt.', 'http://gutmannbogisich.com/', NULL, '2006-04-26', 359);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (182, 7, 'nemo', 'exercitationem', 'Dicta quas aut est ratione.', 'http://www.kris.info/', NULL, '2001-01-09', 112);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (183, 8, 'nesciunt', 'laboriosam', 'Dolorum omnis placeat exercitationem.', 'http://botsford.net/', NULL, '2020-01-28', 52);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (184, 9, 'numquam', 'inventore', 'Ut laudantium qui.', 'http://www.blockpouros.com/', NULL, '2002-12-19', 179);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (185, 10, 'officia', 'laboriosam', 'Distinctio consequatur.', 'http://www.lesch.com/', NULL, '2011-12-18', 451);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (186, 11, 'provident', 'expedita', 'Et optio quia rem quam.', 'http://www.walsh.com/', NULL, '2010-09-14', 172);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (187, 12, 'quaerat', 'accusantium', 'Quia a magni.', 'http://www.price.com/', NULL, '1998-04-06', 174);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (188, 13, 'quis', 'nemo', 'Ea ut.', 'http://franecki.info/', NULL, '1975-11-24', 69);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (189, 14, 'quo', 'similique', 'Facilis officiis quis.', 'http://danielfay.com/', NULL, '2018-08-27', 143);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (190, 15, 'repellendus', 'necessitatibus', 'Et est nulla voluptatem.', 'http://hilllprice.com/', NULL, '1985-07-06', 407);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (191, 16, 'reprehenderit', 'ut', 'Ipsa optio dolor.', 'http://anderson.biz/', NULL, '1975-07-16', 466);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (192, 17, 'sapiente', 'similique', 'Nihil qui totam.', 'http://www.kertzmann.com/', NULL, '1987-03-29', 433);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (193, 18, 'sed', 'accusantium', 'Est rerum officiis est.', 'http://nicolas.com/', NULL, '1999-08-06', 116);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (194, 19, 'similique', 'itaque', 'Quod sunt et.', 'http://dietrich.com/', NULL, '1976-01-17', 68);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (195, 20, 'sit', 'voluptatem', 'Autem provident minima enim.', 'http://www.kulas.com/', NULL, '2002-01-14', 47);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (196, 21, 'temporibus', 'ut', 'Id officia nulla voluptates.', 'http://cummings.biz/', NULL, '1980-09-25', 268);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (197, 22, 'ut', 'temporibus', 'Iure ipsam et vitae.', 'http://www.handschultz.net/', NULL, '1991-02-17', 175);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (198, 23, 'voluptas', 'eligendi', 'Aliquam et culpa natus.', 'http://www.nikolaus.com/', NULL, '1987-01-21', 186);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (199, 24, 'voluptatem', 'sed', 'Doloremque earum voluptate ex.', 'http://koelpin.com/', NULL, '2017-01-06', 331);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (200, 25, 'voluptatum', 'nesciunt', 'Voluptatum omnis inventore dolor.', 'http://www.cassin.com/', NULL, '1971-03-17', 157);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (201, 1, 'accusantium', 'sed', 'Itaque cumque modi fuga.', 'http://www.hoeger.biz/', NULL, '1986-08-04', 340);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (202, 2, 'aliquam', 'exercitationem', 'Voluptas qui voluptatum.', 'http://www.denesikdouglas.com/', NULL, '1989-03-18', 127);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (203, 3, 'amet', 'voluptatem', 'Nulla quam similique ad.', 'http://schroeder.com/', NULL, '1999-02-26', 285);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (204, 4, 'animi', 'in', 'Porro ad asperiores.', 'http://www.von.com/', NULL, '1971-06-16', 19);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (205, 5, 'aut', 'quaerat', 'Est accusantium aut.', 'http://graham.net/', NULL, '2020-02-18', 233);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (206, 6, 'consectetur', 'necessitatibus', 'Itaque tenetur omnis.', 'http://considine.com/', NULL, '2019-04-01', 365);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (207, 7, 'dolor', 'provident', 'Laboriosam laudantium repudiandae numquam.', 'http://adamsharvey.com/', NULL, '2005-10-12', 337);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (208, 8, 'doloremque', 'expedita', 'Eaque voluptatum repudiandae.', 'http://www.mitchell.com/', NULL, '1998-01-18', 308);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (209, 9, 'eligendi', 'inventore', 'Adipisci mollitia repudiandae minus.', 'http://streich.com/', NULL, '1975-04-19', 96);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (210, 10, 'eos', 'dolor', 'Cumque et et illum.', 'http://www.nolanrodriguez.info/', NULL, '1979-07-16', 47);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (211, 11, 'est', 'laboriosam', 'Provident quasi id fugiat.', 'http://rempel.biz/', NULL, '1983-12-21', 211);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (212, 12, 'et', 'numquam', 'Rem facere tenetur tempore.', 'http://www.frami.com/', NULL, '2006-07-31', 223);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (213, 13, 'exercitationem', 'iusto', 'Sint doloribus molestiae ut unde.', 'http://www.douglas.com/', NULL, '1973-12-20', 196);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (214, 14, 'expedita', 'voluptatem', 'Debitis aut dolor aut.', 'http://bechtelar.com/', NULL, '2012-12-18', 135);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (215, 15, 'in', 'accusantium', 'Excepturi consequatur dolores.', 'http://bashirian.com/', NULL, '2018-02-18', 196);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (216, 16, 'incidunt', 'voluptatem', 'Voluptas voluptate eius explicabo.', 'http://www.durgan.com/', NULL, '2014-06-02', 303);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (217, 17, 'inventore', 'exercitationem', 'Fugit ea rerum.', 'http://www.pacocha.biz/', NULL, '1999-04-21', 216);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (218, 18, 'itaque', 'accusantium', 'Tempore dolores illo.', 'http://nicolashettinger.org/', NULL, '1985-10-20', 391);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (219, 19, 'iusto', 'laboriosam', 'Sit eius similique sit occaecati.', 'http://www.glover.net/', NULL, '1972-12-10', 242);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (220, 20, 'laboriosam', 'consectetur', 'Nostrum vel nihil.', 'http://grimes.net/', NULL, '1980-06-03', 424);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (221, 21, 'necessitatibus', 'nemo', 'Magni quod eius.', 'http://www.emmerich.biz/', NULL, '2001-02-25', 347);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (222, 22, 'nemo', 'inventore', 'Vel nobis enim natus.', 'http://www.keeling.com/', NULL, '1981-10-18', 305);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (223, 23, 'nesciunt', 'voluptatem', 'Ducimus unde est beatae harum.', 'http://www.herman.org/', NULL, '1997-12-31', 230);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (224, 24, 'numquam', 'nesciunt', 'Quasi culpa provident voluptatibus.', 'http://www.kling.org/', NULL, '1996-02-03', 232);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (225, 25, 'officia', 'similique', 'Mollitia consectetur explicabo.', 'http://www.mills.net/', NULL, '2008-08-05', 403);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (226, 1, 'provident', 'voluptas', 'Quaerat cupiditate provident et.', 'http://www.rau.org/', NULL, '1991-06-02', 51);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (227, 2, 'quaerat', 'laboriosam', 'Vel ducimus.', 'http://kassulke.net/', NULL, '1992-10-21', 420);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (228, 3, 'quis', 'repellendus', 'Et eligendi ex est.', 'http://www.schroederbechtelar.com/', NULL, '2006-07-20', 210);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (229, 4, 'quo', 'dolor', 'Officiis temporibus nisi.', 'http://dickens.com/', NULL, '2016-10-04', 33);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (230, 5, 'repellendus', 'exercitationem', 'Earum enim dolorem cupiditate.', 'http://hamillstehr.com/', NULL, '2006-01-20', 228);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (231, 6, 'reprehenderit', 'exercitationem', 'Iste debitis nam.', 'http://mohrbogan.com/', NULL, '1971-05-29', 295);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (232, 7, 'sapiente', 'voluptatem', 'Molestiae ipsum quis omnis.', 'http://corkery.org/', NULL, '2016-10-23', 475);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (233, 8, 'sed', 'officia', 'Amet quia repellendus facilis.', 'http://stroman.info/', NULL, '2019-01-29', 342);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (234, 9, 'similique', 'et', 'Excepturi sed et.', 'http://www.koelpin.org/', NULL, '2009-07-29', 266);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (235, 10, 'sit', 'expedita', 'Rem mollitia provident.', 'http://greenfelder.com/', NULL, '1974-03-19', 34);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (236, 11, 'temporibus', 'et', 'Et enim.', 'http://zemlak.com/', NULL, '1999-08-14', 262);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (237, 12, 'ut', 'sapiente', 'Sit pariatur quisquam.', 'http://kihn.biz/', NULL, '2010-11-02', 435);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (238, 13, 'voluptas', 'voluptatem', 'Similique alias.', 'http://swift.com/', NULL, '2015-04-23', 116);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (239, 14, 'voluptatem', 'provident', 'Ea aut voluptas.', 'http://www.feestroberts.com/', NULL, '1998-09-24', 63);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (240, 15, 'voluptatum', 'eligendi', 'Sequi magni voluptatem doloremque.', 'http://www.mooreveum.biz/', NULL, '1997-07-30', 194);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (241, 16, 'accusantium', 'consectetur', 'Excepturi saepe voluptatem amet.', 'http://franeckiconsidine.com/', NULL, '1975-06-03', 167);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (242, 17, 'aliquam', 'aut', 'Non alias culpa adipisci.', 'http://leffler.biz/', NULL, '2018-10-03', 273);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (243, 18, 'amet', 'sapiente', 'Et sed perferendis.', 'http://www.gleasongorczany.com/', NULL, '1978-12-31', 287);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (244, 19, 'animi', 'numquam', 'Molestiae velit.', 'http://yundt.com/', NULL, '2001-04-09', 402);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (245, 20, 'aut', 'animi', 'Iusto odio et.', 'http://haag.net/', NULL, '1989-07-07', 447);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (246, 21, 'consectetur', 'sapiente', 'Qui corrupti sed neque voluptas.', 'http://www.jonesheidenreich.info/', NULL, '1977-08-13', 358);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (247, 22, 'dolor', 'nemo', 'Recusandae non et saepe.', 'http://mccullough.com/', NULL, '1992-11-05', 208);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (248, 23, 'doloremque', 'incidunt', 'Impedit quidem atque doloribus.', 'http://reichertgibson.info/', NULL, '1988-05-21', 243);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (249, 24, 'eligendi', 'sed', 'Fugiat et nostrum.', 'http://www.wiza.org/', NULL, '1972-06-12', 313);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (250, 25, 'eos', 'aliquam', 'In in et voluptate.', 'http://www.gutkowski.com/', NULL, '1996-09-14', 121);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (251, 1, 'est', 'nemo', 'Alias soluta similique id.', 'http://parisian.com/', NULL, '1970-02-19', 80);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (252, 2, 'et', 'in', 'Accusamus dolorem ea.', 'http://kohlerschinner.com/', NULL, '2002-12-22', 408);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (253, 3, 'exercitationem', 'iusto', 'Ipsam non debitis odit.', 'http://hegmannmante.com/', NULL, '1991-05-06', 300);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (254, 4, 'expedita', 'laboriosam', 'Molestiae repellendus harum sed omnis.', 'http://www.kassulke.com/', NULL, '2016-05-07', 368);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (255, 5, 'in', 'voluptas', 'Earum est aut corrupti qui.', 'http://waelchiwill.com/', NULL, '1987-09-05', 8);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (256, 6, 'incidunt', 'exercitationem', 'Ut qui qui.', 'http://www.price.org/', NULL, '1978-08-25', 159);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (257, 7, 'inventore', 'itaque', 'Assumenda illum neque nam deleniti.', 'http://lednermaggio.com/', NULL, '2007-03-10', 294);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (258, 8, 'itaque', 'inventore', 'Totam rem at deleniti.', 'http://schuppe.com/', NULL, '1972-01-01', 491);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (259, 9, 'iusto', 'amet', 'Nostrum perspiciatis.', 'http://www.torp.biz/', NULL, '2015-02-06', 363);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (260, 10, 'laboriosam', 'numquam', 'Ut voluptatem et.', 'http://krajcikaufderhar.com/', NULL, '2009-07-13', 214);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (261, 11, 'necessitatibus', 'quo', 'Voluptas libero repellendus expedita.', 'http://predovic.org/', NULL, '2007-06-10', 259);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (262, 12, 'nemo', 'in', 'Sunt neque adipisci sunt.', 'http://www.dietricheffertz.com/', NULL, '2006-08-23', 428);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (263, 13, 'nesciunt', 'nesciunt', 'Perspiciatis ipsam aliquid sit.', 'http://www.hills.com/', NULL, '1977-12-09', 20);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (264, 14, 'numquam', 'expedita', 'Fuga deleniti magni ea.', 'http://www.mcdermottvolkman.com/', NULL, '2012-10-04', 360);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (265, 15, 'officia', 'quaerat', 'Facere reprehenderit tenetur.', 'http://www.gradyveum.com/', NULL, '1984-03-06', 478);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (266, 16, 'provident', 'ut', 'Voluptate nostrum.', 'http://www.langworthmills.com/', NULL, '1998-01-22', 276);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (267, 17, 'quaerat', 'provident', 'Corrupti eos doloremque.', 'http://www.yostlarson.com/', NULL, '1996-03-24', 399);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (268, 18, 'quis', 'iusto', 'Est repudiandae ut nihil.', 'http://www.stamm.com/', NULL, '1975-05-14', 223);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (269, 19, 'quo', 'sit', 'Non molestiae dicta.', 'http://www.bayer.org/', NULL, '1993-10-29', 207);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (270, 20, 'repellendus', 'est', 'Vel et aliquam et.', 'http://www.torphywilliamson.info/', NULL, '2019-12-24', 326);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (271, 21, 'reprehenderit', 'quaerat', 'Id corporis dolorum.', 'http://www.hermann.com/', NULL, '1983-11-21', 224);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (272, 22, 'sapiente', 'voluptatum', 'Est odit animi eos repudiandae.', 'http://hyatt.org/', NULL, '1973-08-10', 121);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (273, 23, 'sed', 'in', 'Rerum sed.', 'http://daniel.com/', NULL, '2001-10-08', 217);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (274, 24, 'similique', 'iusto', 'Dolores et quidem.', 'http://shanahan.org/', NULL, '1987-09-17', 306);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (275, 25, 'sit', 'numquam', 'Molestiae sed possimus.', 'http://www.schmeler.com/', NULL, '2005-05-29', 120);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (276, 1, 'temporibus', 'itaque', 'Earum sint quo optio rerum.', 'http://denesikcummings.com/', NULL, '1984-08-08', 189);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (277, 2, 'ut', 'eos', 'Ut qui dolor itaque in.', 'http://www.zemlakhane.net/', NULL, '2006-02-15', 445);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (278, 3, 'voluptas', 'consectetur', 'Aut nisi culpa.', 'http://koepp.biz/', NULL, '2006-03-25', 294);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (279, 4, 'voluptatem', 'similique', 'Quis eos sunt.', 'http://www.mckenziekuphal.biz/', NULL, '1975-01-28', 415);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (280, 5, 'voluptatum', 'amet', 'Quasi illum nam.', 'http://morarkrajcik.com/', NULL, '1993-09-22', 395);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (281, 6, 'accusantium', 'doloremque', 'Officia beatae in eum.', 'http://www.keelingmoen.com/', NULL, '1976-08-29', 301);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (282, 7, 'aliquam', 'in', 'Qui reprehenderit laudantium nisi.', 'http://www.hamillboehm.com/', NULL, '2015-02-05', 469);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (283, 8, 'amet', 'itaque', 'Libero omnis sunt.', 'http://www.cassinstark.com/', NULL, '1983-11-09', 66);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (284, 9, 'animi', 'provident', 'Quaerat tempore magnam.', 'http://www.bauch.com/', NULL, '2007-10-17', 466);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (285, 10, 'aut', 'sit', 'Sit molestiae et.', 'http://www.smith.com/', NULL, '1975-06-26', 304);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (286, 11, 'consectetur', 'in', 'Sit vero voluptatum blanditiis.', 'http://www.hessel.com/', NULL, '2018-07-21', 58);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (287, 12, 'dolor', 'voluptatem', 'Aut cupiditate fugiat id.', 'http://www.stanton.com/', NULL, '2000-01-17', 29);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (288, 13, 'doloremque', 'exercitationem', 'Rerum enim amet assumenda.', 'http://lebsack.biz/', NULL, '2002-01-08', 497);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (289, 14, 'eligendi', 'reprehenderit', 'Libero magni et.', 'http://www.gleichner.com/', NULL, '2020-07-01', 219);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (290, 15, 'eos', 'accusantium', 'Repudiandae alias.', 'http://hermanconnelly.com/', NULL, '1971-09-10', 186);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (291, 16, 'est', 'ut', 'Consectetur rerum culpa.', 'http://reichelbartoletti.com/', NULL, '2003-06-13', 176);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (292, 17, 'et', 'laboriosam', 'Culpa quia vitae.', 'http://www.oberbrunner.com/', NULL, '1982-07-03', 226);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (293, 18, 'exercitationem', 'incidunt', 'Inventore aut ullam voluptatem qui.', 'http://smithammuller.com/', NULL, '1989-11-16', 105);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (294, 19, 'expedita', 'iusto', 'Impedit voluptatem id.', 'http://feeney.info/', NULL, '1994-03-21', 442);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (295, 20, 'in', 'sed', 'Qui animi cumque iusto.', 'http://koch.com/', NULL, '2017-05-18', 449);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (296, 21, 'incidunt', 'aliquam', 'Praesentium similique non et.', 'http://bahringer.com/', NULL, '1976-01-15', 309);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (297, 22, 'inventore', 'in', 'Error ut.', 'http://www.framicole.com/', NULL, '2008-07-08', 261);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (298, 23, 'itaque', 'itaque', 'Ipsa temporibus nesciunt sed quis.', 'http://miller.org/', NULL, '1986-04-21', 373);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (299, 24, 'iusto', 'necessitatibus', 'Veritatis at consectetur aliquid.', 'http://www.abshire.com/', NULL, '1997-10-19', 277);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (300, 25, 'laboriosam', 'eos', 'Nobis autem.', 'http://kuhic.com/', NULL, '2006-06-16', 335);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (301, 1, 'necessitatibus', 'quis', 'Quia nostrum et distinctio beatae.', 'http://gutkowski.biz/', NULL, '2005-07-28', 25);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (302, 2, 'nemo', 'dolor', 'Voluptates molestias rem iste.', 'http://www.turcotte.org/', NULL, '1994-02-06', 7);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (303, 3, 'nesciunt', 'eos', 'Maxime sequi.', 'http://www.marvin.org/', NULL, '1981-01-10', 241);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (304, 4, 'numquam', 'amet', 'Quia corrupti et dolor quis.', 'http://mann.com/', NULL, '2000-08-13', 407);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (305, 5, 'officia', 'officia', 'Illo corrupti voluptatem.', 'http://heller.biz/', NULL, '1983-11-18', 312);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (306, 6, 'provident', 'sed', 'Mollitia est adipisci dolorem.', 'http://www.hills.biz/', NULL, '1970-08-10', 364);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (307, 7, 'quaerat', 'necessitatibus', 'Error qui sapiente.', 'http://jaskolski.com/', NULL, '1994-11-20', 365);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (308, 8, 'quis', 'sit', 'Tenetur et quo reprehenderit.', 'http://murphy.com/', NULL, '2011-02-10', 32);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, 
`date_created`, `num_downloads`) VALUES (309, 9, 'quo', 'voluptatem', 'Tenetur laboriosam fuga.', 'http://www.murazikgutkowski.org/', NULL, '2012-12-13', 451);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (310, 10, 'repellendus', 'expedita', 'Sint in aliquam rerum.', 'http://littel.com/', NULL, '1998-05-27', 471);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (311, 11, 'reprehenderit', 'voluptas', 'Ut quam officiis architecto.', 'http://stiedemanngoyette.info/', NULL, '1983-01-07', 23);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (312, 12, 'sapiente', 'consectetur', 'Vitae ad est iusto unde.', 'http://okeefehegmann.com/', NULL, '1977-06-01', 91);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (313, 13, 'sed', 'quo', 'Quam est tenetur dolorem.', 'http://kling.com/', NULL, '1976-09-12', 218);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (314, 14, 'similique', 'in', 'Et sint magni neque aut.', 'http://bruenadams.biz/', NULL, '1987-11-14', 323);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (315, 15, 'sit', 'reprehenderit', 'Enim ut delectus qui.', 'http://quitzonkrajcik.info/', NULL, '1991-08-29', 370);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (316, 16, 'temporibus', 'numquam', 'Fugiat reiciendis iste rerum.', 'http://rath.biz/', NULL, '1977-12-27', 376);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (317, 17, 'ut', 'quo', 'Sint natus.', 'http://stiedemann.com/', NULL, '1976-06-18', 233);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (318, 18, 'voluptas', 'quo', 'Quia pariatur deleniti eum.', 'http://kingparker.com/', NULL, '2017-05-25', 0);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (319, 19, 'voluptatem', 'temporibus', 'Corrupti accusantium sit.', 'http://zboncakleuschke.org/', NULL, '1996-02-26', 133);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (320, 20, 'voluptatum', 'laboriosam', 'Excepturi et commodi eius.', 'http://stroman.net/', NULL, '1981-05-11', 45);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (321, 21, 'accusantium', 'repellendus', 'Et ut voluptate ea eveniet.', 'http://www.mayert.com/', NULL, '2003-01-08', 8);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (322, 22, 'aliquam', 'sapiente', 'Error voluptates nobis.', 'http://buckridgetorphy.org/', NULL, '1982-12-29', 203);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (323, 23, 'amet', 'voluptatem', 'Numquam excepturi nihil.', 'http://www.pouros.org/', NULL, '2008-03-25', 273);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (324, 24, 'animi', 'aut', 'Sed soluta rerum magni voluptatem.', 'http://zboncak.com/', NULL, '2009-10-13', 40);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (325, 25, 'aut', 'eos', 'Pariatur fuga ad.', 'http://quigley.com/', NULL, '1982-09-29', 269);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (326, 1, 'consectetur', 'reprehenderit', 'Nihil commodi voluptas.', 'http://www.terry.biz/', NULL, '2015-05-30', 386);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (327, 2, 'dolor', 'dolor', 'Ea laborum numquam.', 'http://renner.net/', NULL, '2018-01-21', 219);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (328, 3, 'doloremque', 'officia', 'Corporis nisi error molestias.', 'http://www.huels.org/', NULL, '1989-09-22', 138);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (329, 4, 'eligendi', 'eligendi', 'Qui officiis qui dolorem.', 'http://kerlukequitzon.com/', NULL, '1992-12-28', 190);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (330, 5, 'eos', 'quaerat', 'Sit veritatis officia.', 'http://www.daviskoelpin.com/', NULL, '1994-02-07', 422);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (331, 6, 'est', 'similique', 'Itaque necessitatibus quia.', 'http://www.breitenbergbrakus.net/', NULL, '1975-02-09', 63);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (332, 7, 'et', 'ut', 'Consequatur ullam quam est.', 'http://www.reingergreenfelder.com/', NULL, '1971-06-16', 7);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (333, 8, 'exercitationem', 'sed', 'Soluta libero impedit modi.', 'http://www.rath.net/', NULL, '1978-07-15', 39);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (334, 9, 'expedita', 'amet', 'Sit neque est dolor.', 'http://wunsch.com/', NULL, '2004-12-24', 275);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (335, 10, 'in', 'voluptatem', 'Non doloribus et qui.', 'http://emardvolkman.com/', NULL, '1971-12-05', 47);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (336, 11, 'incidunt', 'itaque', 'Impedit reiciendis sed harum.', 'http://welch.com/', NULL, '1974-08-16', 370);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (337, 12, 'inventore', 'temporibus', 'Sequi odit cumque error.', 'http://www.mclaughlin.com/', NULL, '1980-04-11', 384);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (338, 13, 'itaque', 'laboriosam', 'Fuga eum quia.', 'http://www.gleichner.com/', NULL, '1983-10-22', 419);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (339, 14, 'iusto', 'exercitationem', 'Et voluptatibus animi vero.', 'http://kirlin.com/', NULL, '1995-02-27', 116);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (340, 15, 'laboriosam', 'similique', 'Atque rerum harum.', 'http://www.prohaskaconroy.com/', NULL, '1999-02-19', 280);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (341, 16, 'necessitatibus', 'sed', 'Aut voluptas.', 'http://www.bruen.com/', NULL, '2011-02-04', 50);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (342, 17, 'nemo', 'eos', 'Qui eligendi qui et consectetur.', 'http://rowe.com/', NULL, '1994-11-03', 64);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (343, 18, 'nesciunt', 'voluptatem', 'Maxime quaerat quibusdam ea.', 'http://www.haley.org/', NULL, '2020-02-29', 469);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (344, 19, 'numquam', 'nemo', 'Necessitatibus sint culpa doloribus.', 'http://www.schummkautzer.com/', NULL, '1981-06-30', 309);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (345, 20, 'officia', 'officia', 'Quas qui dicta enim.', 'http://www.ratke.net/', NULL, '1971-02-14', 347);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (346, 21, 'provident', 'repellendus', 'Vero quasi.', 'http://cruickshank.com/', NULL, '2009-12-05', 450);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (347, 22, 'quaerat', 'aut', 'Error inventore.', 'http://kihnroberts.com/', NULL, '1999-10-09', 155);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (348, 23, 'quis', 'expedita', 'Provident vitae neque id.', 'http://swaniawski.com/', NULL, '2011-01-23', 99);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (349, 24, 'quo', 'iusto', 'Fugiat nobis et.', 'http://www.sporer.com/', NULL, '1983-04-12', 26);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (350, 25, 'repellendus', 'voluptatum', 'Et odio sunt expedita.', 'http://grimes.net/', NULL, '1974-10-03', 479);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (351, 1, 'reprehenderit', 'sed', 'Amet consequatur non exercitationem.', 'http://www.kshlerin.com/', NULL, '1982-07-13', 278);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (352, 2, 'sapiente', 'doloremque', 'Quia quia cupiditate et magni.', 'http://cummerata.com/', NULL, '1995-08-08', 196);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (353, 3, 'sed', 'reprehenderit', 'Vel dicta inventore.', 'http://weber.org/', NULL, '1980-01-22', 309);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (354, 4, 'similique', 'sapiente', 'Suscipit est culpa qui possimus.', 'http://ohara.com/', NULL, '1979-03-18', 244);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (355, 5, 'sit', 'et', 'Et tenetur nesciunt.', 'http://www.cassin.info/', NULL, '2000-01-22', 184);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (356, 6, 'temporibus', 'accusantium', 'Ut beatae.', 'http://orncrist.info/', NULL, '2011-06-02', 308);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (357, 7, 'ut', 'nesciunt', 'Ullam quia cupiditate et.', 'http://www.terry.info/', NULL, '1985-05-16', 64);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (358, 8, 'voluptas', 'itaque', 'Sint animi sint qui.', 'http://www.wisoky.com/', NULL, '2003-12-14', 323);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (359, 9, 'voluptatem', 'officia', 'Saepe consectetur officiis voluptate.', 'http://luettgenrutherford.com/', NULL, '2007-01-12', 266);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (360, 10, 'voluptatum', 'reprehenderit', 'Sapiente sed inventore.', 'http://hesselschinner.com/', NULL, '1974-02-18', 421);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (361, 11, 'accusantium', 'aut', 'Nisi unde aspernatur impedit.', 'http://www.runtegibson.info/', NULL, '2006-08-17', 492);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (362, 12, 'aliquam', 'iusto', 'Reiciendis non nobis ullam.', 'http://nitzsche.info/', NULL, '1975-01-18', 220);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (363, 13, 'amet', 'quis', 'Voluptas dolore recusandae nemo dolores.', 'http://www.conn.com/', NULL, '1979-02-05', 62);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (364, 14, 'animi', 'ut', 'Expedita delectus cumque cumque.', 'http://kilback.com/', NULL, '1995-06-28', 256);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (365, 15, 'aut', 'nemo', 'Temporibus eaque tempora omnis.', 'http://www.ryanbeahan.com/', NULL, '2015-09-01', 450);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (366, 16, 'consectetur', 'provident', 'Consequatur alias et ea et.', 'http://www.barton.com/', NULL, '1981-05-09', 251);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (367, 17, 'dolor', 'in', 'Consequatur facere omnis.', 'http://www.padbergbraun.biz/', NULL, '1996-05-31', 382);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (368, 18, 'doloremque', 'itaque', 'Nihil dicta doloremque.', 'http://torp.com/', NULL, '1987-04-04', 277);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (369, 19, 'eligendi', 'consectetur', 'Culpa consequatur at assumenda.', 'http://johnston.com/', NULL, '1985-06-08', 53);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (370, 20, 'eos', 'quis', 'Aperiam in unde.', 'http://www.goldnerkuhlman.com/', NULL, '2018-09-21', 442);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (371, 21, 'est', 'et', 'Aut accusantium.', 'http://braunmaggio.com/', NULL, '1985-05-18', 416);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (372, 22, 'et', 'voluptatem', 'Neque repellendus corporis.', 'http://www.witting.biz/', NULL, '1981-09-18', 282);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (373, 23, 'exercitationem', 'ut', 'Quo debitis voluptatum.', 'http://www.glover.com/', NULL, '2007-10-17', 259);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (374, 24, 'expedita', 'eos', 'Quibusdam voluptatem odio dolores.', 'http://harris.org/', NULL, '2004-08-26', 377);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (375, 25, 'in', 'laboriosam', 'Eos commodi temporibus consequatur.', 'http://thompson.com/', NULL, '2004-11-01', 216);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (376, 1, 'incidunt', 'nemo', 'Ut repudiandae distinctio.', 'http://www.effertzroob.biz/', NULL, '1998-10-31', 485);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (377, 2, 'inventore', 'voluptatum', 'Aut sit officiis.', 'http://schuster.com/', NULL, '1992-03-02', 184);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (378, 3, 'itaque', 'numquam', 'Aut laudantium dolorum.', 'http://www.mclaughlin.com/', NULL, '2011-10-31', 177);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (379, 4, 'iusto', 'sit', 'Commodi eum quaerat quia.', 'http://runolfsson.org/', NULL, '2010-10-24', 407);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (380, 5, 'laboriosam', 'itaque', 'Debitis et quibusdam.', 'http://thiel.com/', NULL, '1994-04-25', 382);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (381, 6, 'necessitatibus', 'numquam', 'Quibusdam animi sint et.', 'http://ritchiemann.com/', NULL, '1979-08-27', 452);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (382, 7, 'nemo', 'quis', 'Doloremque at qui iure.', 'http://bruenhansen.com/', NULL, '2018-11-12', 73);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (383, 8, 'nesciunt', 'provident', 'Unde sit maxime.', 'http://oreilly.com/', NULL, '1990-04-04', 39);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (384, 9, 'numquam', 'in', 'Ipsam quis sit.', 'http://okuneva.org/', NULL, '1985-03-08', 33);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (385, 10, 'officia', 'iusto', 'Maiores nulla aut.', 'http://www.okeefepacocha.com/', NULL, '1972-02-04', 346);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (386, 11, 'provident', 'voluptas', 'Esse sunt odit.', 'http://www.pollich.com/', NULL, '2007-11-13', 26);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (387, 12, 'quaerat', 'in', 'Sint aspernatur.', 'http://www.conn.com/', NULL, '1987-01-16', 322);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (388, 13, 'quis', 'aliquam', 'Id veritatis.', 'http://oberbrunner.com/', NULL, '2005-10-23', 148);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (389, 14, 'quo', 'incidunt', 'Aut ut officia.', 'http://parker.com/', NULL, '1980-08-09', 116);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (390, 15, 'repellendus', 'voluptatum', 'Ut voluptatum id.', 'http://www.swift.com/', NULL, '1981-06-03', 346);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (391, 16, 'reprehenderit', 'sapiente', 'Inventore blanditiis aut.', 'http://www.greenholtzulauf.com/', NULL, '2019-02-14', 173);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (392, 17, 'sapiente', 'laboriosam', 'Vero ipsa delectus dolorem.', 'http://corwinreichel.org/', NULL, '2001-08-25', 280);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (393, 18, 'sed', 'iusto', 'Laudantium velit dolor.', 'http://www.riceklein.com/', NULL, '2007-01-04', 8);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (394, 19, 'similique', 'iusto', 'Sunt nobis exercitationem.', 'http://www.leschkuhic.com/', NULL, '1986-11-22', 212);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (395, 20, 'sit', 'inventore', 'Et ut libero.', 'http://www.stracke.biz/', NULL, '1999-07-10', 206);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (396, 21, 'temporibus', 'accusantium', 'Omnis reiciendis quo impedit.', 'http://millsbrown.org/', NULL, '2015-03-05', 240);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (397, 22, 'ut', 'aut', 'A aut cum.', 'http://murray.com/', NULL, '1995-04-07', 409);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (398, 23, 'voluptas', 'reprehenderit', 'Labore sint nemo.', 'http://www.feeneykoch.com/', NULL, '2006-06-21', 337);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (399, 24, 'voluptatem', 'itaque', 'Cumque assumenda aliquam qui.', 'http://www.walkerglover.info/', NULL, '1992-06-04', 287);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (400, 25, 'voluptatum', 'eos', 'Rerum est ut.', 'http://ortizshields.com/', NULL, '1988-05-05', 40);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (401, 1, 'accusantium', 'itaque', 'Unde tempore et quidem et.', 'http://litteldenesik.com/', NULL, '2003-07-27', 256);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (402, 2, 'aliquam', 'quo', 'At incidunt fuga sed.', 'http://www.kohlernitzsche.org/', NULL, '1997-12-31', 78);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (403, 3, 'amet', 'doloremque', 'Recusandae quo assumenda minima.', 'http://www.romaguera.info/', NULL, '2014-12-05', 126);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (404, 4, 'animi', 'in', 'Earum natus.', 'http://brekkeschulist.info/', NULL, '1974-12-02', 324);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (405, 5, 'aut', 'voluptatem', 'Atque voluptas.', 'http://www.kuhn.info/', NULL, '1977-11-05', 400);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (406, 6, 'consectetur', 'quis', 'Eaque aliquid repellendus.', 'http://braun.com/', NULL, '2015-02-15', 140);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (407, 7, 'dolor', 'ut', 'Quisquam dolorem placeat.', 'http://www.casper.com/', NULL, '1986-06-27', 224);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (408, 8, 'doloremque', 'voluptatem', 'Aliquid sit et id.', 'http://www.hermiston.info/', NULL, '1991-07-26', 155);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (409, 9, 'eligendi', 'et', 'Sint voluptatem iure.', 'http://langosh.com/', NULL, '1981-12-06', 308);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (410, 10, 'eos', 'reprehenderit', 'Quasi incidunt nam.', 'http://www.schulist.com/', NULL, '1995-09-07', 405);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (411, 11, 'est', 'incidunt', 'Temporibus est atque facilis.', 'http://www.streich.com/', NULL, '2011-09-17', 189);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (412, 12, 'et', 'sit', 'Quia tenetur odit occaecati.', 'http://www.bruen.info/', NULL, '1993-06-02', 474);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (413, 13, 'exercitationem', 'iusto', 'Voluptates qui.', 'http://www.lang.biz/', NULL, '1971-03-29', 312);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (414, 14, 'expedita', 'aliquam', 'At impedit voluptates debitis.', 'http://satterfield.com/', NULL, '2013-04-13', 201);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (415, 15, 'in', 'eos', 'Similique ut tenetur.', 'http://www.quitzon.com/', NULL, '1994-01-10', 6);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (416, 16, 'incidunt', 'voluptas', 'Amet labore officia.', 'http://www.riceabshire.com/', NULL, '1977-09-05', 207);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (417, 17, 'inventore', 'voluptatem', 'Temporibus voluptas et ipsum.', 'http://www.corkeryrempel.com/', NULL, '1980-05-16', 437);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (418, 18, 'itaque', 'officia', 'Sit dolor maiores.', 'http://www.keeling.info/', NULL, '2001-11-25', 449);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (419, 19, 'iusto', 'voluptatem', 'Sunt occaecati quaerat aut.', 'http://www.farrell.org/', NULL, '2011-10-01', 8);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (420, 20, 'laboriosam', 'expedita', 'Dignissimos ut id magnam.', 'http://bergelarson.com/', NULL, '1996-09-20', 318);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (421, 21, 'necessitatibus', 'numquam', 'Ad neque blanditiis magni.', 'http://moenoconner.net/', NULL, '2018-12-07', 127);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (422, 22, 'nemo', 'reprehenderit', 'Aliquam ab qui.', 'http://www.harris.com/', NULL, '2009-06-15', 282);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (423, 23, 'nesciunt', 'sed', 'Qui numquam odio quos.', 'http://jakubowskiruecker.org/', NULL, '2008-10-31', 385);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (424, 24, 'numquam', 'amet', 'Quia voluptas omnis ad omnis.', 'http://www.mclaughlin.com/', NULL, '2018-01-25', 287);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (425, 25, 'officia', 'eos', 'Dicta aliquam quia voluptate.', 'http://www.shanahan.com/', NULL, '2001-05-28', 129);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (426, 1, 'provident', 'eligendi', 'Ipsam sequi aliquid dolorem.', 'http://www.brakusmuller.com/', NULL, '1977-09-21', 271);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (427, 2, 'quaerat', 'animi', 'Et eos totam.', 'http://kreigerzemlak.com/', NULL, '1971-10-01', 249);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (428, 3, 'quis', 'in', 'Nemo sit consectetur.', 'http://www.kessler.com/', NULL, '2015-01-01', 258);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (429, 4, 'quo', 'voluptatum', 'Molestiae facere inventore ex.', 'http://www.hudson.biz/', NULL, '2016-07-14', 77);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (430, 5, 'repellendus', 'necessitatibus', 'Et atque quidem.', 'http://howell.org/', NULL, '1993-11-12', 223);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (431, 6, 'reprehenderit', 'officia', 'Voluptas voluptatem natus.', 'http://www.schmitttromp.info/', NULL, '2002-03-26', 292);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (432, 7, 'sapiente', 'inventore', 'Provident nihil.', 'http://www.stoltenberg.com/', NULL, '1999-12-25', 47);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (433, 8, 'sed', 'eos', 'Qui ut molestiae ut iure.', 'http://leuschkepfeffer.com/', NULL, '1974-02-13', 486);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (434, 9, 'similique', 'sed', 'Alias doloremque.', 'http://schimmel.com/', NULL, '1998-08-06', 101);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (435, 10, 'sit', 'sapiente', 'Eum sapiente est.', 'http://rutherford.com/', NULL, '1987-06-01', 189);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (436, 11, 'temporibus', 'eligendi', 'Molestias sapiente.', 'http://funk.org/', NULL, '1988-07-11', 449);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (437, 12, 'ut', 'laboriosam', 'Eos vero assumenda et.', 'http://www.fritsch.info/', NULL, '1993-03-31', 306);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (438, 13, 'voluptas', 'quis', 'Itaque qui voluptatem.', 'http://towneveum.com/', NULL, '2001-07-16', 210);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (439, 14, 'voluptatem', 'dolor', 'Eum facilis repudiandae et.', 'http://www.mosciski.com/', NULL, '2007-09-24', 495);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (440, 15, 'voluptatum', 'reprehenderit', 'Dolor dolore magni id.', 'http://kuhic.com/', NULL, '2020-06-10', 325);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (441, 16, 'accusantium', 'iusto', 'Neque voluptatem velit earum aut.', 'http://ritchie.com/', NULL, '1982-06-02', 80);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (442, 17, 'aliquam', 'nesciunt', 'Qui vel ut sed.', 'http://mckenzie.com/', NULL, '2009-06-21', 499);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (443, 18, 'amet', 'provident', 'Eaque quaerat.', 'http://www.marvin.com/', NULL, '1991-02-25', 366);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (444, 19, 'animi', 'voluptas', 'Est enim rerum.', 'http://www.romagueramarquardt.com/', NULL, '1972-11-05', 416);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (445, 20, 'aut', 'numquam', 'Modi harum praesentium.', 'http://www.langoshprice.org/', NULL, '1997-09-26', 12);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (446, 21, 'consectetur', 'sit', 'At quisquam ut fugit.', 'http://weber.biz/', NULL, '1976-04-20', 429);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (447, 22, 'dolor', 'sit', 'Architecto dolorem voluptatem asperiores.', 'http://zemlak.biz/', NULL, '1984-07-09', 272);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (448, 23, 'doloremque', 'nemo', 'Omnis sed maxime.', 'http://koch.com/', NULL, '1994-11-30', 397);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (449, 24, 'eligendi', 'iusto', 'Nobis numquam minus saepe.', 'http://www.streich.biz/', NULL, '1991-05-07', 478);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (450, 25, 'eos', 'similique', 'Facilis et ab explicabo.', 'http://www.mullerernser.org/', NULL, '1988-02-14', 42);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (451, 1, 'est', 'sit', 'Aut enim debitis corporis laudantium.', 'http://www.willmsarmstrong.com/', NULL, '1991-01-02', 157);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (452, 2, 'et', 'amet', 'Rem praesentium explicabo officia.', 'http://littel.net/', NULL, '1970-11-01', 186);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (453, 3, 'exercitationem', 'officia', 'Provident suscipit voluptatem eaque.', 'http://frami.info/', NULL, '1981-08-18', 475);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (454, 4, 'expedita', 'quis', 'Fuga est ut maiores.', 'http://www.vonrueden.com/', NULL, '1984-01-26', 96);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (455, 5, 'in', 'consectetur', 'Rerum ut deserunt ut.', 'http://www.thiel.com/', NULL, '2013-04-06', 117);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (456, 6, 'incidunt', 'similique', 'Recusandae aut qui.', 'http://www.zieme.com/', NULL, '1980-03-18', 415);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (457, 7, 'inventore', 'temporibus', 'Quae est.', 'http://willgaylord.com/', NULL, '1979-06-01', 378);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (458, 8, 'itaque', 'eligendi', 'Voluptates voluptatem ut.', 'http://www.rath.info/', NULL, '1997-11-13', 216);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (459, 9, 'iusto', 'doloremque', 'Maxime ut ducimus in.', 'http://www.schultz.biz/', NULL, '1999-12-13', 467);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (460, 10, 'laboriosam', 'temporibus', 'Ut harum nulla.', 'http://www.goldner.com/', NULL, '1979-02-15', 368);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (461, 11, 'necessitatibus', 'repellendus', 'Omnis ullam ut.', 'http://maggiocarroll.org/', NULL, '2004-04-26', 211);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (462, 12, 'nemo', 'sapiente', 'Voluptatem et eos laborum.', 'http://bednar.com/', NULL, '2020-04-24', 451);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (463, 13, 'nesciunt', 'exercitationem', 'Eligendi dolores fugit.', 'http://www.kuphalsauer.com/', NULL, '2007-11-26', 472);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (464, 14, 'numquam', 'voluptatem', 'Occaecati et et impedit.', 'http://www.fayschuster.com/', NULL, '1992-11-15', 59);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (465, 15, 'officia', 'officia', 'Doloribus aspernatur.', 'http://www.cronin.com/', NULL, '2018-08-12', 272);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (466, 16, 'provident', 'animi', 'Autem hic sit.', 'http://frami.com/', NULL, '1999-09-16', 100);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (467, 17, 'quaerat', 'dolor', 'Eaque et sunt corporis.', 'http://www.parisian.com/', NULL, '2009-07-25', 89);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (468, 18, 'quis', 'animi', 'Velit provident eos.', 'http://www.huelsvon.com/', NULL, '1971-05-30', 102);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (469, 19, 'quo', 'sapiente', 'Est aut voluptas.', 'http://prohaska.com/', NULL, '1978-08-05', 201);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (470, 20, 'repellendus', 'expedita', 'Et aut aperiam.', 'http://ernser.com/', NULL, '1980-06-09', 478);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (471, 21, 'reprehenderit', 'sit', 'Sed ipsa tempore.', 'http://rolfson.com/', NULL, '2003-10-11', 368);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (472, 22, 'sapiente', 'est', 'Aut ipsam consequatur.', 'http://www.langosh.com/', NULL, '1994-05-19', 256);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (473, 23, 'sed', 'temporibus', 'Consequatur quia molestiae dolores.', 'http://www.dietrich.biz/', NULL, '1988-11-25', 388);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (474, 24, 'similique', 'laboriosam', 'Ullam aut illo minima.', 'http://price.com/', NULL, '1993-09-30', 69);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (475, 25, 'sit', 'doloremque', 'Fuga nobis aliquam cumque.', 'http://bosco.com/', NULL, '1994-11-01', 8);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (476, 1, 'temporibus', 'iusto', 'Et quaerat.', 'http://www.flatley.net/', NULL, '1982-05-24', 335);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (477, 2, 'ut', 'in', 'Voluptatum minus aut sunt.', 'http://pacochawuckert.com/', NULL, '2014-03-24', 500);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (478, 3, 'voluptas', 'amet', 'Qui et.', 'http://www.feestruecker.com/', NULL, '1997-08-17', 197);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (479, 4, 'voluptatem', 'accusantium', 'Aut officiis est aut.', 'http://www.considinekertzmann.com/', NULL, '2006-09-20', 231);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (480, 5, 'voluptatum', 'sed', 'Similique quod nemo enim.', 'http://wittinghahn.biz/', NULL, '2015-11-19', 428);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (481, 6, 'accusantium', 'ut', 'Animi dolor est qui.', 'http://cremin.org/', NULL, '2001-12-28', 389);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (482, 7, 'aliquam', 'sit', 'Ut ducimus.', 'http://www.swift.info/', NULL, '1970-05-12', 272);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (483, 8, 'amet', 'temporibus', 'Eaque enim provident.', 'http://moen.com/', NULL, '2016-02-07', 11);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (484, 9, 'animi', 'necessitatibus', 'Eum ut perspiciatis.', 'http://www.bauch.com/', NULL, '2000-05-23', 77);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (485, 10, 'aut', 'nesciunt', 'Et quo aut.', 'http://www.bernierbaumbach.org/', NULL, '1989-12-15', 176);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (486, 11, 'consectetur', 'accusantium', 'Nisi consequatur quae.', 'http://www.rathschultz.org/', NULL, '2001-01-27', 318);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (487, 12, 'dolor', 'expedita', 'Ut totam.', 'http://bahringer.org/', NULL, '1988-12-02', 303);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (488, 13, 'doloremque', 'itaque', 'Sunt maxime quibusdam.', 'http://cruickshank.com/', NULL, '1971-05-16', 101);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (489, 14, 'eligendi', 'eos', 'Atque qui repellat.', 'http://hyatt.com/', NULL, '1988-08-27', 94);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (490, 15, 'eos', 'nemo', 'Aliquam maiores sunt accusantium.', 'http://www.conroy.net/', NULL, '1973-01-09', 41);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (491, 16, 'est', 'expedita', 'Illo ipsa omnis cum.', 'http://white.net/', NULL, '1981-01-01', 301);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (492, 17, 'et', 'voluptatem', 'Minus dolorem eum.', 'http://www.zieme.com/', NULL, '2017-05-02', 190);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (493, 18, 'exercitationem', 'expedita', 'Et amet ducimus odio.', 'http://www.kirlin.org/', NULL, '2003-11-10', 152);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (494, 19, 'expedita', 'provident', 'Iusto nihil dolore.', 'http://considine.com/', NULL, '2011-04-25', 48);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (495, 20, 'in', 'ut', 'Aut est laudantium.', 'http://www.yundt.com/', NULL, '2019-10-16', 142);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (496, 21, 'incidunt', 'voluptas', 'Rerum consequatur possimus.', 'http://www.schmelerebert.com/', NULL, '1990-05-14', 8);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (497, 22, 'inventore', 'quo', 'Accusantium voluptatibus doloribus quod.', 'http://mcclure.biz/', NULL, '1974-02-18', 185);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (498, 23, 'itaque', 'animi', 'Laboriosam vitae porro.', 'http://larkin.biz/', NULL, '2014-10-11', 284);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (499, 24, 'iusto', 'aliquam', 'Illo sit est assumenda.', 'http://medhurst.com/', NULL, '1994-09-02', 363);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (500, 25, 'laboriosam', 'necessitatibus', 'Nostrum doloremque molestiae.', 'http://www.hyattwindler.com/', NULL, '1990-12-28', 230);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (501, 1, 'necessitatibus', 'inventore', 'Occaecati fugiat mollitia.', 'http://www.ziemann.org/', NULL, '2005-12-19', 452);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (502, 2, 'nemo', 'temporibus', 'Aliquid id ea sit esse.', 'http://www.hackettkertzmann.com/', NULL, '1981-06-07', 86);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (503, 3, 'nesciunt', 'reprehenderit', 'Qui consequuntur quo repellat.', 'http://cruickshank.info/', NULL, '1992-05-06', 203);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (504, 4, 'numquam', 'exercitationem', 'Libero laborum consectetur necessitatibus.', 'http://www.grimes.com/', NULL, '1985-06-13', 276);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (505, 5, 'officia', 'in', 'Tenetur deleniti distinctio et.', 'http://www.ratke.com/', NULL, '2017-01-24', 429);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (506, 6, 'provident', 'voluptatem', 'Voluptatem illum aut aut.', 'http://www.blandakiehn.com/', NULL, '1978-09-06', 425);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (507, 7, 'quaerat', 'reprehenderit', 'Alias velit rerum placeat voluptates.', 'http://kunde.net/', NULL, '1996-05-23', 85);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (508, 8, 'quis', 'quo', 'Optio eos praesentium.', 'http://www.pricewisozk.com/', NULL, '1973-02-28', 111);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (509, 9, 'quo', 'aliquam', 'Assumenda qui.', 'http://boyle.com/', NULL, '1973-09-29', 141);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (510, 10, 'repellendus', 'reprehenderit', 'Voluptatem ipsum aut.', 'http://www.daughertyruecker.com/', NULL, '2000-10-19', 5);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (511, 11, 'reprehenderit', 'nemo', 'Eligendi esse similique recusandae.', 'http://www.mclaughlinbeatty.net/', NULL, '2015-11-24', 484);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (512, 12, 'sapiente', 'voluptas', 'Velit eligendi ipsa similique assumenda.', 'http://www.sipes.com/', NULL, '2020-07-01', 133);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (513, 13, 'sed', 'provident', 'Adipisci rerum ut nemo illo.', 'http://emard.info/', NULL, '1996-01-03', 439);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (514, 14, 'similique', 'itaque', 'Nostrum a odit officiis.', 'http://harber.org/', NULL, '2016-08-02', 359);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (515, 15, 'sit', 'itaque', 'Ipsam minima qui aliquam.', 'http://www.cassin.com/', NULL, '1970-11-25', 391);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (516, 16, 'temporibus', 'doloremque', 'Et ut optio totam.', 'http://www.schultzking.com/', NULL, '2007-05-20', 270);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (517, 17, 'ut', 'iusto', 'Quo recusandae illum cupiditate.', 'http://www.howellhessel.com/', NULL, '2010-08-27', 35);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (518, 18, 'voluptas', 'sapiente', 'Eius provident quidem saepe.', 'http://www.orn.com/', NULL, '1978-06-01', 150);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (519, 19, 'voluptatem', 'provident', 'Consequatur quas qui.', 'http://deckow.com/', NULL, '2015-03-04', 388);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (520, 20, 'voluptatum', 'quis', 'Sit a dolores.', 'http://www.ferrynader.com/', NULL, '2000-09-01', 55);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (521, 21, 'accusantium', 'expedita', 'Doloribus nesciunt quasi ipsum.', 'http://www.keebler.info/', NULL, '2013-08-15', 366);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (522, 22, 'aliquam', 'voluptatem', 'Necessitatibus veritatis amet.', 'http://herzog.com/', NULL, '1996-09-24', 196);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (523, 23, 'amet', 'provident', 'Rerum libero eum.', 'http://runolfsdottir.com/', NULL, '2020-05-22', 92);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (524, 24, 'animi', 'quaerat', 'Rerum odit.', 'http://lowefunk.com/', NULL, '2008-03-07', 74);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (525, 25, 'aut', 'numquam', 'Tempore quia commodi sunt.', 'http://gottlieb.info/', NULL, '1999-10-06', 286);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (526, 1, 'consectetur', 'nesciunt', 'In dolorum beatae.', 'http://www.swift.net/', NULL, '2000-06-11', 27);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (527, 2, 'dolor', 'officia', 'Molestiae minus qui.', 'http://bergstromcole.org/', NULL, '1987-11-25', 385);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (528, 3, 'doloremque', 'exercitationem', 'Sed eos pariatur.', 'http://www.runolfsdottir.com/', NULL, '2019-03-15', 79);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (529, 4, 'eligendi', 'quaerat', 'Atque eos aut sapiente.', 'http://www.kreiger.com/', NULL, '1999-04-06', 39);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (530, 5, 'eos', 'provident', 'Id voluptatem autem.', 'http://www.murray.info/', NULL, '1993-05-09', 79);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (531, 6, 'est', 'sed', 'Accusamus nesciunt qui molestiae.', 'http://www.simonis.com/', NULL, '2001-05-13', 134);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (532, 7, 'et', 'animi', 'Accusamus et cumque labore.', 'http://www.corkerygorczany.com/', NULL, '1989-08-12', 316);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (533, 8, 'exercitationem', 'necessitatibus', 'Et tempore consequuntur dolorem.', 'http://www.reichelboyle.com/', NULL, '2018-05-24', 262);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (534, 9, 'expedita', 'numquam', 'Quos optio modi.', 'http://www.schuppe.com/', NULL, '2000-11-20', 250);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (535, 10, 'in', 'incidunt', 'Et nihil ex.', 'http://www.mertz.info/', NULL, '2013-07-14', 387);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (536, 11, 'incidunt', 'temporibus', 'Ut saepe similique voluptatem.', 'http://terry.org/', NULL, '1997-11-16', 113);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (537, 12, 'inventore', 'nesciunt', 'Maiores aliquid voluptatem error.', 'http://schoen.com/', NULL, '1996-04-21', 407);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (538, 13, 'itaque', 'dolor', 'Et id sequi.', 'http://abernathyweber.com/', NULL, '2004-07-25', 489);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (539, 14, 'iusto', 'numquam', 'Sit iure adipisci autem.', 'http://goldnercorwin.com/', NULL, '1991-07-25', 330);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (540, 15, 'laboriosam', 'numquam', 'Maiores voluptatem animi cupiditate.', 'http://www.bartellwisozk.com/', NULL, '1987-04-18', 278);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (541, 16, 'necessitatibus', 'ut', 'Quia perferendis.', 'http://bode.net/', NULL, '1991-08-03', 176);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (542, 17, 'nemo', 'consectetur', 'Quo in laborum consequatur.', 'http://www.leffler.org/', NULL, '2002-07-26', 464);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (543, 18, 'nesciunt', 'nemo', 'Pariatur id tempore.', 'http://www.west.org/', NULL, '1991-12-17', 489);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (544, 19, 'numquam', 'nesciunt', 'Impedit et veritatis possimus et.', 'http://www.simonis.net/', NULL, '2001-01-21', 181);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (545, 20, 'officia', 'nesciunt', 'Corporis a unde et.', 'http://www.sawaynhirthe.com/', NULL, '1976-03-13', 20);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (546, 21, 'provident', 'voluptatem', 'Ut ut eaque.', 'http://www.kessler.com/', NULL, '2016-10-01', 350);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (547, 22, 'quaerat', 'reprehenderit', 'Nemo sunt doloremque.', 'http://gutmannmayert.com/', NULL, '1999-09-02', 171);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (548, 23, 'quis', 'aliquam', 'Qui voluptates id.', 'http://carroll.com/', NULL, '2012-03-05', 179);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (549, 24, 'quo', 'reprehenderit', 'Animi mollitia praesentium aut praesentium.', 'http://www.kuhn.net/', NULL, '1970-06-03', 19);
INSERT INTO `notes` (`id`, `author_id`, `school`, `course`, `title`, `source_url`, `pdf_source`, `date_created`, `num_downloads`) VALUES (550, 25, 'repellendus', 'incidunt', 'Harum eaque facilis reiciendis.', 'http://nitzsche.net/', NULL, '1975-07-06', 233);

#
# TABLE STRUCTURE FOR: favorite_notes
#

DROP TABLE IF EXISTS `favorite_notes`;

CREATE TABLE `favorite_notes` (
  `user_id` int(11) NOT NULL,
  `note_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`note_id`),
  KEY `note_id` (`note_id`),
  CONSTRAINT `favorite_notes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `favorite_notes_ibfk_2` FOREIGN KEY (`note_id`) REFERENCES `notes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (1, 1);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (1, 26);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (1, 51);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (1, 76);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (1, 101);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (1, 126);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (1, 151);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (1, 176);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (1, 201);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (1, 226);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (1, 251);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (1, 276);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (1, 301);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (1, 326);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (1, 351);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (1, 376);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (1, 401);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (1, 426);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (1, 451);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (1, 476);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (1, 501);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (1, 526);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (2, 2);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (2, 27);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (2, 52);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (2, 77);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (2, 102);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (2, 127);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (2, 152);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (2, 177);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (2, 202);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (2, 227);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (2, 252);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (2, 277);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (2, 302);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (2, 327);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (2, 352);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (2, 377);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (2, 402);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (2, 427);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (2, 452);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (2, 477);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (2, 502);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (2, 527);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (3, 3);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (3, 28);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (3, 53);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (3, 78);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (3, 103);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (3, 128);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (3, 153);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (3, 178);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (3, 203);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (3, 228);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (3, 253);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (3, 278);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (3, 303);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (3, 328);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (3, 353);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (3, 378);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (3, 403);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (3, 428);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (3, 453);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (3, 478);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (3, 503);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (3, 528);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (4, 4);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (4, 29);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (4, 54);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (4, 79);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (4, 104);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (4, 129);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (4, 154);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (4, 179);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (4, 204);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (4, 229);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (4, 254);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (4, 279);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (4, 304);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (4, 329);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (4, 354);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (4, 379);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (4, 404);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (4, 429);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (4, 454);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (4, 479);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (4, 504);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (4, 529);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (5, 5);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (5, 30);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (5, 55);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (5, 80);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (5, 105);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (5, 130);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (5, 155);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (5, 180);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (5, 205);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (5, 230);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (5, 255);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (5, 280);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (5, 305);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (5, 330);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (5, 355);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (5, 380);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (5, 405);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (5, 430);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (5, 455);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (5, 480);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (5, 505);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (5, 530);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (6, 6);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (6, 31);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (6, 56);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (6, 81);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (6, 106);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (6, 131);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (6, 156);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (6, 181);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (6, 206);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (6, 231);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (6, 256);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (6, 281);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (6, 306);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (6, 331);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (6, 356);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (6, 381);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (6, 406);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (6, 431);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (6, 456);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (6, 481);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (6, 506);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (6, 531);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (7, 7);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (7, 32);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (7, 57);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (7, 82);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (7, 107);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (7, 132);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (7, 157);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (7, 182);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (7, 207);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (7, 232);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (7, 257);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (7, 282);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (7, 307);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (7, 332);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (7, 357);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (7, 382);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (7, 407);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (7, 432);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (7, 457);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (7, 482);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (7, 507);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (7, 532);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (8, 8);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (8, 33);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (8, 58);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (8, 83);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (8, 108);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (8, 133);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (8, 158);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (8, 183);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (8, 208);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (8, 233);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (8, 258);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (8, 283);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (8, 308);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (8, 333);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (8, 358);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (8, 383);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (8, 408);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (8, 433);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (8, 458);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (8, 483);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (8, 508);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (8, 533);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (9, 9);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (9, 34);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (9, 59);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (9, 84);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (9, 109);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (9, 134);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (9, 159);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (9, 184);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (9, 209);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (9, 234);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (9, 259);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (9, 284);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (9, 309);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (9, 334);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (9, 359);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (9, 384);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (9, 409);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (9, 434);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (9, 459);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (9, 484);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (9, 509);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (9, 534);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (10, 10);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (10, 35);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (10, 60);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (10, 85);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (10, 110);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (10, 135);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (10, 160);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (10, 185);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (10, 210);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (10, 235);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (10, 260);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (10, 285);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (10, 310);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (10, 335);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (10, 360);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (10, 385);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (10, 410);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (10, 435);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (10, 460);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (10, 485);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (10, 510);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (10, 535);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (11, 11);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (11, 36);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (11, 61);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (11, 86);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (11, 111);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (11, 136);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (11, 161);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (11, 186);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (11, 211);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (11, 236);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (11, 261);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (11, 286);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (11, 311);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (11, 336);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (11, 361);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (11, 386);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (11, 411);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (11, 436);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (11, 461);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (11, 486);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (11, 511);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (11, 536);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (12, 12);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (12, 37);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (12, 62);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (12, 87);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (12, 112);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (12, 137);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (12, 162);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (12, 187);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (12, 212);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (12, 237);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (12, 262);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (12, 287);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (12, 312);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (12, 337);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (12, 362);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (12, 387);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (12, 412);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (12, 437);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (12, 462);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (12, 487);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (12, 512);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (12, 537);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (13, 13);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (13, 38);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (13, 63);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (13, 88);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (13, 113);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (13, 138);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (13, 163);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (13, 188);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (13, 213);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (13, 238);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (13, 263);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (13, 288);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (13, 313);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (13, 338);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (13, 363);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (13, 388);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (13, 413);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (13, 438);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (13, 463);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (13, 488);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (13, 513);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (13, 538);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (14, 14);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (14, 39);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (14, 64);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (14, 89);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (14, 114);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (14, 139);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (14, 164);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (14, 189);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (14, 214);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (14, 239);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (14, 264);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (14, 289);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (14, 314);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (14, 339);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (14, 364);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (14, 389);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (14, 414);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (14, 439);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (14, 464);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (14, 489);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (14, 514);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (14, 539);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (15, 15);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (15, 40);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (15, 65);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (15, 90);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (15, 115);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (15, 140);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (15, 165);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (15, 190);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (15, 215);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (15, 240);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (15, 265);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (15, 290);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (15, 315);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (15, 340);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (15, 365);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (15, 390);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (15, 415);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (15, 440);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (15, 465);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (15, 490);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (15, 515);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (15, 540);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (16, 16);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (16, 41);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (16, 66);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (16, 91);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (16, 116);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (16, 141);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (16, 166);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (16, 191);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (16, 216);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (16, 241);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (16, 266);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (16, 291);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (16, 316);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (16, 341);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (16, 366);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (16, 391);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (16, 416);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (16, 441);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (16, 466);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (16, 491);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (16, 516);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (16, 541);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (17, 17);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (17, 42);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (17, 67);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (17, 92);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (17, 117);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (17, 142);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (17, 167);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (17, 192);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (17, 217);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (17, 242);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (17, 267);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (17, 292);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (17, 317);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (17, 342);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (17, 367);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (17, 392);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (17, 417);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (17, 442);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (17, 467);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (17, 492);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (17, 517);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (17, 542);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (18, 18);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (18, 43);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (18, 68);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (18, 93);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (18, 118);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (18, 143);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (18, 168);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (18, 193);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (18, 218);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (18, 243);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (18, 268);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (18, 293);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (18, 318);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (18, 343);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (18, 368);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (18, 393);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (18, 418);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (18, 443);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (18, 468);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (18, 493);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (18, 518);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (18, 543);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (19, 19);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (19, 44);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (19, 69);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (19, 94);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (19, 119);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (19, 144);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (19, 169);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (19, 194);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (19, 219);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (19, 244);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (19, 269);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (19, 294);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (19, 319);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (19, 344);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (19, 369);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (19, 394);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (19, 419);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (19, 444);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (19, 469);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (19, 494);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (19, 519);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (19, 544);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (20, 20);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (20, 45);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (20, 70);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (20, 95);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (20, 120);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (20, 145);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (20, 170);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (20, 195);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (20, 220);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (20, 245);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (20, 270);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (20, 295);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (20, 320);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (20, 345);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (20, 370);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (20, 395);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (20, 420);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (20, 445);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (20, 470);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (20, 495);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (20, 520);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (20, 545);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (21, 21);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (21, 46);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (21, 71);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (21, 96);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (21, 121);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (21, 146);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (21, 171);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (21, 196);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (21, 221);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (21, 246);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (21, 271);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (21, 296);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (21, 321);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (21, 346);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (21, 371);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (21, 396);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (21, 421);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (21, 446);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (21, 471);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (21, 496);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (21, 521);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (21, 546);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (22, 22);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (22, 47);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (22, 72);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (22, 97);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (22, 122);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (22, 147);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (22, 172);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (22, 197);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (22, 222);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (22, 247);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (22, 272);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (22, 297);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (22, 322);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (22, 347);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (22, 372);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (22, 397);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (22, 422);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (22, 447);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (22, 472);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (22, 497);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (22, 522);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (22, 547);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (23, 23);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (23, 48);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (23, 73);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (23, 98);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (23, 123);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (23, 148);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (23, 173);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (23, 198);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (23, 223);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (23, 248);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (23, 273);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (23, 298);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (23, 323);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (23, 348);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (23, 373);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (23, 398);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (23, 423);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (23, 448);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (23, 473);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (23, 498);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (23, 523);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (23, 548);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (24, 24);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (24, 49);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (24, 74);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (24, 99);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (24, 124);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (24, 149);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (24, 174);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (24, 199);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (24, 224);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (24, 249);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (24, 274);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (24, 299);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (24, 324);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (24, 349);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (24, 374);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (24, 399);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (24, 424);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (24, 449);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (24, 474);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (24, 499);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (24, 524);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (24, 549);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (25, 25);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (25, 50);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (25, 75);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (25, 100);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (25, 125);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (25, 150);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (25, 175);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (25, 200);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (25, 225);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (25, 250);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (25, 275);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (25, 300);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (25, 325);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (25, 350);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (25, 375);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (25, 400);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (25, 425);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (25, 450);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (25, 475);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (25, 500);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (25, 525);
INSERT INTO `favorite_notes` (`user_id`, `note_id`) VALUES (25, 550);

INSERT INTO `favorite_notes` VALUES ('1','37'),
('1','67'),
('1','152'),
('1','154'),
('1','156'),
('1','195'),
('1','197'),
('1','303'),
('1','389'),
('2','16'),
('2','76'),
('2','90'),
('2','109'),
('2','112'),
('2','133'),
('2','138'),
('2','176'),
('2','181'),
('2','208'),
('2','234'),
('2','346'),
('2','349'),
('2','371'),
('2','382'),
('2','433'),
('2','516'),
('2','526'),
('3','10'),
('3','67'),
('3','195'),
('3','236'),
('3','340'),
('3','343'),
('3','441'),
('3','548'),
('4','12'),
('4','34'),
('4','59'),
('4','68'),
('4','83'),
('4','106'),
('4','107'),
('4','218'),
('4','269'),
('4','309'),
('4','325'),
('4','328'),
('4','367'),
('4','402'),
('4','421'),
('4','448'),
('4','477'),
('4','545'),
('5','28'),
('5','29'),
('5','76'),
('5','106'),
('5','188'),
('5','244'),
('5','245'),
('5','266'),
('5','267'),
('5','290'),
('5','341'),
('5','431'),
('5','474'),
('6','123'),
('6','178'),
('6','199'),
('6','314'),
('6','384'),
('6','494'),
('6','496'),
('7','84'),
('7','171'),
('7','178'),
('7','183'),
('7','243'),
('7','262'),
('7','356'),
('7','363'),
('7','418'),
('7','441'),
('7','506'),
('7','508'),
('7','510'),
('8','2'),
('8','109'),
('8','112'),
('8','201'),
('8','213'),
('8','220'),
('8','310'),
('8','375'),
('8','396'),
('8','421'),
('9','58'),
('9','148'),
('9','174'),
('9','201'),
('9','229'),
('9','261'),
('9','263'),
('9','495'),
('10','16'),
('10','126'),
('10','140'),
('10','219'),
('10','234'),
('10','244'),
('10','296'),
('10','309'),
('10','313'),
('10','329'),
('11','6'),
('11','21'),
('11','26'),
('11','110'),
('11','258'),
('11','332'),
('11','393'),
('11','456'),
('11','457'),
('11','527'),
('12','7'),
('12','55'),
('12','65'),
('12','140'),
('12','152'),
('12','218'),
('12','376'),
('12','382'),
('12','500'),
('13','55'),
('13','221'),
('13','273'),
('13','308'),
('13','344'),
('13','417'),
('13','420'),
('13','425'),
('13','475'),
('13','504'),
('13','509'),
('14','25'),
('14','128'),
('14','162'),
('14','170'),
('14','200'),
('14','217'),
('14','250'),
('14','277'),
('14','408'),
('14','457'),
('14','526'),
('15','68'),
('15','103'),
('15','235'),
('15','242'),
('15','288'),
('15','341'),
('15','373'),
('15','435'),
('15','536'),
('16','23'),
('16','64'),
('16','101'),
('16','123'),
('16','192'),
('16','213'),
('16','265'),
('16','395'),
('16','396'),
('16','426'),
('16','493'),
('16','497'),
('16','543'),
('17','125'),
('17','164'),
('17','225'),
('17','290'),
('17','305'),
('17','326'),
('17','407'),
('17','418'),
('17','474'),
('18','56'),
('18','83'),
('18','114'),
('18','171'),
('18','217'),
('18','261'),
('18','274'),
('18','341'),
('18','353'),
('18','407'),
('18','451'),
('18','488'),
('18','505'),
('18','510'),
('19','33'),
('19','48'),
('19','75'),
('19','232'),
('19','234'),
('19','240'),
('19','318'),
('19','346'),
('19','376'),
('19','404'),
('19','418'),
('19','439'),
('19','460'),
('19','477'),
('19','537'),
('20','14'),
('20','60'),
('20','78'),
('20','116'),
('20','128'),
('20','179'),
('20','199'),
('20','202'),
('20','255'),
('20','279'),
('20','281'),
('20','335'),
('20','369'),
('20','375'),
('20','396'),
('20','440'),
('21','78'),
('21','147'),
('21','202'),
('21','207'),
('21','236'),
('21','238'),
('21','293'),
('21','301'),
('21','323'),
('21','370'),
('21','513'),
('22','64'),
('22','328'),
('22','408'),
('22','446'),
('22','462'),
('22','503'),
('22','518'),
('22','520'),
('23','146'),
('23','155'),
('23','167'),
('23','237'),
('23','280'),
('23','302'),
('23','371'),
('23','419'),
('23','546'),
('24','43'),
('24','90'),
('24','92'),
('24','102'),
('24','120'),
('24','241'),
('24','251'),
('24','316'),
('24','333'),
('24','345'),
('24','444'),
('25','7'),
('25','13'),
('25','39'),
('25','99'),
('25','209'),
('25','215'),
('25','219'),
('25','365'),
('25','399'),
('25','520'),
('25','549');

INSERT INTO `favorite_notes` VALUES ('1','35'),
('1','60'),
('1','63'),
('1','115'),
('1','192'),
('2','26'),
('2','37'),
('2','143'),
('2','150'),
('3','38'),
('3','55'),
('3','167'),
('4','48'),
('4','85'),
('4','112'),
('4','115'),
('4','131'),
('4','136'),
('5','63'),
('5','67'),
('5','116'),
('5','140'),
('5','174'),
('6','7'),
('6','19'),
('6','35'),
('6','79'),
('6','95'),
('6','114'),
('7','98'),
('7','127'),
('7','165'),
('7','177'),
('8','16'),
('8','103'),
('8','117'),
('8','141'),
('8','182'),
('9','12'),
('9','42'),
('9','73'),
('9','92'),
('9','133'),
('9','186'),
('10','59'),
('10','75'),
('10','81'),
('10','101'),
('10','108'),
('10','175'),
('11','4'),
('11','43'),
('11','156'),
('11','181'),
('11','184'),
('12','21'),
('12','99'),
('12','136'),
('12','168'),
('12','186'),
('13','26'),
('13','27'),
('13','36'),
('13','73'),
('13','137'),
('14','59'),
('14','73'),
('14','87'),
('14','122'),
('14','138'),
('14','186'),
('15','27'),
('15','111'),
('15','129'),
('15','197'),
('16','2'),
('16','12'),
('16','53'),
('16','144'),
('16','173'),
('17','57'),
('17','63'),
('17','69'),
('17','126'),
('17','130'),
('18','25'),
('18','126'),
('18','131'),
('18','162'),
('18','164'),
('18','179'),
('19','16'),
('19','38'),
('19','78'),
('19','138'),
('19','183'),
('19','200'),
('20','7'),
('20','15'),
('20','112'),
('20','143'),
('20','167'),
('20','188'),
('21','3'),
('21','36'),
('21','52'),
('21','60'),
('21','82'),
('21','189'),
('22','1'),
('22','35'),
('22','143'),
('22','149'),
('22','189'),
('23','54'),
('23','56'),
('23','69'),
('23','71'),
('23','72'),
('23','101'),
('24','13'),
('24','28'),
('24','55'),
('24','115'),
('24','166'),
('25','76'),
('25','112'),
('25','132'),
('25','139'),
('25','180'),
('25','188'); 

INSERT INTO `favorite_notes` VALUES ('1','13'),
('1','43'),
('1','66'),
('1','92'),
('1','107'),
('1','118'),
('2','39'),
('2','83'),
('2','86'),
('2','106'),
('2','119'),
('2','128'),
('3','61'),
('3','76'),
('3','87'),
('3','88'),
('3','94'),
('3','133'),
('4','10'),
('4','28'),
('4','31'),
('4','67'),
('4','73'),
('4','97'),
('4','124'),
('4','127'),
('4','134'),
('5','2'),
('5','16'),
('5','40'),
('5','54'),
('5','70'),
('5','82'),
('5','135'),
('5','137'),
('6','22'),
('6','30'),
('6','105'),
('6','112'),
('6','138'),
('7','5'),
('7','68'),
('7','99'),
('7','144'),
('7','147'),
('8','52'),
('8','78'),
('8','136'),
('8','142'),
('9','20'),
('9','63'),
('9','150'),
('10','8'),
('10','33'),
('10','48'),
('10','49'),
('10','77'),
('10','93'),
('10','111'),
('10','130'),
('11','17'),
('11','38'),
('11','56'),
('11','69'),
('11','120'),
('11','123'),
('12','64'),
('12','71'),
('12','79'),
('12','95'),
('12','110'),
('12','114'),
('13','18'),
('13','23'),
('13','74'),
('13','103'),
('13','117'),
('13','129'),
('13','140'),
('14','9'),
('14','26'),
('14','41'),
('14','44'),
('14','75'),
('14','100'),
('15','59'),
('16','25'),
('16','50'),
('16','98'),
('16','108'),
('16','113'),
('16','131'),
('17','32'),
('17','35'),
('17','36'),
('17','37'),
('17','60'),
('17','141'),
('17','149'),
('18','24'),
('18','51'),
('18','62'),
('18','84'),
('18','90'),
('18','102'),
('19','1'),
('19','3'),
('19','7'),
('19','47'),
('19','57'),
('19','121'),
('19','145'),
('20','6'),
('20','80'),
('20','91'),
('20','101'),
('21','12'),
('21','53'),
('21','122'),
('22','15'),
('22','19'),
('22','58'),
('23','21'),
('23','27'),
('23','34'),
('23','46'),
('23','81'),
('23','89'),
('23','115'),
('23','126'),
('24','11'),
('24','29'),
('24','45'),
('24','104'),
('24','125'),
('24','139'),
('25','4'),
('25','14'),
('25','42'),
('25','55'),
('25','72'),
('25','96'),
('25','116'); 

INSERT INTO `favorite_notes` VALUES ('1','56'),
('1','133'),
('1','149'),
('1','153'),
('2','47'),
('2','61'),
('2','120'),
('2','187'),
('3','139'),
('3','147'),
('3','175'),
('3','198'),
('4','15'),
('4','33'),
('4','128'),
('4','148'),
('5','85'),
('5','143'),
('5','151'),
('6','3'),
('6','118'),
('6','148'),
('6','175'),
('7','36'),
('7','81'),
('7','89'),
('7','163'),
('8','3'),
('8','66'),
('8','71'),
('9','111'),
('9','115'),
('9','121'),
('9','142'),
('10','37'),
('10','58'),
('10','91'),
('10','114'),
('11','13'),
('11','22'),
('11','107'),
('11','108'),
('12','59'),
('12','107'),
('12','124'),
('13','3'),
('13','66'),
('13','72'),
('13','172'),
('14','16'),
('14','76'),
('14','92'),
('14','173'),
('15','82'),
('15','172'),
('15','174'),
('16','39'),
('16','85'),
('16','130'),
('16','146'),
('17','81'),
('17','105'),
('17','123'),
('17','127'),
('18','36'),
('18','78'),
('18','79'),
('18','124'),
('19','61'),
('19','87'),
('19','111'),
('19','195'),
('20','66'),
('20','96'),
('20','157'),
('21','8'),
('21','98'),
('21','149'),
('21','161'),
('22','40'),
('22','126'),
('22','141'),
('22','146'),
('23','42'),
('23','83'),
('23','176'),
('23','180'),
('24','38'),
('24','86'),
('24','133'),
('24','165'),
('25','1'),
('25','34'),
('25','36'),
('25','57'); 

#
# TABLE STRUCTURE FOR: misc_note_labels
#

DROP TABLE IF EXISTS `misc_note_labels`;

CREATE TABLE `misc_note_labels` (
  `note_id` int(11) NOT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`note_id`,`label`),
  KEY `label` (`label`),
  CONSTRAINT `misc_note_labels_ibfk_1` FOREIGN KEY (`note_id`) REFERENCES `notes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `misc_note_labels_ibfk_2` FOREIGN KEY (`label`) REFERENCES `labels` (`title`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (1, 'accusantium');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (2, 'aliquam');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (3, 'amet');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (4, 'animi');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (5, 'aut');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (6, 'consectetur');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (7, 'dolor');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (8, 'doloremque');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (9, 'eligendi');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (10, 'eos');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (11, 'est');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (12, 'et');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (13, 'exercitationem');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (14, 'expedita');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (15, 'in');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (16, 'incidunt');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (17, 'inventore');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (18, 'itaque');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (19, 'iusto');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (20, 'laboriosam');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (21, 'necessitatibus');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (22, 'nemo');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (23, 'nesciunt');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (24, 'numquam');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (25, 'officia');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (26, 'provident');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (27, 'quaerat');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (28, 'quis');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (29, 'quo');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (30, 'repellendus');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (31, 'reprehenderit');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (32, 'sapiente');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (33, 'sed');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (34, 'similique');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (35, 'sit');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (36, 'temporibus');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (37, 'ut');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (38, 'voluptas');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (39, 'voluptatem');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (40, 'voluptatum');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (41, 'accusantium');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (42, 'aliquam');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (43, 'amet');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (44, 'animi');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (45, 'aut');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (46, 'consectetur');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (47, 'dolor');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (48, 'doloremque');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (49, 'eligendi');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (50, 'eos');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (51, 'est');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (52, 'et');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (53, 'exercitationem');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (54, 'expedita');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (55, 'in');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (56, 'incidunt');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (57, 'inventore');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (58, 'itaque');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (59, 'iusto');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (60, 'laboriosam');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (61, 'necessitatibus');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (62, 'nemo');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (63, 'nesciunt');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (64, 'numquam');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (65, 'officia');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (66, 'provident');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (67, 'quaerat');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (68, 'quis');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (69, 'quo');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (70, 'repellendus');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (71, 'reprehenderit');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (72, 'sapiente');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (73, 'sed');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (74, 'similique');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (75, 'sit');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (76, 'temporibus');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (77, 'ut');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (78, 'voluptas');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (79, 'voluptatem');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (80, 'voluptatum');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (81, 'accusantium');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (82, 'aliquam');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (83, 'amet');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (84, 'animi');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (85, 'aut');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (86, 'consectetur');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (87, 'dolor');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (88, 'doloremque');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (89, 'eligendi');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (90, 'eos');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (91, 'est');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (92, 'et');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (93, 'exercitationem');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (94, 'expedita');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (95, 'in');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (96, 'incidunt');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (97, 'inventore');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (98, 'itaque');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (99, 'iusto');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (100, 'laboriosam');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (101, 'necessitatibus');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (102, 'nemo');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (103, 'nesciunt');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (104, 'numquam');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (105, 'officia');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (106, 'provident');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (107, 'quaerat');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (108, 'quis');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (109, 'quo');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (110, 'repellendus');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (111, 'reprehenderit');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (112, 'sapiente');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (113, 'sed');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (114, 'similique');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (115, 'sit');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (116, 'temporibus');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (117, 'ut');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (118, 'voluptas');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (119, 'voluptatem');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (120, 'voluptatum');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (121, 'accusantium');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (122, 'aliquam');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (123, 'amet');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (124, 'animi');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (125, 'aut');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (126, 'consectetur');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (127, 'dolor');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (128, 'doloremque');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (129, 'eligendi');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (130, 'eos');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (131, 'est');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (132, 'et');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (133, 'exercitationem');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (134, 'expedita');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (135, 'in');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (136, 'incidunt');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (137, 'inventore');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (138, 'itaque');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (139, 'iusto');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (140, 'laboriosam');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (141, 'necessitatibus');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (142, 'nemo');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (143, 'nesciunt');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (144, 'numquam');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (145, 'officia');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (146, 'provident');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (147, 'quaerat');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (148, 'quis');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (149, 'quo');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (150, 'repellendus');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (151, 'reprehenderit');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (152, 'sapiente');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (153, 'sed');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (154, 'similique');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (155, 'sit');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (156, 'temporibus');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (157, 'ut');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (158, 'voluptas');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (159, 'voluptatem');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (160, 'voluptatum');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (161, 'accusantium');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (162, 'aliquam');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (163, 'amet');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (164, 'animi');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (165, 'aut');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (166, 'consectetur');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (167, 'dolor');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (168, 'doloremque');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (169, 'eligendi');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (170, 'eos');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (171, 'est');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (172, 'et');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (173, 'exercitationem');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (174, 'expedita');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (175, 'in');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (176, 'incidunt');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (177, 'inventore');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (178, 'itaque');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (179, 'iusto');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (180, 'laboriosam');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (181, 'necessitatibus');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (182, 'nemo');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (183, 'nesciunt');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (184, 'numquam');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (185, 'officia');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (186, 'provident');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (187, 'quaerat');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (188, 'quis');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (189, 'quo');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (190, 'repellendus');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (191, 'reprehenderit');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (192, 'sapiente');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (193, 'sed');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (194, 'similique');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (195, 'sit');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (196, 'temporibus');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (197, 'ut');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (198, 'voluptas');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (199, 'voluptatem');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (200, 'voluptatum');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (201, 'accusantium');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (202, 'aliquam');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (203, 'amet');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (204, 'animi');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (205, 'aut');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (206, 'consectetur');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (207, 'dolor');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (208, 'doloremque');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (209, 'eligendi');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (210, 'eos');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (211, 'est');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (212, 'et');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (213, 'exercitationem');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (214, 'expedita');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (215, 'in');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (216, 'incidunt');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (217, 'inventore');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (218, 'itaque');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (219, 'iusto');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (220, 'laboriosam');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (221, 'necessitatibus');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (222, 'nemo');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (223, 'nesciunt');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (224, 'numquam');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (225, 'officia');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (226, 'provident');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (227, 'quaerat');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (228, 'quis');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (229, 'quo');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (230, 'repellendus');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (231, 'reprehenderit');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (232, 'sapiente');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (233, 'sed');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (234, 'similique');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (235, 'sit');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (236, 'temporibus');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (237, 'ut');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (238, 'voluptas');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (239, 'voluptatem');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (240, 'voluptatum');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (241, 'accusantium');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (242, 'aliquam');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (243, 'amet');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (244, 'animi');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (245, 'aut');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (246, 'consectetur');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (247, 'dolor');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (248, 'doloremque');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (249, 'eligendi');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (250, 'eos');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (251, 'est');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (252, 'et');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (253, 'exercitationem');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (254, 'expedita');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (255, 'in');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (256, 'incidunt');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (257, 'inventore');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (258, 'itaque');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (259, 'iusto');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (260, 'laboriosam');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (261, 'necessitatibus');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (262, 'nemo');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (263, 'nesciunt');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (264, 'numquam');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (265, 'officia');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (266, 'provident');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (267, 'quaerat');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (268, 'quis');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (269, 'quo');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (270, 'repellendus');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (271, 'reprehenderit');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (272, 'sapiente');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (273, 'sed');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (274, 'similique');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (275, 'sit');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (276, 'temporibus');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (277, 'ut');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (278, 'voluptas');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (279, 'voluptatem');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (280, 'voluptatum');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (281, 'accusantium');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (282, 'aliquam');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (283, 'amet');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (284, 'animi');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (285, 'aut');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (286, 'consectetur');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (287, 'dolor');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (288, 'doloremque');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (289, 'eligendi');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (290, 'eos');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (291, 'est');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (292, 'et');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (293, 'exercitationem');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (294, 'expedita');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (295, 'in');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (296, 'incidunt');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (297, 'inventore');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (298, 'itaque');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (299, 'iusto');
INSERT INTO `misc_note_labels` (`note_id`, `label`) VALUES (300, 'laboriosam');




