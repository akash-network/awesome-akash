SELECT DATE_TRUNC('{{ period }}', "b"."datetime"::DATE) AS "periodic", --set parameter type to 'dropdown list' with the values 'week, month' (newline delimited)
	   (COUNT("d"."id"))/(COUNT(DISTINCT "d"."owner")) AS "deployAVG"
	   
FROM "deployment" AS "d"
LEFT JOIN "block" AS "b" ON "b"."height" = "d"."createdHeight"


GROUP BY "periodic"