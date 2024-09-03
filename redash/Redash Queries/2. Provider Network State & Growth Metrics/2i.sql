WITH "bids" AS(
	SELECT
		DISTINCT "bid"."dseq",
		"bid"."createdHeight",
		COUNT(DISTINCT "bid"."provider") AS "bidCount"
	FROM
		"bid"
	GROUP BY 
		"bid"."dseq", "bid"."createdHeight"
	ORDER BY
		"bid"."dseq" ASC
)

SELECT AVG("bids"."bidCount") FROM "bids"
