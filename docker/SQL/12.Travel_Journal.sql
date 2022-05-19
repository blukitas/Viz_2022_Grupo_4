DROP TABLE IF EXISTS travelJournal;

CREATE TABLE travelJournal (
      participantId integer null
    , travelStartTime timestamp null
    , travelStartLocationId integer null
    , travelEndTime timestamp null
    , travelEndLocationId integer null
    , purpose varchar null
    , checkInTime integer null
    , checkOutTime integer null
    , startingBalance float null
    , endingBalance float null
)