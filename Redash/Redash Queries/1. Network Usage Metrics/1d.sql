SELECT
	"day"."date",
	CAST(AVG("block"."activeLeaseCount") AS INTEGER) AS "activeLeaseCount"
FROM
	"block"
INNER JOIN
	"day" ON "day"."id" = "block"."dayId"
WHERE 
    DATE("day"."date") >= '{{ dateRange.start }}' AND 
    DATE("day"."date") <= '{{ dateRange.end }}'
GROUP BY
	"day"."date"
ORDER BY
	"day"."date" DESC