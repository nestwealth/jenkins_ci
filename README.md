# Continous Integration Setup

We are using Jenkins for continous integration (CI). Travis is too expensive for our current needs. We're also using Docker as a proof of concept and to get experience with using the tool.

## Docker Containers
The following docker containers are needed to run jenkins CI:

- ci_key_server
- mongo
- mysql

## Build Information

This image is based on the [official jenkins image](https://hub.docker.com/_/jenkins/). We install `node.js` and `libtcnative` via apt and `grunt-cli`, `mocha`, and `istanbul` via `npm install -g`. See [Jenkins Image Setup][Jenkins Image Setup] for how to generate the image.

The Join API build works in the following way:

1. Check out the specified branch from github by polling every 10 minutes
  * Using the *nest-dev-ci* user with SSH credentials
  * Ignoring submodules for now
2. Initialize the submodules
  * We need to overwrite `.gitmodules` with `ci.gitmodules`. This is because we're using ssh authentication instead of http.
  * After we get the submodules, run `npm install`
3. Install node modules
4. Run unit tests & generate coverate
5. Publish coverage & unit test reports

# Mongo Docker setup

To create mongo container:
```
docker run -d --name ci_mongo mongo
```

# Mysql Docker Setup

To create mysql container:
```
docker run -d --name ci_mysql -e MYSQL_ROOT_PASSWORD=nestwealth -e MYSQL_DATABASE=unittestnw mysql
```

# Key Server Docker Setup

See instructions in `key_server` to create image & container

# Jenkins Docker Setup

You'll first need to create the docker image, then the container.

## Jenkins Image Setup

To create the docker image run the following:
```
docker build -t nestwealth/jenkins .
```

## Jenkins Container Setup

To create the docker container run:
```
docker run -d --link ci_mongo --link ci_mysql --link ci_key_server --name ci_jenkins -p 8080:8080 -p 50000:50000 -v [volume_location]:/var/jenkins_home -e JAVA_OPTS="-Duser.timezone=America/Toronto -Dorg.apache.commons.jelly.tags.fmt.timeZone=America/Toronto" nestwealth/jenkins
```
where ```volume_location``` is the location of where the volume will be mounted. This is useful so that if we update the image or container we can still use the same Jenkins configuration
