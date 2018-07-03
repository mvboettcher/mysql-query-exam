/*
1) Select a distinct list of ordered airports codes.
*/

SELECT DISTINCT departAirport AS 'Airports' FROM flight;

/*
2) Provide a list of flights with a delayed status that depart from San Francisco (SFO).
*/

SELECT airline.name, flightNumber, scheduledDepartDateTime, arriveAirport, status FROM flight JOIN airline ON airline.ID = flight.airlineID WHERE departAirport = 'SFO' AND status = 'delayed';

/*
3) Provide a distinct list of cities that American Airlines departs from.
*/

SELECT DISTINCT departAirport AS 'Cities' FROM flight JOIN airline ON airline.ID = flight.airlineID WHERE airline.name = 'American' ORDER BY departAirport;

/*
4) Provide a distinct list of airlines that conducts flights departing from ATL.
*/

SELECT DISTINCT airline.name AS 'Airline' FROM airline JOIN flight ON flight.airlineID = airline.ID WHERE departAirport = 'ATL';

/*
5) Provide a list of airlines, flight numbers, departing airports, and arrival airports where flights departed on time.
*/

SELECT airline.name, flightNumber, departAirport, arriveAirport FROM flight JOIN airline ON airline.ID = flight.airlineID WHERE TIMEDIFF(scheduledDepartDateTime, actualDepartDateTime) = 0;

/*
6) Provide a list of airlines, flight numbers, gates, status, and arrival times arriving into Charlotte (CLT) on 10-30-2017. Order your results by the arrival time.
*/

SELECT airline.name AS 'Airline', flightNumber AS 'Flight', flight.Gate, TIME(scheduledArriveDateTime) AS 'Arrival', flight.Status FROM airline JOIN flight ON airline.ID = flight.airlineID WHERE DATE(scheduledArriveDateTime) = '2017-10-30' AND arriveAirport = 'CLT';

/*
7) List the number of reservations by flight number. Order by reservations in descending order.
*/

SELECT flightNumber AS 'flight', COUNT(reservation.ID) AS 'reservations' FROM reservation JOIN flight ON flight.ID = reservation.flightID GROUP BY flightNumber ORDER BY COUNT(reservation.ID) DESC;

/*
8) List the average ticket cost for coach by airline and route. Order by AverageCost in descending order.
*/

SELECT airline.name AS 'airline', departAirport, arriveAirport, AVG(cost) AS 'AverageCost' FROM airline JOIN flight ON airline.ID = flight.airlineID JOIN reservation ON flight.ID = reservation.flightID WHERE class = 'coach' GROUP BY flight.ID ORDER BY AVG(cost) DESC;

/*
9) Which route is the longest?
*/

SELECT departAirport, arriveAirport, miles FROM flight ORDER BY miles DESC LIMIT 1;

/*
10) List the top 5 passengers that have flown the most miles. Order by miles.
*/

SELECT firstName, lastName, SUM(miles) AS 'miles' FROM passenger JOIN reservation ON passenger.ID = reservation.passengerID JOIN flight ON flight.ID = reservation.flightID GROUP BY lastName ORDER BY SUM(miles) DESC LIMIT 5;

/*
11) Provide a list of American airline flights ordered by route and arrival date and time.
*/

SELECT airline.Name, CONCAT(departAirport,' --> ',arriveAirport) AS 'Route', DATE(scheduledArriveDateTime) AS 'Arrive Date', TIME(scheduledArriveDateTime) AS 'Arrive Time' FROM airline JOIN flight ON flight.airlineID = airline.ID WHERE airline.name = 'American' ORDER BY departAirport;

/*
12) Provide a report that counts the number of reservations and totals the reservation costs (as Revenue) by Airline, flight, and route. Order the report by total revenue in descending order.
*/

SELECT airline.name AS 'Airline', flightNumber AS 'Flight', CONCAT(departAirport,' --> ',arriveAirport) AS 'Route', COUNT(reservation.ID) AS 'Reservation Count', SUM(cost) AS 'Revenue' FROM airline JOIN flight ON airline.ID = flight.airlineID JOIN reservation ON flight.ID = reservation.flightID GROUP BY Flight ORDER BY Revenue DESC;


/*
13) List the average cost per reservation by route. Round results down to the dollar.
*/

SELECT CONCAT(departAirport,' --> ',arriveAirport) AS 'Route', TRUNCATE(AVG(cost),0) AS 'Avg Revenue' FROM flight JOIN reservation ON flight.ID = reservation.flightID GROUP BY Route ORDER BY TRUNCATE(AVG(cost),0) DESC;

/*
14) List the average miles per flight by airline.
*/

SELECT airline.name AS 'Airline', AVG(miles) AS 'Avg Miles Per Flight' FROM airline JOIN flight ON airline.ID = flight.airlineID GROUP BY Airline;

/*
15) Which airlines had flights that arrived early?
*/

SELECT DISTINCT airline.name AS 'Airline' FROM airline JOIN flight ON airline.ID = flight.airlineID WHERE TIMEDIFF(scheduledArriveDateTime, actualArriveDateTime) > 0;
