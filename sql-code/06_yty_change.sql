WITH yearly_donor_count AS (
    SELECT 
        year,
        SUM(donor_count) AS total_donor_count
    FROM fundraising_v2.acquisition
    GROUP BY year
)

SELECT 
    year,
    total_donor_count,
    CASE 
        WHEN LAG(total_donor_count) OVER (ORDER BY year) IS NULL THEN 0
        ELSE ((total_donor_count - LAG(total_donor_count) OVER (ORDER BY year)) / LAG(total_donor_count) OVER (ORDER BY year)) * 100 
    END AS yty_change
FROM yearly_donor_count
ORDER BY year;
