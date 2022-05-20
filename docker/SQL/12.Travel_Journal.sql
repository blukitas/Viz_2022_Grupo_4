DROP TABLE IF EXISTS travelJournal;

CREATE TABLE travelJournal (
      participantId integer null
    , travelStartTime   varchar null
    , travelStartLocationId varchar null
    , travelEndTime   varchar null
    , travelEndLocationId integer null
    , purpose varchar null
    , checkInTime varchar null
    , checkOutTime varchar null
    , startingBalance float null
    , endingBalance float null
)