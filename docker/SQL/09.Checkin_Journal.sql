DROP TABLE IF EXISTS checkinJournal;

CREATE TABLE checkinJournal (
      participantId integer null
    , "timestamp" timestamp null
    , venueId integer null
    , venueType varchar null
)