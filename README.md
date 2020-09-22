# Description

Container for running a fresh instance of Moodle (moodle.org).

# Running

#### Running the database (recommended for local instance only)
```
docker run --name moodle_db -e POSTGRES_USER=moodleuser -e POSTGRES_PASSWORD=123456 -e POSTGRES_DB=moodle -d -p 5432:5432 postgres
```
#### Building and starting a local container
```
docker build .
docker run --name moodle_web -p 80:8080 -p 8080:8080 -d <image_hash>
```

#### (Or) Running from the docker hub image
```
docker run --name moodle_web -p 80:8080 -p 8080:8080 -d felipecurvelo/moodle-nginx-fpm:latest
```

##### Backlog:
- Create an installation guide
- HTTPS Support

##### References:
- https://github.com/TrafeX/docker-php-nginx
- https://hub.docker.com/r/geekidea/alpine-cron 
- https://medium.com/@geekidea_81313/running-cron-jobs-as-non-root-on-alpine-linux-e5fa94827c34