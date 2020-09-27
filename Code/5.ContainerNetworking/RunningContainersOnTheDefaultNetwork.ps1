## Running containers on the default network
## https://github.com/dbafromthecold/SqlServerAndContainersGuide/wiki/Running-SQL-containers-on-the-default-network



## This code will guide you through running SQL containers on the default docker network



# run a container without specifying the network
docker container run -d `
--publish 15789:1433 `
--env ACCEPT_EULA=Y `
--env SA_PASSWORD=Testing1122 `
--name sqlcontainer1 `
mcr.microsoft.com/mssql/server:2019-CU5-ubuntu-18.04



# view the networks available
docker network ls


# inspect the default bridge network
docker network inspect bridge



# blow that container away
docker container rm sqlcontainer1 -f


# spin up another two containers with ping installed (this is a custom image running SQL Server 2019 with ping installed)
docker container run -d `
--env ACCEPT_EULA=Y `
--env MSSQL_SA_PASSWORD=Testing1122 `
--name sqlcontainer2 `
ghcr.io/dbafromthecold/customsql2019-tools:cu5

docker container run -d `
--env ACCEPT_EULA=Y `
--env MSSQL_SA_PASSWORD=Testing1122 `
--name sqlcontainer3 `
ghcr.io/dbafromthecold/customsql2019-tools:cu5



# inspect bridge network again
docker network inspect bridge



# grab the IP addresses directly with
docker inspect sqlcontainer2 --format '{{ .NetworkSettings.IPAddress }}'
docker inspect sqlcontainer3 --format '{{ .NetworkSettings.IPAddress }}'



# test communication between the two containers
docker exec sqlcontainer2 ping 172.17.0.3 -c 4
docker exec sqlcontainer2 ping 172.17.0.2 -c 4



# that works! But referencing the container by name doesn't
docker exec sqlcontainer2 ping sqlcontainer3 -c 4



# blow those containers away
docker rm sqlcontainer2 sqlcontainer3 -f



# spin up two new containers, using the --add-host flag
docker container run -d `
--env ACCEPT_EULA=Y `
--env MSSQL_SA_PASSWORD=Testing1122 `
--add-host=sqlcontainer5:172.17.0.3 `
--name sqlcontainer4 `
ghcr.io/dbafromthecold/customsql2019-tools:cu5

docker container run -d `
--env ACCEPT_EULA=Y `
--env MSSQL_SA_PASSWORD=Testing1122 `
--add-host=sqlcontainer4:172.17.0.2 `
--name sqlcontainer5 `
ghcr.io/dbafromthecold/customsql2019-tools:cu5



# check the containers host file
docker exec sqlcontainer4 cat /etc/hosts
docker exec sqlcontainer5 cat /etc/hosts



# now we can reference the other container by name
docker exec sqlcontainer4 ping sqlcontainer5 -c 4
docker exec sqlcontainer5 ping sqlcontainer4 -c 4
