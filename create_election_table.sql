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
