docker-compose -f docker-compose-local.yml build
docker-compose -f docker-compose-local.yml up -d

docker-compose -f docker-compose-prod.yml build
docker-compose -f docker-compose-prod.yml up -d