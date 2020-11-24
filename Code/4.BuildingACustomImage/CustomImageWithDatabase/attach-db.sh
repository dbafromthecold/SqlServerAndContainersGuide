sleep 30s
 
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Testing1122 \
-Q "CREATE DATABASE [testdatabase] ON (FILENAME = '/var/opt/sqlserver/testdatabase.mdf'),(FILENAME = '/var/opt/sqlserver/testdatabase_log.ldf') FOR ATTACH"