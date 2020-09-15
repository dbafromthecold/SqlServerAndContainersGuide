## Copying files to and from a container
## https://github.com/dbafromthecold/SqlServerAndContainersGuide/wiki/Copying-files-to-and-from-a-container



## This code will guide you through how to copy files to and from a Docker container



# spin up a container running SQL Server: -
docker container run -d `
-p 15789:1433 `
--env ACCEPT_EULA=Y `
--env MSSQL_SA_PASSWORD=Testing1122 `
--name sqlcontainer1 `
mcr.microsoft.com/mssql/server:2019-CU5-ubuntu-18.04

# we want to copy a backup of a database into that container: -
ls

# to order to copy the backup files into the container we run: - 
docker container cp testdatabase.bak sqlcontainer1:/var/opt/mssql/data

# check that the backup has been copied in by running: -
docker exec sqlcontainer1 ls -al /var/opt/mssql/data

# copy that file back out of the container, onto our Docker host: -
docker cp sqlcontainer1:/var/opt/mssql/data/testdatabase.bak C:\temp