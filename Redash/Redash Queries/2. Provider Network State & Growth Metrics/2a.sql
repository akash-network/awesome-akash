WITH owners AS(
    SELECT 
        DATE("p"."checkDate") AS "date",
        "p"."owner",
        COUNT(*)
    FROM 
        "providerSnapshot" AS "p"
    WHERE 
        "p"."isOnline" IS true
    GROUP BY 
        1,2
)

SELECT 
    "owners"."date",
    COUNT("owners"."owner") AS "activeProviders"
FROM 
    "owners"
WHERE 
    DATE("owners"."date") >= '{{ dateRange.start }}' AND 
    DATE("owners"."date") <= '{{ dateRange.end }}'
GROUP BY 
    1