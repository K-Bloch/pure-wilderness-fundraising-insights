ALTER TABLE donors
DROP COLUMN donation_date,
DROP COLUMN donation_amount;

ALTER TABLE don_details RENAME TO donations;