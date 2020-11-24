sleep 30s
 
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Testing1122 \
-Q "CREATE DATABASE [testdatabase] ON (FILENAME = '/var/opt/sqlserver/data/testdatabase.mdf'),(FILENAME = '/var/opt/sqlserver/log/testdatabase_log.ldf') FOR ATTACH"