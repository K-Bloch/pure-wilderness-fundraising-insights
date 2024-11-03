# 2023 donor count
# result: 3259
SELECT COUNT(DISTINCT donor_id)
FROM fundraising_v2.donations
WHERE YEAR(donation_date) = 2023;
	
# count of 2024 donors, who also donated in 2023
# result: 2235

SELECT COUNT(DISTINCT donor_id)
FROM fundraising_v2.donations
WHERE 
	YEAR(donation_date) = 2024
    AND donor_id IN (
		SELECT DISTINCT donor_id
		FROM fundraising_v2.donations
		WHERE YEAR(donation_date) = 2023);

# retention rate:
# (2235 / 3259) * 100 = 68.5793188095%
