# Moodle Docker

Code for running a [Moodle](https:/moodle.org/) fresh instance in a docker container.

## Setting Up

Download moodle source code to the submodule folder.

```bash
git submodule init
git submodule update
```

## Running

#### Run the database (recommended for local environment only)
```
docker run --name moodle_db -e POSTGRES_USER=moodleuser -e POSTGRES_PASSWORD=123456 -e POSTGRES_DB=moodle -d -p 5432:5432 postgres
```
#### Build and start a moodle local container
```bash
docker build .
docker run --name moodle_web -p 80:8080 -p 8080:8080 -d <image_hash>
```

#### (Or) Run from docker hub
```
docker run --name moodle_web -p 80:8080 -p 8080:8080 -d felipecurvelo/moodle-nginx-fpm:latest
```

##### Components
- Linux Alpine
- Niginx
- PHP 7 FPM
- PostgreeSQL
- Crond
- Supervisor


##### Backlog
- Create moodle installation guide
- HTTPS Support

##### References
- [https://github.com/TrafeX/docker-php-nginx](https://github.com/TrafeX/docker-php-nginx) 
- [https://hub.docker.com/r/geekidea/alpine-cron](https://hub.docker.com/r/geekidea/alpine-cron)
- [https://medium.com/@geekidea_81313/running-cron-jobs-as-non-root-on-alpine-linux-e5fa94827c34](https://medium.com/@geekidea_81313/running-cron-jobs-as-non-root-on-alpine-linux-e5fa94827c34)
