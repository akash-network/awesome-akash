WITH dailyspend AS(
	SELECT
		"day"."date",
		MAX("block"."totalUAktSpent")/1000000 AS "aktSpent"
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
	"dailyspend"."date",
	"dailyspend"."aktSpent",
	"dailyspend"."aktSpent" - LAG("dailyspend"."aktSpent", 1) OVER (ORDER BY "dailyspend"."date") AS "dailyAktSpent"
FROM
	"dailyspend"
WHERE 
    DATE("dailyspend"."date") >= '{{ dateRange.start }}' AND 
    DATE("dailyspend"."date") <= '{{ dateRange.end }}'
