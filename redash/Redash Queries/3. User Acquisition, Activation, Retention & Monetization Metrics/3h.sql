SELECT 
    COUNT(DISTINCT "d"."deploymentGroupId")
FROM 
    "deploymentGroupResource" AS "d"
WHERE 
    "d"."{{ Define Resource }}" > 0 -- set parameter type to 'dropdown list' with the values 'persistentStorageQuantity, gpuUnits' (newline delimited)