-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 11, 2021 at 06:18 PM
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

INSERT INTO `hotel` (`id`, `name`, `stars`, `distanceFromCC`, `includingMeals`, `cityID`, `latitude`, `longitude`, `contacts`) VALUES
(1, 'Ramses Hilton Hotel & Casino', 4, 2, 'Yes', 1, 30.07038, 31.2709, NULL),
(2, 'Grand Nile Tower', 5, 4, 'No', 1, 30.04349, 31.23529, NULL),
(3, 'Four Seasons Resort Sharm El Sheikh', 5, 10, 'Yes', 2, 28.0828, 33.73996, NULL),
(4, 'Marriott Sharm El Sheikh', 4, 10, 'Yes', 2, 27.91583, 34.32624, NULL),
(5, 'Mandarin Oriental Jumeira', 5, 10, 'Yes', 3, 25.216853, 55.251885, NULL),
(6, 'Gevora Hotel', 3, 10, 'Yes', 3, 25.212349, 55.277158, NULL),
(7, 'Hyatt Regency Paris Etoile', 4, 10, 'Yes', 4, 48.98784, 2.51332, NULL),
(8, 'Hôtel Gramont', 5, 10, 'Yes', 4, 49.01865, -1.3, NULL),
(9, 'Raffles Makkah Palace', 4, 10, 'Yes', 9, 21.41893, 39.824951, NULL),
(10, 'Hilton Suites Makkah', 3, 10, 'Yes', 9, 21.421431, 39.821663, NULL);

--
-- Dumping data for table `hoteladmin`
--

INSERT INTO `hoteladmin` (`id`, `adminID`, `hotelID`) VALUES
(1, 4, 1),
(2, 4, 3);

--
-- Dumping data for table `notification`
--

INSERT INTO `notification` (`id`, `content`, `hotelID`, `isRead`, `createdAt`) VALUES
(3, 'Welcome to Residencia, our dear hotel admin', 1, 0, '2021-01-07 21:15:56'),
(11, 'Reservation with id = 8 at hotel \'Ramses Hilton Hotel & Casino\' , and start date = 2021-03-09 and end date = 2021-04-12 , has been cancelled by client whose name is Mohamed Ahmed Abdelnabey', 1, 0, '2021-01-11 16:56:52');

--
-- Dumping data for table `reservation`
--

INSERT INTO `reservation` (`id`, `userID`, `hotelID`, `startDate`, `endDate`, `ts_createdAt`, `isPaid`, `checkInDate`, `checkOutDate`) VALUES
(1, 1, 1, '2020-11-01', '2020-11-05', '2020-12-30 13:56:35', 'No', '2021-01-03', NULL),
(2, 1, 2, '2020-12-31', '2021-01-01', '2020-12-30 13:56:35', 'No', NULL, NULL),
(4, 1, 1, '2020-12-31', '2021-01-01', '2021-01-01 13:29:42', 'No', NULL, NULL),
(5, 3, 1, '2022-01-01', '2022-01-07', '2021-01-01 13:29:42', 'Yes', NULL, NULL),
(7, 2, 1, '2021-06-01', '2021-06-08', '2021-01-01 13:29:42', 'No', NULL, NULL),
(9, 1, 1, '2021-02-09', '2021-02-12', '2021-01-11 12:21:38', 'No', NULL, NULL);

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

INSERT INTO `room` (`id`, `name`, `hotelID`, `roomTypeID`, `price`, `facilities`) VALUES
(1, 'A1', 1, 1, '200', 'beds, closet, television, refrigerator, air conditioner'),
(2, 'A2', 1, 1, '220', 'beds, closet, television, refrigerator, air conditioner, jacuzzi'),
(3, 'A3', 1, 1, '200', 'beds, closet, television, refrigerator, air conditioner'),
(4, 'B1', 1, 2, '200', 'beds, closet, television, refrigerator, air conditioner'),
(5, 'B2', 1, 2, '200', 'beds, closet, television, refrigerator, air conditioner'),
(6, 'A1', 2, 1, '100', 'beds, closet, television, refrigerator, air conditioner'),
(7, 'A2', 2, 1, '200', 'beds, closet, television, refrigerator, air conditioner'),
(8, 'A3', 2, 1, '300', 'beds, closet, television, refrigerator, air conditioner, jacuzzi'),
(9, 'B1', 2, 2, '200', 'beds, closet, television, refrigerator, air conditioner'),
(10, 'B2', 2, 2, '200', 'beds, closet, television, refrigerator, air conditioner'),
(11, 'A1', 3, 1, '200', 'beds, closet, television, refrigerator, air conditioner'),
(12, 'A2', 3, 1, '200', 'beds, closet, television, refrigerator, air conditioner'),
(13, 'A3', 3, 1, '200', 'beds, closet, television, refrigerator, air conditioner'),
(14, 'A4', 3, 1, '200', 'beds, closet, television, refrigerator, air conditioner'),
(15, 'A5', 3, 1, '200', 'beds, closet, television, refrigerator, air conditioner'),
(16, 'A1', 4, 1, '200', 'beds, closet, television, refrigerator, air conditioner'),
(17, 'A2', 4, 1, '200', 'beds, closet, television, refrigerator, air conditioner'),
(18, 'A3', 4, 1, '200', 'beds, closet, television, refrigerator, air conditioner'),
(19, 'B1', 4, 2, '200', 'beds, closet, television, refrigerator, air conditioner'),
(20, 'B2', 4, 2, '200', 'beds, closet, television, refrigerator, air conditioner'),
(21, 'A1', 5, 1, '200', 'beds, closet, television, refrigerator, air conditioner'),
(22, 'A2', 5, 1, '200', 'beds, closet, television, refrigerator, air conditioner'),
(23, 'B1', 5, 2, '200', 'beds, closet, television, refrigerator, air conditioner'),
(24, 'B2', 5, 2, '200', 'beds, closet, television, refrigerator, air conditioner'),
(25, 'B3', 5, 2, '200', 'beds, closet, television, refrigerator, air conditioner'),
(26, 'A1', 6, 1, '390', 'beds, closet, television, refrigerator, air conditioner'),
(27, 'A2', 6, 1, '400', 'beds, closet, television, refrigerator, air conditioner'),
(28, 'A3', 6, 1, '420', 'beds, closet, television, refrigerator, air conditioner, jacuzzi'),
(29, 'A4', 6, 1, '360', 'beds, closet, television, refrigerator, air conditioner'),
(30, 'B1', 6, 2, '340', 'beds, closet, television, refrigerator, air conditioner'),
(31, 'A1', 7, 1, '300', 'beds, closet, television, refrigerator, air conditioner'),
(32, 'A2', 7, 1, '310', 'beds, closet, television, refrigerator, air conditioner'),
(33, 'A3', 7, 1, '320', 'beds, closet, television, refrigerator, air conditioner'),
(34, 'B1', 7, 2, '250', 'beds, closet, television, refrigerator, air conditioner'),
(35, 'B2', 7, 2, '260', 'beds, closet, television, refrigerator, air conditioner'),
(36, 'A1', 8, 1, '290', 'beds, closet, television, refrigerator, air conditioner'),
(37, 'A2', 8, 1, '290', 'beds, closet, television, refrigerator, air conditioner'),
(38, 'A3', 8, 1, '340', 'beds, closet, television, refrigerator, air conditioner'),
(39, 'B1', 8, 2, '230', 'beds, closet, television, refrigerator, air conditioner'),
(40, 'B2', 8, 2, '245', 'beds, closet, television, refrigerator, air conditioner'),
(41, 'A1', 9, 1, '450', 'beds, closet, television, refrigerator, air conditioner, jacuzzi'),
(42, 'A2', 9, 1, '450', 'beds, closet, television, refrigerator, air conditioner, jacuzzi'),
(43, 'A3', 9, 1, '350', 'beds, closet, television, refrigerator, air conditioner'),
(44, 'B1', 9, 2, '300', 'beds, closet, television, refrigerator, air conditioner'),
(45, 'B2', 9, 2, '280', 'beds, closet, television, refrigerator, air conditioner'),
(46, 'A1', 10, 1, '350', 'beds, closet, television, refrigerator, air conditioner, jacuzzi'),
(47, 'A2', 10, 1, '325', 'beds, closet, television, refrigerator, air conditioner'),
(48, 'A3', 10, 1, '300', 'beds, closet, television, refrigerator, air conditioner'),
(49, 'B1', 10, 2, '250', 'beds, closet, television, refrigerator, air conditioner'),
(50, 'B2', 10, 2, '270', 'beds, closet, television, refrigerator, air conditioner');

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

INSERT INTO `user` (`id`, `name`, `email`, `username`, `password`, `phoneNumber`, `isAdmin`) VALUES
(1, 'Mohamed Ahmed Abdelnabey', 'engr2017@gmail.com', 'MOHAMED123', 'bP$7f@oZcY', '+201001001234', 0),
(2, 'Kareem Ahmed Eltemsah', 'temsah@gmail.com', 'K-Temsah11', '100100', '+201101001234', 0),
(3, 'Yousef Osama Sayed', 'y.osama@gamil.com', 'Yousef Elkady', '666666', '+201201001234', 0),
(4, 'Amr Mohamed Abdelnabey', 'amrAbdo@gmail.com', 'AmrMohamed', '100100', '01511223030', 1);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
