-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 30, 2020 at 07:31 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hotelreservationsystem`
--

--
-- Dumping data for table `city`
--

INSERT INTO `city` (`id`, `name`, `countryID`) VALUES
(1, 'Cairo', 1),
(2, 'Sharm Al-Sheikh', 1),
(3, 'Dubai', 5),
(4, 'Paris', 2),
(5, 'Munich', 10),
(6, 'Mumbai', 7),
(7, 'Moscow', 9),
(8, 'Jeddah', 6),
(9, 'Mecca', 6),
(10, 'Switzerland', 4);

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`id`, `name`) VALUES
(5, 'Arabian United Emirates'),
(1, 'Egypt'),
(2, 'France'),
(10, 'Germany'),
(7, 'India'),
(9, 'Russia'),
(6, 'Saudi Arabia'),
(4, 'Switzerland'),
(8, 'Thailand'),
(3, 'USA');

--
-- Dumping data for table `hotel`
--

INSERT INTO `hotel` (`id`, `name`, `cityID`) VALUES
(1, 'Ramses Hilton Hotel & Casino', 1),
(2, 'Grand Nile Tower', 1),
(3, 'Hotel 3', 2),
(4, 'Hotel 4', 2),
(5, 'Hotel 5', 3),
(6, 'Hotel 6', 3),
(7, 'Hotel 7', 4),
(8, 'Hotel 8', 4),
(9, 'Hotel 9', 1),
(10, 'Hotel 10', 2);

--
-- Dumping data for table `reservation`
--

INSERT INTO `reservation` (`id`, `userID`, `startDate`, `endDate`, `ts_createdAt`) VALUES
(1, 1, '2020-11-01', '2020-11-05', '2020-12-30 13:56:35'),
(2, 1, '2020-12-31', '2021-01-01', '2020-12-30 13:56:35');

--
-- Dumping data for table `review`
--

INSERT INTO `review` (`id`, `userID`, `hotelID`, `comment`, `rate`) VALUES
(1, 1, 1, 'Nice hotel. I really enjoyed my accommodation there. They have great services and comfortable rooms', 4),
(2, 2, 1, 'I hope I stay here once again in my next visit to Egypt', 3),
(3, 3, 2, 'Nice hotel. It has a pretty view on the Nile. They have great services and comfortable rooms', 5),
(4, 2, 2, 'My favourite hotel in Cairo', 3);

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`id`, `name`, `hotelID`, `roomTypeID`, `price`) VALUES
(7, 'A1', 1, 1, '200'),
(8, 'A2', 1, 1, '220'),
(9, 'A3', 1, 1, '200'),
(10, 'B1', 1, 2, '200'),
(11, 'B2', 1, 2, '200'),
(12, 'A1', 2, 1, '100'),
(13, 'A2', 2, 1, '200'),
(14, 'A3', 2, 1, '300'),
(15, 'B1', 2, 2, '200'),
(16, 'B2', 2, 2, '200'),
(17, 'A1', 3, 1, '200'),
(18, 'A2', 3, 1, '200'),
(19, 'A3', 3, 1, '200'),
(20, 'A4', 3, 1, '200'),
(21, 'A5', 3, 1, '200');

--
-- Dumping data for table `roomreservation`
--

INSERT INTO `roomreservation` (`id`, `reservationID`, `roomID`) VALUES
(1, 1, 7),
(2, 2, 12),
(5, 2, 8);

--
-- Dumping data for table `roomtype`
--

INSERT INTO `roomtype` (`id`, `name`) VALUES
(1, 'Adults'),
(2, 'Children');

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `email`, `username`, `password`) VALUES
(1, 'Mohamed Ahmed Abdelnabey', 'engr2017@gmail.com', 'MOHAMED123', 'bP$7f@oZcY'),
(2, 'Kareem Ahmed Eltemsah', 'temsah@gmail.com', 'K-Temsah11', '100100'),
(3, 'Yousef Osama Sayed', 'y.osama@gamil.com', 'Yousef Elkady', '666666');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
