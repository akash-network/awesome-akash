WITH "Addresses" AS (
    SELECT 
        l."owner" AS "Address",
        MIN(b."datetime") AS "FirstDeployDate"
    FROM "lease" l
    INNER JOIN "block" b ON b.height = l."createdHeight"
    GROUP BY l."owner"
)
SELECT
    DATE("FirstDeployDate") AS "Date",
    COUNT(*) AS "New Address Count"
FROM "Addresses" AS d
WHERE 
    DATE("d"."FirstDeployDate") >= '{{ dateRange.start }}' AND 
    DATE("d"."FirstDeployDate") <= '{{ dateRange.end }}'
GROUP BY DATE("FirstDeployDate")
ORDER BY DATE("FirstDeployDate") DESC