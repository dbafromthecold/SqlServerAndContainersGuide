## Quick Start
## https://github.com/dbafromthecold/SqlServerAndContainersGuide/wiki/Quick-Start



## This code will get you up and running with SQL Server 2019 in a Docker container



# Execute this to get a container up and running 
docker run -d -p 1433:1433 `
--env ACCEPT_EULA=Y `
--env MSSQL_SA_PASSWORD=Testing1122 `
--name sqlcontainer1 `
mcr.microsoft.com/mssql/server:2019-latest



# the latest 2019 image will be pulled down for you, you can check it by running
docker image ls



# and finally, check that your container is up and running with
docker container ls -a



# if the status of the container is UP you can connect to it in SSMS or ADS with localhost