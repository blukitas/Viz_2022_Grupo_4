DROP TABLE IF EXISTS apartments;

CREATE TABLE apartments (
      apartmentId integer null
    , rentalCost float null
    , maxOccupancy integer null
    , numberOfRooms integer null
    , "location" varchar null
    , buildingId integer null
)