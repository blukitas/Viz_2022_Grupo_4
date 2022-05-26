DROP TABLE IF EXISTS activityLogs;

CREATE TABLE activityLogs (
      "timestamp"   varchar null
    , currentLocation varchar null
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
)