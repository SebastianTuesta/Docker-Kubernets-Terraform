APP_NAME:=app
INTERNAL_PORT:=8000
EXTERNAL_PORT:=8000

build_run: ../../docker/Dockerfile ../../docker/requirements.txt ../../docker/runserver.sh ../../docker/app/*.py
	docker stop $(shell docker ps -q --filter ancestor=$(APP_NAME)) && echo "$(APP_NAME) deleted!" || echo "$(APP_NAME) doesnt exists!" 
	docker build -t "$(APP_NAME):latest" ../../docker/.
	docker run -p $(EXTERNAL_PORT):$(INTERNAL_PORT) -d $(APP_NAME)
	echo >> build_run