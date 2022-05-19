DROP TABLE IF EXISTS buildings;

CREATE TABLE buildings (
      buildingId integer null
    , "location" point null
    , buildingType varchar null
    , maxOccupancy integer null
    , units varchar null
)