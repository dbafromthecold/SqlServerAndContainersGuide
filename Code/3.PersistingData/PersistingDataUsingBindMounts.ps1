## Persisting Data using Named Volumes
## https://github.com/dbafromthecold/SqlServerAndContainersGuide/wiki/Persisting-data



## This code will show you how to persist a database from one container to another using named volumes



# let's create a couple of directories on the host
mkdir C:\sqlserver\data
mkdir C:\sqlserver\log



# run a container
docker container run -d  `
--publish 15789:1433 `
--volume C:\sqlserver\data:/opt/sqlserver/data `
--volume C:\sqlserver\log:/opt/sqlserver/log `
--env ACCEPT_EULA=Y `
--env MSSQL_SA_PASSWORD=Testing1122 `
--env MSSQL_DATA_DIR=/opt/sqlserver/data `
--env MSSQL_LOG_DIR=/opt/sqlserver/log `
--name sqlcontainer1 `
mcr.microsoft.com/mssql/server:2019-CU5-ubuntu-18.04



# confirm that the container is up
docker container ls -a



# create a database
mssql-cli -S localhost,15789 -U sa -P Testing1122 -Q "CREATE DATABASE [testdatabase]"



# check the database files
mssql-cli -S localhost,15789 -U sa -P Testing1122 -Q "USE [testdatabase]; EXEC sp_helpfile;"



# confirm the files on the host
ls C:\sqlserver\data
ls C:\sqlserver\log



# blow the container away
docker rm sqlcontainer1 -f



# spin up a new container, remapping the volumes from the host
docker container run -d  `
--publish 15799:1433 `
--volume C:\sqlserver\data:/opt/sqlserver/data `
--volume C:\sqlserver\log:/opt/sqlserver/log `
--env ACCEPT_EULA=Y `
--env MSSQL_SA_PASSWORD=Testing1122 `
--env MSSQL_DATA_DIR=/opt/sqlserver/data `
--env MSSQL_LOG_DIR=/opt/sqlserver/log `
--name sqlcontainer2 `
mcr.microsoft.com/mssql/server:2019-CU5-ubuntu-18.04



# confirm the container is up and running
docker container ls -a



# manually attach the database into SQL in the new container
mssql-cli -S localhost,15799 -U sa -P Testing1122 `
-Q "CREATE DATABASE [testdatabase1] ON PRIMARY (NAME='testdatabase1',FILENAME='/var/opt/sqlserver/data/testdatabase1.mdf') LOG ON (NAME='testdatabase1_log',FILENAME='/var/opt/sqlserver/log/testdatabase1_log.ldf') FOR ATTACH;"



# check that the database is there
mssql-cli -S localhost,15799 -U sa -P Testing1122 -Q "SELECT [name] FROM sys.databases;"