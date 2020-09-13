## Persisting Data using Named Volumes
## https://github.com/dbafromthecold/SqlServerAndContainersGuide/wiki/Persisting-data



## This code will show you how to persist a database from one container to another using named volumes



# let's create a couple of named volumes
docker volume create mssqlsystem
docker volume create mssqluser



# confirm the volumes are there
docker volume ls



# run a container with the volumes mapped
docker container run -d `
-p 15789:1433 `
--volume mssqlsystem:/var/opt/mssql `
--volume mssqluser:/var/opt/sqlserver `
--env ACCEPT_EULA=Y `
--env MSSQL_SA_PASSWORD=Testing1122 `
--name sqlcontainer1 `
mcr.microsoft.com/mssql/server:2019-CU5-ubuntu-18.04



# change the owner of /var/opt/sqlserver to the mssql user
docker exec -u 0 sqlcontainer1 bash -c "chown -R mssql /var/opt/sqlserver"



# create a database
mssql-cli -S localhost,15789 -U sa -P Testing1122 `
-Q "CREATE DATABASE [DatabaseD] ON PRIMARY (NAME='DatabaseD',FILENAME='/var/opt/sqlserver/DatabaseD.mdf') LOG ON (NAME='DatabaseD_log',FILENAME='/var/opt/sqlserver/DatabaseD_log.ldf');"



# confirm the database is there
mssql-cli -S localhost,15789 -U sa -P Testing1122 -Q "SELECT [name] FROM sys.databases;"



# blow away the container
docker container rm sqlcontainer1 -f



# confirm that the container is gone
docker container ls -a



# confirm the volumes are still there
docker volume ls



# run another container with the volumes mapped
docker container run -d `
-p 15799:1433 `
--volume mssqlsystem:/var/opt/mssql `
--volume mssqluser:/var/opt/sqlserver `
--env ACCEPT_EULA=Y `
--env MSSQL_SA_PASSWORD=Testing1122 `
--name sqlcontainer2 `
mcr.microsoft.com/mssql/server:2019-CU5-ubuntu-18.04



# and our databases are there!
mssql-cli -S localhost,15799 -U sa -P Testing1122 -Q "SELECT [name] FROM sys.databases;"