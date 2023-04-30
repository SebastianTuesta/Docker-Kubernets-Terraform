APP_NAME:=app
DB_NAME:=postgress

up: ../../docker_compose/.env ../../docker_compose/docker-compose.yml ../../docker/Dockerfile ../../docker/requirements.txt ../../docker/runserver.sh ../../docker/app/*.py
	docker-compose -f ../../docker_compose/docker-compose.yml down --rmi all -v --remove-orphans
	docker-compose -f ../../docker_compose/docker-compose.yml --env-file ../../env/.env up -d
	echo >> up