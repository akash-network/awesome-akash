WITH dailyleases AS(
	SELECT
		"day"."date",
		MAX("block"."totalLeaseCount") AS "totalLeaseCount"
	FROM
		"day"
	INNER JOIN
		"block" ON "block"."dayId" = "day"."id"
	GROUP BY
		"day"."date"
	ORDER BY 
		"day"."date" ASC
)
SELECT
	"dailyleases"."date",
	"dailyleases"."totalLeaseCount",
	
	"dailyleases"."totalLeaseCount" - LAG("dailyleases"."totalLeaseCount", 1) OVER (ORDER BY "dailyleases"."date") AS "dailyleases"
FROM
	"dailyleases"
WHERE 
    DATE("dailyleases"."date") >= '{{ dateRange.start }}' AND 
    DATE("dailyleases"."date") <= '{{ dateRange.end }}'
ORDER BY "dailyleases"."date" DESC