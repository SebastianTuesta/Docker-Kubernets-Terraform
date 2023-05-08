1. Docker
    * cd make/docker
    * make build_run

2. Docker compose
    * cd make/docker_compose
    * make up

3. Kubernets
    ![Kubernets](kubernets/kubernets.jpg)

    * minikube start
    * minikube -p minikube docker-env --shell powershell | Invoke-Expression
    * minikube tunnel (in other window)
    * cd make/Kubernets
    * make postgres
    * make api-service

4. Terraform
    * cd terraform
    * terraform init
    * terraform validate
    * terraform plan -var-file="dev.tfvars"
    * terraform apply -var-file="dev.tfvars" --auto-approve