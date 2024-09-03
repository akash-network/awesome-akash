SELECT  AVG("l"."cpuUnits")/1000 AS "avgCPU",
		AVG("l"."memoryQuantity")/1073741824 AS "avgMem",
		AVG("l"."ephemeralStorageQuantity")/1073741824 AS "avgEphStorage",
		AVG("l"."persistentStorageQuantity")/1073741824 AS "avgPerStorage",
		AVG("l"."gpuUnits") AS "avgGPU"
FROM "lease" AS "l"
WHERE 
    "l"."persistentStorageQuantity" > 0 AND 
    "l"."gpuUnits" > 0