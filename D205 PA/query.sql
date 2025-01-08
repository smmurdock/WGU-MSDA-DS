SELECT SUM(tech_support) AS total_technical_support,
	CASE WHEN age < 25 THEN 'Under 25'
		 WHEN age BETWEEN 25 AND 34 THEN '25-34'
		 WHEN age BETWEEN 35 AND 44 THEN '35-44'
		 WHEN age BETWEEN 45 AND 54 THEN '45-54'
		 WHEN age BETWEEN 55 AND 64 THEN '55-64'
		 WHEN age BETWEEN 65 AND 74 THEN '65-74'
	 	 ELSE 'Above 75'
	END AS age_range
FROM service
INNER JOIN customer
ON service.customer_id = customer.customer_id
GROUP BY age_range
ORDER BY total_technical_support DESC;