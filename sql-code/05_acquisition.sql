CREATE TABLE acquisition AS

WITH cte AS (
	SELECT 
		COUNT(donations.donor_id) AS donor_count
        ,donors.acquisition_channel AS acquisition_channel
		,YEAR(donations.donation_date) AS year
	FROM fundraising_v2.donations
    LEFT JOIN fundraising_v2.donors
    ON donations.donor_id = donors.donor_id
    WHERE donations.donation_number = 1
    GROUP BY acquisition_channel, year
    ORDER BY acquisition_channel, year ASC
)

# SELECT * FROM cte;

SELECT 
    cte.year,
    cte.acquisition_channel,
    donor_count,
    CASE WHEN 
        (cte.year = 2020)
        THEN 0 
        ELSE ((donor_count - LAG(donor_count, 1) OVER (ORDER BY acquisition_channel, year ASC)) / LAG(donor_count, 1) OVER (ORDER BY acquisition_channel, year ASC)) * 100 
    END AS perc_diff
FROM cte
ORDER BY cte.acquisition_channel, cte.year ASC;

    
SELECT *
FROM acquisition;

DROP TABLE fundraising_v2.acquisition;
    
/*  MySQL Workbench setting that disables ONLY_FULL_GROUP_BY mode */
# SET sql_mode = ''
#SET sql_mode=only_full_group_by

