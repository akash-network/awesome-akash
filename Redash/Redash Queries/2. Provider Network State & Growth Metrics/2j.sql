--every 1millionth block

SELECT
	"block"."height",
	"block"."datetime"
FROM
	"block"
WHERE "block"."height" % 1000000 = 0
ORDER BY "block"."height" ASC