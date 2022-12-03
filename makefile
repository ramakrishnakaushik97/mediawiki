all:
	echo "Mediawiki application deployment"
docker:
	curl -o /tmp/mediawiki-1.39.0.tar.gz https://releases.wikimedia.org/mediawiki/1.39/mediawiki-1.39.0.tar.gz
	mkdir -p ${HOME}/app_src
	tar -xvzf /tmp/mediawiki-1.39.0.tar.gz -C ${HOME}/app_src/
	cp -r ${HOME}/app_src/* ${HOME}/vscode-ws/mediawiki/src/
	chmod 777 ${HOME}/vscode-ws/mediawiki/src/
	docker build -t mediawiki-apache:1.4 ${HOME}/vscode-ws/mediawiki
	docker save mediawiki-apache:1.4 > ${HOME}/mediawiki-apache.tar
	microk8s ctr image import ${HOME}/mediawiki-apache.tar
installapp:
	microk8s kubectl apply -f app/app-storage.yaml
	microk8s kubectl apply -f app/app-deployment.yaml
clean:
	rm -rf /tmp/mediawiki-1.39.0.tar.gz
	rm -rf ${HOME}/app_src
	