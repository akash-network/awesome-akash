-- (nulls are deployments that didn't become a lease)

WITH unique_lease AS(
	SELECT 
		DISTINCT "lease"."deploymentId"
	FROM
		"lease"
),

"find" AS(
    SELECT
        DATE("block"."datetime") AS "date",
        "d"."createdHeight",
    	"d"."id" AS "d_id",
    	"l"."deploymentId"
    FROM "deployment" AS "d"
    LEFT JOIN "unique_lease" AS "l" ON "l"."deploymentId" = "d"."id"
    LEFT JOIN "block" ON "block"."height" = "d"."createdHeight"
    ORDER BY "block"."datetime" DESC
)

SELECT 
    "find"."date",
    COUNT("find"."d_id") AS "neverDeployed"
FROM "find"
WHERE 
    "find"."deploymentId" IS NULL AND
    DATE("find"."date") >= '{{ dateRange.start }}' AND 
    DATE("find"."date") <= '{{ dateRange.end }}'
GROUP BY 1