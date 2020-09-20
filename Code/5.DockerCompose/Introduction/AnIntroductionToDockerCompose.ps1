## An Introduction to Docker Compose
## https://github.com/dbafromthecold/SqlServerAndContainersGuide/wiki/Docker-Compose-Introduction



## This code will guide you through how to spin up a SQL Server container using Docker Compose



# navigate to where the docker-compose file is
# and to spin up a container from our compose file run
docker-compose up -d



# check that our container is running
docker container ls -a



# we also have a custom network created - more on this later
docker network ls



# check that we can connect to SQL within our container
mssql-cli -S localhost -U sa -P Testing1122 -Q "SELECT @@VERSION AS [Version];"



# to remove the container run
docker-compose down