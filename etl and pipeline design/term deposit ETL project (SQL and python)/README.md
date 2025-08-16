## 📘 Overview

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

### 1. Schema

```sql
CREATE TABLE customers (
    customer_id TEXT PRIMARY KEY,
    name TEXT,
    dob DATE,
    joined_date DATE,
    country TEXT,
    risk_profile TEXT CHECK (risk_profile IN ('low', 'medium', 'high'))
);

CREATE TABLE term_deposits (
    td_id TEXT PRIMARY KEY,
    customer_id TEXT REFERENCES customers(customer_id),
    product_type TEXT,
    start_date DATE,
    maturity_date DATE,
    principal NUMERIC,
    rate NUMERIC,
    status TEXT CHECK (status IN ('active', 'matured', 'withdrawn'))
);

CREATE TABLE interest_rates (
    product_type TEXT,
    rate NUMERIC,
    effective_date DATE
);
```

### 2. Import CSVs

Use your SQL client (e.g. DBeaver, pgAdmin, CLI) to import `CSV` files into the respective tables.

### 3. Transformations to Perform (in SQL)

1. Remove invalid deposits (e.g. cancelled, NULL fields).
2. Create fields:
   - `tenure_days`
   - `interest_due = principal * rate * (tenure_days / 365)`
   - `early_withdrawal` flag
   - `future_exposure` flag if maturity > '2024-07-01'
3. Join with `customers` table.
4. Flag customers with:
   - Risk = 'medium' or 'high'
   - AND total active deposits > $10,000

### Bonus Queries

- Top 5 customers by total interest due
- Number of early withdrawals per month
- Risk profile exposure to term deposits
- Total future interest exposure

---