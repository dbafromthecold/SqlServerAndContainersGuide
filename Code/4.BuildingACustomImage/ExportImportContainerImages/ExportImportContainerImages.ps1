## Building a custom image
## https://github.com/dbafromthecold/SqlServerAndContainersGuide/wiki/Exporting-and-Importing-Container-Images



## This code will guide you exporting and then importing a Docker image



# view the image built previously
# SqlServerAndContainersGuide/4.BuildingACustomImage/CustomSqlImage/BuildingACustomImage.ps1
docker image ls



# export that image by running
docker save sqlimage1 -o C:\temp\sqlimage1.tar



# remove the existing image
docker rmi sqlimage1



# load the image from the file
docker load -i C:\temp\sqlimage1.tar



# confirm that the image is there:
docker image ls