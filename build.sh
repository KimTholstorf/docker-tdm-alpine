set -ex
# docker hub username
USERNAME=kimtholstorf
# image name
IMAGE=tdm
docker build -t $USERNAME/$IMAGE:latest .