## More advanced Docker Compose
## https://github.com/dbafromthecold/SqlServerAndContainersGuide/wiki/More-advanced-Docker-Compose



## This code will guide you through using a dockerfile to create a custom image and persisting data using Docker Compose



# navigate to where the docker-compose file is
# and have a look at the dockefile
cat dockerfile



# have a look at the docker-compose.yaml file
cat docker-compose.yaml



# and have a look at the .env files
cat sqlserver.env
cat sapassword.env



# spin up a container from the docker-compose.yaml file
docker-compose up -d



# check everything created by running
docker network ls
docker volume ls
docker image ls
docker container ls



# connect to SQL using: -
mssql-cli -S localhost,15789 -u SA -P Testing1122 -Q "SELECT @@VERSION"



# blow away the container and custom network
docker-compose down
