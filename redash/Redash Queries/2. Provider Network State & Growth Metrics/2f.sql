WITH countbl AS(
	SELECT
		"providerSnapshot"."owner",
		COUNT("providerSnapshot"."isOnline") AS "totalCount",
		COUNT(CASE WHEN "providerSnapshot"."isOnline" Then 1 END) AS "onlineCount"
	FROM "providerSnapshot"
	GROUP BY "providerSnapshot"."owner"
)

SELECT
	"countbl"."owner" AS "provider",
	CAST("countbl"."onlineCount" AS NUMERIC) / CAST("countbl"."totalCount" AS NUMERIC) AS "uptimePCT"
FROM "countbl"
WHERE "countbl"."onlineCount" > 0
ORDER BY "uptimePCT" DESC