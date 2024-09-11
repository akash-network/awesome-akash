SELECT
	DISTINCT "lease"."providerAddress"
FROM
	"lease"
WHERE
	"lease"."{{ Define Resource }}" > 0 --parameter type set to 'Dropdown List' with values 'persistentStorageQuantity, gpuUnits' (newline delimited)