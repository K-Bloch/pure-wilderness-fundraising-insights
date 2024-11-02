# Pure Wilderness Fundraising Efforts Analysis

## Data Sources & Tools
- **Data**: Generated using my custom Python script (code in repository)
- **SQL tool**: MySQL Workbench 8.0 CE
- **Analytics and Visualization tool**: Power BI

## Project Background
Pure Wilderness is a wildlife conservation non-profit founded in 2020. Initially, the organization achieved significant success in attracting donors and relied on this initial pool for several years. However, by 2024, with donor numbers stagnating and new acquisitions limited, they are now seeking insights into donor retention, most effective acquisition channels, and potential opportunities for growth.

### Challenges:
- Extracting actionable insights from 5 years of data that significantly varies in quantity and shows a downward trend.

## Project Strategy
All individuals or entities that donated to the organization are referred to as 'donors'.

<details>
  <summary>Data Dictionary</summary>

- **donor_id**: Unique ID  
- **donor_type**: Individual or Organization  
- **donation_dates**: Comma-separated donation dates  
- **donation_amounts**: Comma-separated donation amounts  
- **acquisition channel**: Source channel (Direct Mail, Online Event, etc.)  
- **age, gender, location**: Donor demographics  
</details>

### Main Steps (Technical)

1. **Data Modeling (SQL)**:
   - Normalized data across the *donors*, *don_details*, and *acquisition* tables.
   - Calculated metrics for cross-checking in Power BI.

2. **Power BI Analysis**:
   - Constructed the DonorSummary table, including metrics such as *First Donation*, *Last Donation*, *Donor Lifespan*, and *Donor Status*.
   - Developed additional metrics to make building visuals easier.

<details>
  <summary>SQL Steps</summary>
  
1. Created the *donors* table, initially importing fields as VARCHAR (except donor_id).  
2. Created *don_details* table, separating donation_dates and donation_amounts into individual records. Used `CASE` statements to standardize date formats after Excel import issues caused format inconsistencies (single vs. multiple dates).
3. Dropped columns with donation info from the *donors* table after data separation and renamed tables for clarity.
4. Calculated retention rate to cross-check with Power BI.
5. Created *acquisition* table to summarize donor counts by acquisition channel, calculating percentage changes year over year.
6. Added year-over-year donor count change calculation for comparison with Power BI metrics.
</details>

<details>
  <summary>Power BI Steps</summary>

1. Imported cleaned SQL data, creating *DonorSummary* to track each donor's first and last donations, count of donations, and acquisition channel.
2. Added *Donor Status* (Active or Churned) based on the last donation date. A donor is marked “Churned” if they haven’t donated within the last 365 days.
   ```DAX
   Donor_Status = IF(ROUND(DATEDIFF(DonorSummary[Last_Donation], DATE(2024,12,31), DAY),0) > 365, "Churned", "Active")
