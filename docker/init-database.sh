#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    GRANT ALL PRIVILEGES ON DATABASE viz TO viz_user;
EOSQL

for filename in /home/SQL/*.sql; do
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -f $filename
done


cd /home/challenge_data/Attributes
for filename in *.csv; do
    OUTPUT=$(echo $filename | cut -d "." -f 1)
    INSTRUCCION=$(echo "COPY $OUTPUT FROM '/home/challenge_data/Attributes/$filename' csv header;")
    echo $INSTRUCCION
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "$INSTRUCCION"
done


cd /home/challenge_data/Journals
for filename in *.csv; do
    OUTPUT=$(echo $filename | cut -d "." -f 1)
    INSTRUCCION=$(echo "COPY $OUTPUT FROM '/home/challenge_data/Journals/$filename' csv header;")
    echo $INSTRUCCION
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "$INSTRUCCION"
done


cd "/home/challenge_data/fix_activity_logs"
# INSTRUCCION=$(echo "COPY activityLogs FROM '/home/challenge_data/Activity Logs/ParticipantStatusLogs1.csv' csv header;")
# psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "$INSTRUCCION"
# INSTRUCCION=$(echo "COPY activityLogs FROM '/home/challenge_data/Activity Logs/ParticipantStatusLogs2.csv' csv header;")
# psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "$INSTRUCCION"
# INSTRUCCION=$(echo "COPY activityLogs FROM '/home/challenge_data/Activity Logs/ParticipantStatusLogs3.csv' csv header;")
# psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "$INSTRUCCION"
# INSTRUCCION=$(echo "COPY activityLogs FROM '/home/challenge_data/Activity Logs/ParticipantStatusLogs4.csv' csv header;")
# psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "$INSTRUCCION"
# INSTRUCCION=$(echo "COPY activityLogs FROM '/home/challenge_data/Activity Logs/ParticipantStatusLogs5.csv' csv header;")
# psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "$INSTRUCCION"
# INSTRUCCION=$(echo "COPY activityLogs FROM '/home/challenge_data/Activity Logs/ParticipantStatusLogs6.csv' csv header;")
# psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "$INSTRUCCION"
# INSTRUCCION=$(echo "COPY activityLogs FROM '/home/challenge_data/Activity Logs/ParticipantStatusLogs7.csv' csv header;")
# psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "$INSTRUCCION"
# INSTRUCCION=$(echo "COPY activityLogs FROM '/home/challenge_data/Activity Logs/ParticipantStatusLogs8.csv' csv header;")
# psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "$INSTRUCCION"
# INSTRUCCION=$(echo "COPY activityLogs FROM '/home/challenge_data/Activity Logs/ParticipantStatusLogs9.csv' csv header;")
# psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "$INSTRUCCION"


for filename in *.csv; do
    OUTPUT=$(echo $filename | cut -d "." -f 1)
    INSTRUCCION=$(echo "COPY activityLogs FROM '/home/challenge_data/fix_activity_logs/$filename' csv header;")
    echo $INSTRUCCION
    { # try

        psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "$INSTRUCCION"
        #save your output

    } || { # catch
        # save log for exception 
        echo "Error en archivo"
    }
done


for filename in /home/SQL_post/*.sql; do
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -f $filename
done