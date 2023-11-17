SELECT
	"d"."date",
	"a"."address",
	COUNT("t"."hash")
FROM "addressReference"  AS "a"
INNER JOIN "transaction" AS "t" ON "t"."id" = "a"."transactionId"
INNER JOIN "message" 	 AS "m" ON "t"."id" = "m"."txId"
INNER JOIN "block"		 AS "b" ON "b"."height" = "t"."height"
INNER JOIN "day"		 AS "d" ON "d"."id" = "b"."dayId"
WHERE 
	"a"."address" IN(
		SELECT DISTINCT "provider"."owner"
		FROM "provider")
	AND "m"."type" = '/akash.market.v1beta1.MsgWithdrawLease'
	OR  "m"."type" = '/akash.market.v1beta2.MsgWithdrawLease'
	OR  "m"."type" = '/akash.market.v1beta3.MsgWithdrawLease'
GROUP BY
	"d"."date", "a"."address"
ORDER BY 
	"d"."date" DESC
