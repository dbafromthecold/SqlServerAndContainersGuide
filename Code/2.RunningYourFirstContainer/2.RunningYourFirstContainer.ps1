
# searching for a sql server image on the docker hub
docker search mssql



# bah, that doesn't work anymore, the images are out-of-date as they're now on the MCR
# so let's have a look at the MCR
$repo1 = invoke-webrequest https://mcr.microsoft.com/v2/mssql/server/tags/list
$repo2 = invoke-webrequest https://mcr.microsoft.com/v2/mssql/rhel/server/tags/list
$tags = $repo1.content + $repo2.content
$tags



# and let's pull an image down
docker image pull mcr.microsoft.com/mssql/server:2019-CU5-ubuntu-18.04



# confirm the image is local
docker image ls



# and let's run a container from it
docker container run -d `
-p 15789:1433 `
--env ACCEPT_EULA=Y `
--env MSSQL_SA_PASSWORD=Testing1122 `
--name sqlcontainer1 `
mcr.microsoft.com/mssql/server:2019-CU5-ubuntu-18.04



# confirm that the container is running
docker container ls -a



# let's connect SQL within the container and run a query
mssql-cli -S 'localhost,15789' -U sa -P Testing1122 -Q "SELECT @@VERSION AS [Version]"



# we can also jump into the container itself
docker container exec -it sqlcontainer1 bash



# navigate around - in this case I'm having a look at the system databases' location
cd /var/opt/mssql/data
ls -al
exit



# but we could also run...
docker exec sqlcontainer1 /bin/bash -c "ls -al /var/opt/mssql/data"