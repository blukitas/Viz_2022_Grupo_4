DROP TABLE IF EXISTS activityLogs;

CREATE TABLE activityLogs (
      currentLocation varchar null
    , participantId integer null
    , currentMode varchar null
    , hungerStatus varchar null
    , sleepStatus varchar null
    , apartmentId varchar null
    , availableBalance varchar null
    , jobId varchar null
    , financialStatus varchar null
    , dailyFoodBudget varchar null
    , weeklyExtraBudget varchar null
    , ts_min varchar null
    , ts_max varchar null
)
-- "timestamp"   varchar null