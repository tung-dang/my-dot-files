

docker_jira() {
    # docker run -d -p 8080:8080 --name 'jira' docker.atlassian.io/apawelczyk/jira:7.3.0
    # Run this to skip the setup process (username and password are both set to"admin"):
    docker run -d -p 8080:8080 --name 'jira' -e 'DB_DRIVER=h2' docker.atlassian.io/apawelczyk/jira:7.3.0
}

docker_login() {
  docker login docker.atl-paas.net
}

docker_login_test() {
  docker pull docker.atl-paas.net/micros/node-refapp
}

docker_remove_unused_images() {
    docker image prune
}

docker_remove_unused_containers() {
    docker container prune
}

docker_remove_volumes() {
    # see: https://github.com/chadoe/docker-cleanup-volumes
    docker volume rm $(docker volume ls -qf dangling=true)
    docker volume ls -qf dangling=true | xargs -r docker volume rm
}

docker_kill_all_containers() {
  echo " - List of all running containers and stopped containers:"
  docker ps -a
  echo " - Start to stop and then remove all containers:"
  docker rm -f $(docker ps -aq)
}

docker_build() {
  CONTAINER_NAME="$1"
  docker build --rm -t "$CONTAINER_NAME:latest"
}

docker_run() {
  CONTAINER_NAME="$1"
  HOST_PORT="$2"
  DOCKER_PORT="$3"
  docker run -d -p "$HOST_PORT:$DOCKER_PORT" --rm -t "$CONTAINER_NAME:latest"
}
