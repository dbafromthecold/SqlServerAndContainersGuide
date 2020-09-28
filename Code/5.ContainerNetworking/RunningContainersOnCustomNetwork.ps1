## Running containers on a custom network
## https://github.com/dbafromthecold/SqlServerAndContainersGuide/wiki/Running-SQL-containers-on-a-custom-network



## This code will guide you through running SQL containers on a custom docker network


# create a custom network
docker network create sqlserver



# confirm that by running
docker network ls



# spin up a couple of containers on that network using a custom image with ping installed
docker container run -d ` 
--network sqlserver `
--env ACCEPT_EULA=Y `
--env MSSQL_SA_PASSWORD=Testing1122 `
--name sqlcontainer1 `
ghcr.io/dbafromthecold/customsql2019-tools:cu5

docker container run -d `
--network sqlserver `
--env ACCEPT_EULA=Y `
--env MSSQL_SA_PASSWORD=Testing1122 `
--name sqlcontainer2 `
ghcr.io/dbafromthecold/customsql2019-tools:cu5



# confirm that the containers are up and running
docker container ls -a



# inspect the custom network
docker network inspect sqlserver



# test pinging each container from the other by name 
docker exec sqlcontainer1 ping sqlcontainer2 -c 4
docker exec sqlcontainer2 ping sqlcontainer1 -c 4



# spin up a container on the default network
docker container run -d `
--env ACCEPT_EULA=Y `
--env MSSQL_SA_PASSWORD=Testing1122 `
--name sqlcontainer3 `
ghcr.io/dbafromthecold/customsql2019-tools:cu5



# confirm the container is running
docker container ls -a



# confirm that it is on the default bridge network
docker network inspect bridge



# attach that container to our custom network
docker network connect sqlserver sqlcontainer3



# inspect the custom network
docker network inspect sqlserver



# test that the other containers can communicate to it via its name
docker exec sqlcontainer1 ping sqlcontainer3 -c 4



# remove it from the custom network we can run
docker network disconnect sqlserver sqlcontainer3



# confirm that it's no longer attached to the custom network
docker network inspect sqlserver



# test pinging the container again (this will fail as the container is no longer on the same network)
docker exec sqlcontainer1 ping sqlcontainer3 -c 4