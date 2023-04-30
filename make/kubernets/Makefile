APP_NAME:=api

build: ../../docker/Dockerfile ../../docker/requirements.txt ../../docker/runserver.sh ../../docker/app/*.py
	docker build -t "$(APP_NAME):latest" ../../docker/.
	echo >> build

secret: ../../env/.env
	kubectl delete secrets/my-secrets
	kubectl create secret generic my-secrets --from-env-file=../env/.env
	echo >> secret

postgres-pvc-pv: postgres-pvc-pv.yaml
	kubectl apply -f postgres-pvc-pv.yaml
	echo >> postgres-pvc-pv

postgres-deployment: postgres-deployment.yaml postgres-pvc-pv secret
	kubectl delete deployments/postgres
	kubectl apply -f postgres-deployment.yaml
	echo >> postgres-deployment

postgres-service: postgres-deployment postgres-pvc-pv secret
	kubectl apply -f postgres-service.yaml
	echo >> postgres-service

api-deployment: postgres-deployment.yaml build secret
	kubectl delete deployments/api-demo
	kubectl apply -f api-deployment.yaml
	echo >> api-deployment

api-service: api-service.yaml api-deployment
	kubectl apply -f api-service.yaml
	echo >> api-service