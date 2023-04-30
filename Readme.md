1. Docker
    cd make
    make make/build

2. Docker compose
    cd make/docker_compose
    make up

3. Kubernets
    ![Kubernets](kubernet/kubernets.jpg)

    minikube start
    minikube -p minikube docker-env --shell powershell | Invoke-Expression
    minikube tunnel (in other window)
    cd make/Kubernets
    make postgres
    make api-service