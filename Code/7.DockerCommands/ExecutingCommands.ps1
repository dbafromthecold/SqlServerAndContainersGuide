## Executing commands against a container
## https://github.com/dbafromthecold/SqlServerAndContainersGuide/wiki/Executing-commands-against-a-container



## This code will guide you through how to execute commands against a running container



# spin up a container running SQL Server
docker container run -d `
--publish 15789:1433 `
--env ACCEPT_EULA=Y `
--env SA_PASSWORD=Testing1122 `
--name sqlcontainer1 `
mcr.microsoft.com/mssql/server:2019-CU5-ubuntu-18.04



# confirm that the container is running
docker container ls -a



# list the files in the master database location
docker container exec sqlcontainer1 ls -al /var/opt/mssql/data



# check the processes running within the container
docker container exec sqlcontainer1 ps aux



# check which user we are executing commands as
docker container exec sqlcontainer1 whoami



# switch to the root user
docker container exec -u 0 sqlcontainer1 whoami



# jump into the container itself using
docker container exec -it sqlcontainer1 bash



# exit the container
exit
