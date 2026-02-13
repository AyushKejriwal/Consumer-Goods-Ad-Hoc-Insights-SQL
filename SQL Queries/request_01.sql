/*1. Provide the list of markets in which customer "Atliq  Exclusive" 
	 operates its business in the APAC region.*/

SELECT
	DISTINCT market
FROM gdb023.dim_customer dm
WHERE dm.customer = "Atliq Exclusive" AND dm.region = "APAC";
