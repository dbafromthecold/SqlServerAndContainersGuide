## Building a custom image
## https://github.com/dbafromthecold/SqlServerAndContainersGuide/wiki/Pushing-an-image-to-the-Docker-Hub



## This code will guide you through pushing an image to the Docker Hub



# view the images locally
    docker image ls



# create a repository on the Docker Hub, then login
docker login



# tag the custom image with the repository name
docker tag sqlimage1 dbafromthecold/testsqlrepository:testimage



# confirm the image has been tagged
docker image ls



# push it up to the hub
docker push dbafromthecold/testsqlrepository:testimage



# the image is now on the Docker Hub and can be pulled down
docker pull dbafromthecold/testsqlrepository:testimage
