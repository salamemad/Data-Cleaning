SELECT
    SERVERPROPERTY('MachineName') AS 'Machine Name',
    SERVERPROPERTY('ServerName') AS 'Server Name',
    SERVERPROPERTY('InstanceName') AS 'Instance Name',
    SERVERPROPERTY('Edition') AS 'Edition',
    SERVERPROPERTY('ProductVersion') AS 'Product Version',
    SERVERPROPERTY('ProductLevel') AS 'Product Level',
    SERVERPROPERTY('EditionID') AS 'Edition ID',
    SERVERPROPERTY('MachineName') AS 'Machine Name',
    SERVERPROPERTY('IsClustered') AS 'Is Clustered'

	SELECT
    name AS 'Database Name',
    database_id AS 'Database ID',
    create_date AS 'Creation Date'
FROM sys.databases
