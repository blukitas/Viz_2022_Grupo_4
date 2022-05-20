DROP TABLE IF EXISTS pubs;

CREATE TABLE pubs (
      pubId integer null
    , hourlyCost float null
    , maxOccupancy integer null
    , "location" varchar null
    , buildingId integer null
)