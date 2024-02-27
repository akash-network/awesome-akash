WITH countbl AS(
	SELECT
		"day"."date",
		COUNT("provider"."owner") AS "newProviders"
	FROM "block"
	INNER JOIN "provider" ON "provider"."createdHeight" = "block"."height"
	LEFT JOIN "day" 	 ON "day"."id" = "block"."dayId"
	GROUP BY "day"."date"
	ORDER BY "day"."date" ASC
)

SELECT 
	"countbl"."date",
	"countbl"."newProviders",
	SUM("countbl"."newProviders") OVER(ORDER BY "countbl"."date" ASC ROWS BETWEEN unbounded preceding AND CURRENT ROW) AS runningSum
FROM
	"countbl"