## Persisting Data using Named Volumes
## https://github.com/dbafromthecold/SqlServerAndContainersGuide/wiki/Persisting-data-using-data-volume-container



## This code will show you how to persist a database from one container to another using data volume containers


# create a container with volumes
docker container create --name datastore \
--volume /var/opt/sqlserver/data \
--volume /var/opt/sqlserver/log \
--volume /var/opt/sqlserver/backups \
ubuntu:18.04



# confirm that the container has been created
docker container ls -a



# check the volumes
docker volume ls



# spin up a container with mapping the volumes from the data volume container
docker container run -d \
--publish 15789:1433 \
--volumes-from datastore \
--env ACCEPT_EULA=Y \
--env SA_PASSWORD=Testing1122 \
--env MSSQL_DATA_DIR=/var/opt/sqlserver/data \
--env MSSQL_LOG_DIR=/var/opt/sqlserver/log \
--env MSSQL_BACKUP_DIR=/var/opt/sqlserver/backup \
--name testcontainer1 \
mcr.microsoft.com/mssql/server:2019-CU5-ubuntu-18.04



# confirm the sql container is running
docker container ls -a



# change the owner of the volumes
docker exec -u 0 testcontainer1 chown -R mssql /var/opt/sqlserver



# create a database
mssql-cli -S localhost,15789 -U sa -P Testing1122 -Q "CREATE DATABASE [testdatabase1];"



# confirm the location of the database files
mssql-cli -S localhost,15789 -U sa -P Testing1122 -Q "USE [testdatabase1]; EXEC sp_helpfile;"



# blow that sql container away
docker container rm testcontainer1 -f



# confirm the data volume container is still there
docker container ls -a



# confirm the named volumes are still there
docker volume ls



# spin up another container, mapping the volumes again
docker container run -d \
--publish 15799:1433 \
--volumes-from datastore \
--env ACCEPT_EULA=Y \
--env SA_PASSWORD=Testing1122 \
--env MSSQL_DATA_DIR=/var/opt/sqlserver/data \
--env MSSQL_LOG_DIR=/var/opt/sqlserver/log \
--env MSSQL_BACKUP_DIR=/var/opt/sqlserver/backup \
--name testcontainer2 \
mcr.microsoft.com/mssql/server:2019-CU5-ubuntu-18.04



# confirm that the container is up and running
docker container ls -a



# check that the database files are there
docker exec testcontainer2 ls -al /var/opt/sqlserver



# manually attach the database
mssql-cli -S localhost,15799 -U sa -P Testing1122 \
-Q "CREATE DATABASE [testdatabase1]
    ON PRIMARY
    (NAME='testdatabase1',FILENAME='/var/opt/sqlserver/data/testdatabase1.mdf')
    LOG ON
    (NAME='testdatabase1_log',FILENAME='/var/opt/sqlserver/log/testdatabase1_log.ldf')
    FOR ATTACH;"



# confirm the database is there
mssql-cli -S localhost,15799 -U sa -P Testing1122 -Q "SELECT [name] FROM sys.databases;"



# clean up
docker container rm $(docker container ls -aq) -f && docker volume prune -f