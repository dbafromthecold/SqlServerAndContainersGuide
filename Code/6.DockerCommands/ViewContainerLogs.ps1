## Viewing container logs
## https://github.com/dbafromthecold/SqlServerAndContainersGuide/wiki/Viewing-container-logs



## This code will show you how to view container logs



# spin up a container running SQL Server: -
docker container run -d `
--publish 15789:1433 `
--env ACCEPT_EULA=Y `
--env SA_PASSWORD=Testing1122 `
--name sqlcontainer1 `
mcr.microsoft.com/mssql/server:2019-CU5-ubuntu-18.04



# and view the logs
docker container logs sqlcontainer1