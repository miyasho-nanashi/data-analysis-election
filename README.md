US Election Data Analysis with AWS Athena
Project Overview
This project analyzes US election data using AWS Athena and S3. The goal was to query and explore patterns in voting results across multiple years while leveraging Athena's serverless SQL capabilities for fast data processing. The data was stored in an S3 bucket and queried using SQL scripts in Athena.

Dataset
The dataset includes information about US election results, including:

Year: Year of the election.
State: Name and codes (postal code, FIPS, census code, etc.).
Candidate: Candidate names and their respective parties.
Votes: Total votes cast and votes received by candidates.
Write-ins: Whether the candidate was a write-in.
Party Simplification: Party categories (e.g., DEMOCRAT, REPUBLICAN, LIBERTARIAN, OTHER).
Athena Table Creation
The following SQL script was used to create the election_results table in Athena, pulling data directly from the S3 bucket:

CREATE EXTERNAL TABLE IF NOT EXISTS election_results (
    year INT,
    state STRING,
    state_po STRING,
    state_fips INT,
    state_cen INT,
    state_ic INT,
    office STRING,
    candidate STRING,
    party_detailed STRING,
    writein BOOLEAN,
    candidatevotes BIGINT,
    totalvotes BIGINT,
    version STRING,
    notes STRING,
    party_simplified STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
    'separatorChar' = ',',
    'quoteChar' = '"',
    'skip.header.line.count' = '1'
)
STORED AS TEXTFILE
LOCATION 's3://election-data-analysis/' -- Replace with your bucket and folder path
TBLPROPERTIES (
    'serialization.null.format' = '',
    'has_encrypted_data'='false'
);

Key Queries
Examples of the types of queries run:

Total votes for a candidate (e.g., Donald Trump in 2020)

SELECT SUM(candidatevotes) AS total_votes
FROM election_results
WHERE candidate = 'TRUMP, DONALD J.' AND year = 2020;

State-by-state analysis for a specific candidate:

SELECT state, SUM(candidatevotes) AS votes
FROM election_results
WHERE candidate = 'TRUMP, DONALD J.' AND year = 2020
GROUP BY state
ORDER BY votes DESC;

Identify total votes across all candidates:

SELECT year, SUM(totalvotes) AS total_votes
FROM election_results
GROUP BY year;

Challenges
Handling Null Values: The dataset had inconsistencies such as missing values and malformed strings (e.g., extra quotes in candidate names). These were cleaned before uploading to S3.
Large Data Size: Efficient querying was achieved by storing data in an optimized format and structuring Athena queries correctly.
Tools and Technologies
AWS Athena: For running SQL queries on S3 data.
AWS S3: For storing election data in CSV format.
Python: Used for data preprocessing and cleaning.
GitHub: For version control and project management.
How to Reproduce
Download the election data and upload it to an S3 bucket.
Use the provided Athena table creation script to set up the database.
Run the sample queries to explore the data.
Modify queries to answer custom research questions.
Results
The analysis highlighted voting patterns, candidate performance, and overall voter turnout across states and years. This project showcases the power of combining AWS services for big data analysis.

Feel free to update this with any additional information, like visualizations or links to the dataset!



