SELECT
	(MAX("b"."totalUAktSpent")/1000000) / MAX("b"."totalLeaseCount") AS "AKTavgLeaseSpend",
	(MAX("b"."totalUUsdSpent")/1000000) / MAX("b"."totalLeaseCount") AS "USDavgLeaseSpend"
FROM "block" AS "b"