## Putting everything together in a dockerfile to build a custom SQL Server image
## https://github.com/dbafromthecold/SqlServerAndContainersGuide/wiki/Let's-go-nuts!-Creating-a-custom-SQL-Server-image-from-scratch-with-a-database-ready-to-go!



## This code will guide you through creating a custom SQL Server 2019 container image



# navigate to where the dockerfile is and build the image
docker image build -t customsqlimage1 .



# confirm that the image is there
docker image ls



# run a container from the custom image
docker container run -d `
-p 15789:1433 `
--env ACCEPT_EULA=Y `
--env MSSQL_SA_PASSWORD=Testing1122 `
--name sqlcontainer1 `
customsqlimage1



# confirm the container is running
docker container ls -a



# confirm that the database is there
mssql-cli -S localhost,15789 -U sa -P Testing1122 -Q "SELECT [name] FROM sys.databases;"


