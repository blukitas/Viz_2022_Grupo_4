#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    GRANT ALL PRIVILEGES ON DATABASE viz TO viz_user;
    CREATE TABLE Activity_logs (  [timestamp] datetime null
                                , currentLocation point null
                                , participantId integer null
                                , hungerStatus string null
                                , sleepStatus string null
                                , apartmentId integer null
                                , availableBalance float null
                                , jobId integer null
                                , financialStatus string null
                                , dailyFoodBudget double null
                                , weeklyExtraBudget double null)
EOSQL