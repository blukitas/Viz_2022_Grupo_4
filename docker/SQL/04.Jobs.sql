DROP TABLE IF EXISTS jobs;

CREATE TABLE jobs (
      jobId integer null
    , employerId integer null
    , hourlyRate float null
    , startTime timestamp null
    , endTime timestamp null
    , daysToWork varchar null
    , educationRequirement varchar null
)