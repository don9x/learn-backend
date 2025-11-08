## Learn backend

```console
#
# Build the container
#
docker build -t learn-backend:latest .

#
# List images
#
docker image ls

#
# Runt the container
#
docker container run --rm -p 8080:8080 --name learn-backend:latest learn-backend

#
# Test 
#
curl -fssL localhost:8080/ping | jq

#
# GH PAT token generate
#
gh auth status
gh auth token create \
  --scopes write:packages,read:packages,delete:packages \
  --description "GHCR upload token"

export USERNAME=don9x
export GITHUB_TOKEN=XYZ

#
# Docker login to GHCR.io
#
echo $GITHUB_TOKEN | docker login ghcr.io -u $USERNAME --password-stdin

#
# TAG the image for GHCR.io
#
docker tag learn-backend:latest ghcr.io/$USERNAME/learn-backend:latest
docker image ls

#
# PUSH image to GHCR.io
#
docker push ghcr.io/$USERNAME/learn-backend:latest

#
# Check if the container is uploaded
#
gh api user/packages?package_type=container

#
# Make the container public (or change manually on WebUI)
#
gh api \
  -X PATCH \
  -H "Accept: application/vnd.github+json" \
  /user/packages/container/learn-backend \
  -f visibility=public

#
# (Optional) Clear all cache
#
docker system prune -fa

#
#
#
docker run -p 8080:8080 --rm --name learn-backend ghcr.io/don9x/learn-backend:latest

```
