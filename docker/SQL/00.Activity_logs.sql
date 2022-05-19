DROP TABLE IF EXISTS activity_logs;

CREATE TABLE activity_logs (
      "timestamp" timestamp null
    , currentLocation point null
    , participantId integer null
    , hungerStatus varchar null
    , sleepStatus varchar null
    , apartmentId integer null
    , availableBalance float null
    , jobId integer null
    , financialStatus varchar null
    , dailyFoodBudget float null
    , weeklyExtraBudget float null
)