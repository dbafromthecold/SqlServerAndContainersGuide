## Building a custom image from scratch
## https://github.com/dbafromthecold/SqlServerAndContainersGuide/wiki/Build-a-custom-SQL-Server-image-from-scratch



## This code will guide you through creating a custom SQL Server 2019 container image from scratch



# navigate to the location of the dockerfile and build the image: -
docker build -t customsqlimage1 .



# spin up a container from the image: -
docker container run -d `
-p 15789:1433 `
--env ACCEPT_EULA=Y `
--env MSSQL_SA_PASSWORD=Testing1122 `
--name sqlcontainer1 `
customsqlimage1



# confirm that the container is running: -
docker container ls -a



# connect to SQL within the container: -
mssql-cli -S localhost,15789 -U sa -P Testing1122 -Q "SELECT @@VERSION AS [Version];"
