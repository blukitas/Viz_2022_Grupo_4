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


cd "/home/challenge_data/Activity Logs"
for filename in *.csv; do
    OUTPUT=$(echo $filename | cut -d "." -f 1)
    INSTRUCCION=$(echo "COPY activityLogs FROM '/home/challenge_data/Activity Logs/$filename' csv header;")
    echo $INSTRUCCION
    { # try

        psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -c "$INSTRUCCION"
        #save your output

    } || { # catch
        # save log for exception 
        echo "Error en archivo"
    }
done
