DROP TABLE IF EXISTS financialJournal;

CREATE TABLE financialJournal (
      participantId integer null
    , "timestamp" timestamp null
    , category varchar null
    , amount float null
)