-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jan 31, 2021 at 10:11 PM
-- Server version: 8.0.18
-- PHP Version: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `auto_skola`
--

DELIMITER $$
--
-- Functions
--
DROP FUNCTION IF EXISTS `emailKorisnika`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `emailKorisnika` (`fk_korisnik` INT(11)) RETURNS VARCHAR(200) CHARSET utf8 BEGIN
	DECLARE email_korisnika varchar(200);
		SELECT email INTO email_korisnika FROM korisnici WHERE id = fk_korisnik;
	RETURN email_korisnika;
END$$

DROP FUNCTION IF EXISTS `imeKorisnika`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `imeKorisnika` (`fk_korisnik` INT(11)) RETURNS VARCHAR(200) CHARSET utf8 BEGIN
	DECLARE imeKorisnika varchar(200);
		SELECT ime INTO imeKorisnika FROM korisnici WHERE id = fk_korisnik;
	RETURN imeKorisnika;
END$$

DROP FUNCTION IF EXISTS `jmbgKorisnika`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `jmbgKorisnika` (`fk_korisnik` INT(11)) RETURNS VARCHAR(200) CHARSET utf8 BEGIN
	DECLARE jmbg_korisnika varchar(200);
		SELECT jmbg INTO jmbg_korisnika FROM korisnici WHERE id = fk_korisnik;
	RETURN jmbg_korisnika;
END$$

DROP FUNCTION IF EXISTS `numberOfCorrectAnswer`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `numberOfCorrectAnswer` (`id_korisnik` INT(11)) RETURNS INT(200) BEGIN
	DECLARE numOfCorrects INT(200);
		SELECT COUNT(rezultat) as Correct INTO numOfCorrects FROM test_stats WHERE rezultat="Tačno" AND fk_korisnici=id_korisnik;
	RETURN numOfCorrects;
END$$

DROP FUNCTION IF EXISTS `numberOfWrongAnswer`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `numberOfWrongAnswer` (`id_korisnik` INT(11)) RETURNS INT(200) BEGIN
	DECLARE numOfWrongs INT(200);
		SELECT COUNT(rezultat) as Wrong INTO numOfWrongs FROM test_stats WHERE rezultat="Netačno" AND fk_korisnici=id_korisnik;
	RETURN numOfWrongs;
END$$

DROP FUNCTION IF EXISTS `prezimeKorisnika`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `prezimeKorisnika` (`fk_korisnik` INT(11)) RETURNS VARCHAR(200) CHARSET utf8 BEGIN
	DECLARE prezimeKorisnika varchar(200);
		SELECT prezime INTO prezimeKorisnika FROM korisnici WHERE id = fk_korisnik;
	RETURN prezimeKorisnika;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `b_pitanja`
--

DROP TABLE IF EXISTS `b_pitanja`;
CREATE TABLE IF NOT EXISTS `b_pitanja` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text_pitanja` varchar(1000) NOT NULL,
  `odgovor_jedan` varchar(600) DEFAULT NULL,
  `odgovor_dva` varchar(600) DEFAULT NULL,
  `odgovor_tri` varchar(600) DEFAULT NULL,
  `broj_pitanja` bigint(20) NOT NULL,
  `odgovor` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `text_pitanja` (`text_pitanja`),
  UNIQUE KEY `broj_pitanja` (`broj_pitanja`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `b_pitanja`
--

INSERT INTO `b_pitanja` (`id`, `text_pitanja`, `odgovor_jedan`, `odgovor_dva`, `odgovor_tri`, `broj_pitanja`, `odgovor`) VALUES
(1, 'Покретни делови моторног механизма су:', 'цилиндарски блок, цилиндарска глава, кућиште мотора', 'коленасто вратило, клип, клипњача, замајац', 'брегасто вратило, вентили, подизачи, опруге', 94, 'коленасто вратило, клип, клипњача, замајац'),
(2, 'Путања кретања клипа је:', 'криволинијска', 'праволонијска', 'кружна', 95, 'праволонијска'),
(3, 'Ход клипа је пут који клип пређе:', 'од ГМТ до ДМТ\r\n', 'од кућишта мотора до моторске главе', 'од коленастог вратила свећице', 96, 'од ГМТ до ДМТ'),
(4, 'Вентиле у разводном механизму покреће:\r\n', 'зупчаста пумпа', 'коленасто вратило\r\n', 'брегасто вратило', 97, 'брегасто вратило'),
(5, 'Графички приказ углова отварања и затварања усисног и издувног вентила је:\r\n', 'разводни механизам\r\n', 'кружни дијаграм\r\n', 'вентилски дијаграм', 98, 'кружни дијаграм'),
(6, 'Задатак индукционог калема је:\r\n', 'да индукује примарну струју\r\n', 'да индукује наизменичну струју\r\n', 'да индукује секундарну струју', 99, 'да индукује секундарну струју'),
(7, 'Разводник паљења има задатак да:', 'разводи гориво за паљење\r\n', 'разводи струју високог напона', 'разводи струју ниског напона', 100, 'разводи струју високог напона'),
(8, 'Спојница може бити:\r\n', 'фрикциона, хидраулична, електромагнетна', 'по избору возача', 'спортска, за тешке терене или комбиновано', 101, 'фрикциона, хидраулична, електромагнетна'),
(9, 'Шасија моторног возила је састављена од:', 'попречних носача', 'уздужних носача\r\n', 'попречних и уздужних носача', 102, 'попречних и уздужних носача'),
(10, 'Ламела је део:\r\n', 'хидрауличне спојнице\r\n', 'фрикционе спојнице', 'не припада ни једној спојници', 103, 'фрикционе спојнице'),
(11, 'Хидраулична спојница ради на принципу:', 'трења', 'искоришћавања кинетичке енергије течности', 'искоришћавања потенцијалне енергије гаса', 104, 'искоришћавања кинетичке енергије течности'),
(12, 'Вариоматик је:', 'зупчасти преносник', 'варијабилно отварање вентила', 'континуални мењачки преносник', 105, 'континуални мењачки преносник'),
(13, 'Задатак мењача је да:', 'покрене замајац мотора', 'омогуђи промену Mo у зависности од услова експлоатације', 'промени редослед радних тактова у четворотактном мотору', 106, 'омогуђи промену Mo у зависности од услова експлоатације'),
(14, 'Када је укључена блокада диференцијала за теретна возила:', 'точкови исте осовине имају различити број обртаја', 'точкови исте осовине се не окрећу', 'точкови исте осовине имају исти број обртаја', 107, 'точкови исте осовине имају исти број обртаја'),
(15, 'Слободан ход управљачког точка износи:', '± 30°', '± 25°', '± 15°', 108, '± 30°');

-- --------------------------------------------------------

--
-- Table structure for table `korisnici`
--

DROP TABLE IF EXISTS `korisnici`;
CREATE TABLE IF NOT EXISTS `korisnici` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ime` varchar(200) NOT NULL,
  `prezime` varchar(200) NOT NULL,
  `broj_telefona` varchar(200) NOT NULL,
  `datum_rodjenja` varchar(200) NOT NULL,
  `jmbg` varchar(13) NOT NULL,
  `email` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sifra` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `jmbg` (`jmbg`),
  UNIQUE KEY `e-mail` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `korisnici`
--

INSERT INTO `korisnici` (`id`, `ime`, `prezime`, `broj_telefona`, `datum_rodjenja`, `jmbg`, `email`, `sifra`) VALUES
(1, 'Mika', 'Mikic', '123123123', '02.12.1998.', '0212998732514', 'mika@gmail.com', '123123'),
(11, 'Aleksa', 'Nejković', '0600326267', '27.06.1998.', '2706998712411', 'admin@gmail.com', '1245');

-- --------------------------------------------------------

--
-- Table structure for table `test_stats`
--

DROP TABLE IF EXISTS `test_stats`;
CREATE TABLE IF NOT EXISTS `test_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_pitanja` int(11) NOT NULL,
  `rezultat` varchar(200) NOT NULL,
  `fk_korisnici` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pitanja` (`fk_pitanja`),
  KEY `fk_korisnici` (`fk_korisnici`)
) ENGINE=InnoDB AUTO_INCREMENT=382 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `test_stats`
--

INSERT INTO `test_stats` (`id`, `fk_pitanja`, `rezultat`, `fk_korisnici`) VALUES
(377, 11, 'Netačno', 11),
(378, 15, 'Tačno', 11),
(379, 6, 'Netačno', 11),
(380, 1, 'Netačno', 11),
(381, 10, 'Netačno', 11);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `test_stats`
--
ALTER TABLE `test_stats`
  ADD CONSTRAINT `fk_korisnici` FOREIGN KEY (`fk_korisnici`) REFERENCES `korisnici` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pitanja` FOREIGN KEY (`fk_pitanja`) REFERENCES `b_pitanja` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
