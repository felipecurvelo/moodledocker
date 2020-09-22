FROM ubuntu:latest

ADD moodlecron /etc/cron.d/hello-cron
RUN chmod 0644 /etc/cron.d/hello-cron
RUN touch /var/log/cron.log

RUN apk update
RUN apk add crontab curl

CMD crontab && tail -f /var/log/cron.log