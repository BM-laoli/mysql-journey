SELECT *
FROM websites;
SELECT *
FROM access_log;
SELECT *
FROM apps;
SELECT country
FROM websites
UNION
SELECT country
FROM apps
ORDER BY country;
SELECT country,
  name
FROM websites
WHERE country = 'CN'
UNION ALL
SELECT country,
  app_name
FROM apps
WHERE country = 'CN'
ORDER BY country;