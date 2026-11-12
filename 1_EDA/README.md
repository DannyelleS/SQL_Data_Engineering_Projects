# Exploratory Data Analysis w/ SQL: Job Market Analysis

![SQL project step by step](./Images/1_1_Project1_EDA.png)

A step-by-step SQL project that analyses the data engineer job market using real-world job posting data. This project demonstrates my ability to **write production-quality analytical SQL, design efficient multi-table queries, and turn business questions into data-driven insights.**

## Executive Summary

- **Project Scope:** Built 3 analytical queries answering key questions about the data engineer job market.

- **Data Modelling:** Used multi-table joins across fact, dimension, and bridge tables to extract insights from a star schema.

- **Analytics:** Applied aggregations, mathematical transformations, filtering, and sorting to identify top skills by demand, salary, and overall career value.

- **Outcomes:** Delivered actionable insights highlighting SQL and Python dominance, cloud platform requirements and trends, and infrastructure salary patterns.

### Quick Review (60-Second Tour)

If you only have a minute, start with these core SQL scripts:

1. ['01_top_demanded_skills.sql'](./01_top_demanded_skills.sql) - Demand analysis using multi-table joins.

2. ['02_top_paying_skils.sql'](./02_top_paying_skils.sql) - Salary analysis using statistical aggregations.

3. ['03_Optimal_skills.sql'](./03_Optimal_skills.sql) - Combined salary and demand optimisation query.


## Problem and Context
Job market analysts and aspiring data engineers need clear answers to three core questions:

1. **Most In-Demand:** Which skills appear most frequently in data engineering job postings?

2. **Highest Paid:** Which skills command the highest median salaries?

3. **Best Trade-Off:** What is the optimal skill set balancing high market demand with strong compensation?


This project queries a data warehouse built using a **star schema** design:

![Data Warehouse build](./Images\1_2_Data_Warehouse.png)

Data Warehouse Schema

**Fact Table (`job_postings_fact`):** Central table containing job posting metrics and attributes (job titles, locations, annual salaries, and posting dates).

**Dimension Tables:**
- company_dim - Hiring company details linked to job postings.
- skills_dim - Skills catalogue containing skill names and types.

**Bridge Table (`skills_job_dim`):** Resolves the many-to-many relationship between job postings and required skills.


## Tech Stack

- **Query Engine:** DuckDB (for fast, in-process OLAP analytical queries)

- **Language:** SQL (ANSI-style with analytical and mathematical functions)

- **Data Model:** Star schema (Fact, Dimension, and Bridge tables)

- **Development Environment:** VS Code and Terminal (DuckDB CLI)

- **Version Control:** Git and GitHub


## Repository Structure

```text
1_EDA/
├── 01_top_demanded_skills.sql   # Demand analysis query
├── 02_top_paying_skills.sql     # Salary analysis query
├── 03_optimal_skills.sql        # Combined demand/salary optimisation query
└── README.md                    # Project documentation
```

## Analysis Overview

**Query Structure**

1. **Top Demanded Skills:** Identifies the 10 most in-demand skills for remote data engineer positions

2. **Top Paying Skills:** Analyses the 25 highest-paying skills, pairing median annual salary with posting volume

3. **Optimal Skills:** Calculates a custom **optimal Score** by combining the natural log of demand with median salary to highlight high-value, widely requested skills.


## Key Insights

- **Core Languages:** SQL and Python each appear in **~29,000 job postings**, making them the most demanded skills.
- **Cloud Platforms:** AWS and Azure dominate cloud requirements across modern data engineering roles.
- **Infrastructure and Tooling:** Kubernetes, Docker, and Terraform are consistently associated with premium salary brackets.
- **Big Data Processing:** Apache Spark demonstrates a strong balance of high employer demand and competitive compensation.


## SQL Skills Demonstrated

**Query Design & Optimization**

- **Complex Joins:** Multi-table `INNER JOIN` operations linking `job_postings_fact`, `skills_job_dim`, and `skills_dim`.
- **Statistical Aggregations:** Use of `COUNT()`, `MEDIAN()`, and `ROUND()` for clean statistical analysis.
- **Targeted Filtering:** Boolean logic with multi-condition `WHERE` clauses (`job_title_short`, `job_work_from_home`, and `salary_year_avg IS NOT NULL`).
- **Sorting and Limiting:** `ORDER BY' with 'DESC` paired with `LIMIT` to isolate top-performing skills.


## Data Analysis Techniques

- **Grouping and Filtering Aggregates:** `GROUP BY` paired with `HAVING` to filter out low-sample noise (requiring `>= 100` job postings).
- **Feature Engineering:** Mathematical normalisation using `LN()` (natural logarithm) to normalise demand metrics.
- **Data Quality Handling:** Explicit `NULL` filtering (`salary_year_avg IS NOT NULL`) to prevent skewed averages.
