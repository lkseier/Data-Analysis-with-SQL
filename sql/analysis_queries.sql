-- KBO Database: SQL Analysis Queries
-- Objective: Extract business insights from active companies in Belgium

SELECT name FROM sqlite_master WHERE type = 'table';
-- Basic check
SELECT * FROM enterprise LIMIT 5;


-- 1. Percentage of companies by juridical form
SELECT 
  JuridicalForm, -- Change this to the actual column name if different (e.g., Juridical_Form or juridical_form)
  COUNT(*) * 100.0 / (SELECT COUNT(*) FROM enterprise) AS percentage,
  count(*)
FROM enterprise
GROUP BY JuridicalForm -- Change this to match the column name above
ORDER BY percentage DESC;

-- 2. Distribution of company statuses
SELECT 
  Status,
  COUNT(*) AS count
FROM enterprise
GROUP BY Status
ORDER BY count DESC;

-- checking how many non null values 
SELECT COUNT(*) AS total_companies,
       COUNT(e.StartDate) AS non_null_startdates
FROM enterprise e;

--checking the match btween enterprise and activity
SELECT COUNT(*) AS matched_rows
FROM enterprise e
JOIN activity a ON e.EnterpriseNumber = a.EntityNumber;

--checking the format of StartDate
SELECT e.StartDate
FROM enterprise e
WHERE e.StartDate IS NOT NULL
LIMIT 10;


-- 3. Average company age by NACE code (sector)
SELECT 
  a.NaceCode,
  COUNT(*) AS company_count,
  AVG((JULIANDAY('now') - JULIANDAY(e.StartDate)) / 365.25) AS avg_age_years
FROM enterprise e
JOIN activity a ON e.EnterpriseNumber = a.EntityNumber
WHERE e.StartDate IS NOT NULL
GROUP BY a.NaceCode
ORDER BY avg_age_years DESC
LIMIT 20;

-- 4. Company creation trend per year
SELECT 
  STRFTIME('%Y', StartDate) AS year,
  COUNT(*) AS company_count
FROM enterprise
WHERE StartDate IS NOT NULL
GROUP BY year
ORDER BY year;

-- 5. Geographical distribution by municipality (FR)
SELECT 
  a.MunicipalityFR,
  COUNT(*) AS company_count
FROM address a
JOIN enterprise e ON a.EntityNumber = e.EnterpriseNumber
GROUP BY a.MunicipalityFR
ORDER BY company_count DESC
LIMIT 15;

-- 6. Growth trend by NACE code (last 5 years)
SELECT 
  STRFTIME('%Y', e.StartDate) AS year,
  a.NaceCode,
  COUNT(*) AS company_count
FROM enterprise e
JOIN activity a ON e.EnterpriseNumber = a.EntityNumber
WHERE e.StartDate >= DATE('now', '-5 years')
GROUP BY year, a.NaceCode
ORDER BY year, company_count DESC;

-- 7. Seasonal pattern of company creations (monthly)
SELECT 
  STRFTIME('%m', StartDate) AS month,
  COUNT(*) AS company_count
FROM enterprise
WHERE StartDate IS NOT NULL
GROUP BY month
ORDER BY month;

-- 8. Categorize companies by size using CASE (TypeOfEnterprise)
SELECT 
  CASE 
    WHEN TypeOfEnterprise LIKE '%micro%' THEN 'Micro'
    WHEN TypeOfEnterprise LIKE '%small%' THEN 'Small'
    WHEN TypeOfEnterprise LIKE '%medium%' THEN 'Medium'
    WHEN TypeOfEnterprise LIKE '%large%' THEN 'Large'
    ELSE 'Unknown'
  END AS SME_Category,
  COUNT(*) AS count
FROM enterprise
GROUP BY SME_Category
ORDER BY count DESC;

-- 9. LEFT JOIN: Count number of branches per enterprise
SELECT 
  e.EnterpriseNumber,
  e.JuridicalForm,
  COUNT(b.Id) AS branch_count
FROM enterprise e
LEFT JOIN branch b ON e.EnterpriseNumber = b.Enterprisenumber
GROUP BY e.EnterpriseNumber
ORDER BY branch_count DESC
LIMIT 20;

-- 10. Top municipalities with most establishments
SELECT 
  a.MunicipalityFR,
  COUNT(DISTINCT est.EstablishmentNumber) AS establishment_count
FROM establishment est
JOIN address a ON est.EnterpriseNumber = a.EntityNumber
GROUP BY a.MunicipalityFR
ORDER BY establishment_count DESC
LIMIT 15;

--11 Companies with the most estbalishment locations

SELECT 
  e.EnterpriseNumber,
  d.Denomination,
  COUNT(est.EstablishmentNumber) AS num_establishments
FROM establishment est
JOIN enterprise e ON est.EnterpriseNumber = e.EnterpriseNumber
LEFT JOIN denomination d ON e.EnterpriseNumber = d.EntityNumber
  AND d.TypeOfDenomination = 1
GROUP BY e.EnterpriseNumber
ORDER BY num_establishments DESC
LIMIT 10;

SELECT DISTINCT TypeOfDenomination
FROM denomination;

SELECT 
  EntityNumber,
  TypeOfDenomination,
  Language,
  Denomination
FROM denomination
WHERE EntityNumber IN (
  SELECT EnterpriseNumber 
  FROM enterprise
  LIMIT 5
)
ORDER BY EntityNumber, TypeOfDenomination;





  