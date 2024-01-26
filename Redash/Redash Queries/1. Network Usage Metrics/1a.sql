SELECT 
	"day"."date", 
	COUNT(*)
FROM 
	"deployment"
INNER JOIN "block" ON "block"."height" = "deployment"."createdHeight"
INNER JOIN "day"   ON "day"."id" = "block"."dayId"
WHERE 
    DATE("day"."date") >= '{{ dateRange.start }}' AND 
    DATE("day"."date") <= '{{ dateRange.end }}'
GROUP BY "day"."date"
ORDER BY "day"."date" DESC