## 📘 Overview

You’re part of the Data Engineering team at a digital bank. The Product team is analysing customer behaviour around term deposits — fixed-savings products — to inform upcoming product tweaks and risk management decisions.

They’ve asked for a clean, joined dataset with enriched fields like tenure, early withdrawals, and projected interest exposure.

This project simulates a real-world data engineering task at a digital bank. You'll load, clean, transform, and enrich data related to term deposits, preparing it for business analysis and risk exposure reporting.

## 🎯 Objectives

- Practice **SQL joins, filters, and derived fields**
- Create an **ETL-ready data model** for financial products
- Understand **risk exposure** and **interest calculations**

## 📁 Files Included

- `customers.csv` – Customer profiles
- `term_deposits.csv` – Raw term deposit data
- `interest_rates.csv` – Reference rates for product types
- `README.md` – These instructions

--- 

### Datasets

#### customers.csv

| customer_id | name  | dob        | joined_date | country | risk_profile |
| ------------ | ----- | ---------- | ------------ | ------- | ------------- |
| C001         | Alice | 1985-04-05 | 2017-01-10   | NZ      | low           |
| C002         | Bob   | 1990-08-20 | 2018-09-12   | NZ      | medium        |

#### term_deposits.csv

| td\_id | customer\_id | product\_type | start\_date | maturity\_date | principal | rate | status    |
| ------ | ------------ | ------------- | ----------- | -------------- | --------- | ---- | --------- |
| TD001  | C001         | 6-month       | 2023-01-01  | 2023-07-01     | 10000     | 4.00 | matured   |
| TD002  | C002         | 1-year        | 2023-06-15  | 2024-06-15     | 5000      | 4.50 | active    |
| TD003  | C001         | 3-month       | 2024-01-01  | 2024-04-01     | 8000      | 3.50 | withdrawn |

#### interest_rates.csv

| product\_type | rate | effective\_date |
| ------------- | ---- | --------------- |
| 3-month       | 3.50 | 2023-12-01      |
| 6-month       | 4.00 | 2023-12-01      |
| 1-year        | 4.50 | 2023-12-01      |

---

## Task 

### Step 1: Load

- Ingest all CSVs into a relational database.
- Define schemas carefully (e.g. status as an enum, dates with proper types, money as decimals).

### Step 2: Transform

Write SQL to:

1. Clean & Filter:
    - Remove cancelled/incomplete deposits.
    - Flag any term deposits where maturity is after 1 July 2024 as future_exposure.

2. Derived columns:
    - `tenure_days` = difference between `start_date` and `maturity_date`
    - `interest_due` = `principal * rate * (tenure_days / 365)`
    - Flag as `early_withdrawal` if status = `withdrawn` and `maturity_date` > `current_date`

3. Join with Customers:
    - Enrich with age (based on dob) and risk_profile
    - Flag high-risk exposure if:
        - customer has risk_profile = 'medium' or 'high'
        - AND total active deposits > $10,000

### Step 3: Reporting Table

Create a final table/view `term_deposit_summary`:

| td_id | customer_id | age | tenure_days | principal | interest_due | early_withdrawal | future_exposure | risk_profile |
| ------ | ------------ | --- | ------------ | --------- | ------------- | ----------------- | ---------------- | ------------- |


## Bonus Queries

- Top 5 customers by total interest due
- Number of early withdrawals per month
- Risk profile exposure to term deposits
- Total future interest exposure

---