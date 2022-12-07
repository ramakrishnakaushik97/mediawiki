all:
	echo "Mediawiki application deployment"
docker:
	docker build -t mediawiki-apache:1.0 ${HOME}/vscode-ws/mediawiki
	docker save mediawiki-apache:1.0 > ${HOME}/mediawiki-apache.tar
	microk8s ctr image import ${HOME}/mediawiki-apache.tar
	rm -rf ${HOME}/mediawiki-apache.tar
installapp:
	microk8s kubectl apply -f mysql/mysql-configMap.yaml
	microk8s kubectl apply -f mysql/mysql-secret.yaml
	microk8s kubectl apply -f mysql/mysql-deployment.yaml
	microk8s kubectl apply -f app/app-configMap-$(ENV).yaml
	microk8s kubectl apply -f app/app-deployment.yaml
