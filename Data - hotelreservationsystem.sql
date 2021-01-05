-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 01, 2021 at 05:47 PM
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
-- Dumping data for table `hotel`
--

INSERT INTO `hotel` (`id`, `name`, `stars`, `distanceFromCC`, `includingMeals`, `cityID`, `latitude`, `longitude`) VALUES
(1, 'Ramses Hilton Hotel & Casino', 4, 2, 'Yes', 1, 30.070380, 31.270900),
(2, 'Grand Nile Tower', 5, 4, 'No', 1, 30.043490, 31.235290),
(3, 'Four Seasons Resort Sharm El Sheikh', 5, 10, 'Yes', 2, 28.082800, 33.739960),
(4, 'Marriott Sharm El Sheikh', 4, 10, 'Yes', 2, 27.915830, 34.326240),
(5, 'Mandarin Oriental Jumeira', 5, 10, 'Yes', 3, 25.216853, 55.251885),
(6, 'Gevora Hotel', 3, 10, 'Yes', 3, 25.212349, 55.277158),
(7, 'Hyatt Regency Paris Etoile', 4, 10, 'Yes', 4, 48.987840, 2.513320),
(8, 'Hôtel Gramont', 5, 10, 'Yes', 4, 49.018650, -1.300000),
(9, 'Raffles Makkah Palace', 4, 10, 'Yes', 9, 21.418930, 39.824951),
(10, 'Hilton Suites Makkah', 3, 10, 'Yes', 9, 21.421431, 39.821663);

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `email`, `username`, `password`) VALUES
(1, 'Mohamed Ahmed Abdelnabey', 'engr2017@gmail.com', 'MOHAMED123', 'bP$7f@oZcY'),
(2, 'Kareem Ahmed Eltemsah', 'temsah@gmail.com', 'K-Temsah11', '100100'),
(3, 'Yousef Osama Sayed', 'y.osama@gamil.com', 'Yousef Elkady', '666666');

--
-- Dumping data for table `reservation`
--

INSERT INTO `reservation` (`id`, `userID`, `hotelID`, `startDate`, `endDate`, `ts_createdAt`, `isPaid`, `checkInDate`, `checkOutDate`) VALUES
(1, 1, 1, '2020-11-01', '2020-11-05', '2020-12-30 13:56:35', 'No', '2021-01-03', NULL),
(2, 1, 2, '2020-12-31', '2021-01-01', '2020-12-30 13:56:35', 'No', NULL, NULL),
(4, 1, 1, '2020-12-31', '2021-01-01', '2021-01-01 13:29:42', 'No', NULL, NULL),
(5, 3, 1, '2022-01-01', '2022-01-07', '2021-01-01 13:29:42', 'Yes', NULL, NULL),
(7, 2, 1, '2021-06-01', '2021-06-08', '2021-01-01 13:29:42', 'No', NULL, NULL);

--
-- Dumping data for table `review`
--

INSERT INTO `review` (`id`, `userID`, `hotelID`, `comment`, `rate`) VALUES
(1, 1, 1, 'Nice hotel. I really enjoyed my accommodation there. They have great services and comfortable rooms', 4),
(2, 2, 1, 'I hope I stay here once again in my next visit to Egypt', 3),
(3, 3, 2, 'Nice hotel. It has a pretty view on the Nile. They have great services and comfortable rooms', 5),
(4, 2, 2, 'My favourite hotel in Cairo', 3);

--
-- Dumping data for table `roomtype`
--

INSERT INTO `roomtype` (`id`, `name`) VALUES
(1, 'Adults'),
(2, 'Children');

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`name`, `hotelID`, `roomTypeID`, `price`, `facilities`) VALUES
('A1', 1, 1, '200', 'beds, closet, television, refrigerator, air conditioner'),
('A2', 1, 1, '220', 'beds, closet, television, refrigerator, air conditioner, jacuzzi'),
('A3', 1, 1, '200', 'beds, closet, television, refrigerator, air conditioner'),
('B1', 1, 2, '200', 'beds, closet, television, refrigerator, air conditioner'),
('B2', 1, 2, '200', 'beds, closet, television, refrigerator, air conditioner'),

('A1', 2, 1, '100', 'beds, closet, television, refrigerator, air conditioner'),
('A2', 2, 1, '200', 'beds, closet, television, refrigerator, air conditioner'),
('A3', 2, 1, '300', 'beds, closet, television, refrigerator, air conditioner, jacuzzi'),
('B1', 2, 2, '200', 'beds, closet, television, refrigerator, air conditioner'),
('B2', 2, 2, '200', 'beds, closet, television, refrigerator, air conditioner'),

('A1', 3, 1, '200', 'beds, closet, television, refrigerator, air conditioner'),
('A2', 3, 1, '200', 'beds, closet, television, refrigerator, air conditioner'),
('A3', 3, 1, '200', 'beds, closet, television, refrigerator, air conditioner'),
('A4', 3, 1, '200', 'beds, closet, television, refrigerator, air conditioner'),
('A5', 3, 1, '200', 'beds, closet, television, refrigerator, air conditioner'),

('A1', 4, 1, '200', 'beds, closet, television, refrigerator, air conditioner'),
('A2', 4, 1, '200', 'beds, closet, television, refrigerator, air conditioner'),
('A3', 4, 1, '200', 'beds, closet, television, refrigerator, air conditioner'),
('B1', 4, 2, '200', 'beds, closet, television, refrigerator, air conditioner'),
('B2', 4, 2, '200', 'beds, closet, television, refrigerator, air conditioner'),

('A1', 5, 1, '200', 'beds, closet, television, refrigerator, air conditioner'),
('A2', 5, 1, '200', 'beds, closet, television, refrigerator, air conditioner'),
('B1', 5, 2, '200', 'beds, closet, television, refrigerator, air conditioner'),
('B2', 5, 2, '200', 'beds, closet, television, refrigerator, air conditioner'),
('B3', 5, 2, '200', 'beds, closet, television, refrigerator, air conditioner'),

('A1', 6, 1, '390', 'beds, closet, television, refrigerator, air conditioner'),
('A2', 6, 1, '400', 'beds, closet, television, refrigerator, air conditioner'),
('A3', 6, 1, '420', 'beds, closet, television, refrigerator, air conditioner, jacuzzi'),
('A4', 6, 1, '360', 'beds, closet, television, refrigerator, air conditioner'),
('B1', 6, 2, '340', 'beds, closet, television, refrigerator, air conditioner'),

('A1', 7, 1, '300', 'beds, closet, television, refrigerator, air conditioner'),
('A2', 7, 1, '310', 'beds, closet, television, refrigerator, air conditioner'),
('A3', 7, 1, '320', 'beds, closet, television, refrigerator, air conditioner'),
('B1', 7, 2, '250', 'beds, closet, television, refrigerator, air conditioner'),
('B2', 7, 2, '260', 'beds, closet, television, refrigerator, air conditioner'),

('A1', 8, 1, '290', 'beds, closet, television, refrigerator, air conditioner'),
('A2', 8, 1, '290', 'beds, closet, television, refrigerator, air conditioner'),
('A3', 8, 1, '340', 'beds, closet, television, refrigerator, air conditioner'),
('B1', 8, 2, '230', 'beds, closet, television, refrigerator, air conditioner'),
('B2', 8, 2, '245', 'beds, closet, television, refrigerator, air conditioner'),

('A1', 9, 1, '450', 'beds, closet, television, refrigerator, air conditioner, jacuzzi'),
('A2', 9, 1, '450', 'beds, closet, television, refrigerator, air conditioner, jacuzzi'),
('A3', 9, 1, '350', 'beds, closet, television, refrigerator, air conditioner'),
('B1', 9, 2, '300', 'beds, closet, television, refrigerator, air conditioner'),
('B2', 9, 2, '280', 'beds, closet, television, refrigerator, air conditioner'),

('A1', 10, 1, '350', 'beds, closet, television, refrigerator, air conditioner, jacuzzi'),
('A2', 10, 1, '325', 'beds, closet, television, refrigerator, air conditioner'),
('A3', 10, 1, '300', 'beds, closet, television, refrigerator, air conditioner'),
('B1', 10, 2, '250', 'beds, closet, television, refrigerator, air conditioner'),
('B2', 10, 2, '270', 'beds, closet, television, refrigerator, air conditioner');
--
-- Dumping data for table `roomreservation`
--

INSERT INTO `roomreservation` (`id`, `reservationID`, `roomID`) VALUES
(1, 1, 7),
(2, 2, 12),
(5, 2, 8);


COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
