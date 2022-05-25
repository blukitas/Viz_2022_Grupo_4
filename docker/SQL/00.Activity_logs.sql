DROP TABLE IF EXISTS activityLogs;

CREATE TABLE activityLogs (
      "timestamp"   varchar null
    , currentLocation varchar null
    , participantId integer null
    , currentMode varchar null
    , hungerStatus varchar null
    , sleepStatus varchar null
    , apartmentId varchar null
    , availableBalance float null
    , jobId integer null
    , financialStatus varchar null
    , dailyFoodBudget float null
    , weeklyExtraBudget float null
)