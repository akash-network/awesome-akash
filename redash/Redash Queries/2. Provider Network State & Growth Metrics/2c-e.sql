
WITH resource_capacity AS(
    SELECT 
        DATE("p"."checkDate") AS "date",
        "p"."owner",
        (AVG("p"."activeCPU") + AVG("p"."availableCPU"))/1000 AS "totalCPU",
        (AVG("p"."activeMemory") + AVG("p"."activeMemory"))/1073741824 AS "totalMemory",
        (AVG("p"."activeStorage") + AVG("p"."activeStorage"))/1073741824 AS "totalStorage",
        (AVG("p"."activeGPU") + AVG("p"."activeGPU")) AS "totalGPU"
    FROM "providerSnapshot" AS "p"
    WHERE "p"."isOnline" = true
    GROUP BY 1,2
)

SELECT 
    "resource_capacity"."date",
    SUM("resource_capacity"."{{ Define Resource }}")
FROM "resource_capacity"
WHERE 
    DATE("resource_capacity"."date") >= '{{ dateRange.start }}' AND 
    DATE("resource_capacity"."date") <= '{{ dateRange.end }}'
GROUP BY 1
ORDER BY "date" DESC