FROM ubuntu:16.04

MAINTAINER darrell.breeden@cimplx.com

ADD	Rowland /app


WORKDIR /app

#Get updates to install apt-transport-https
RUN 	apt-get update && \
		apt-get install -y apt-transport-https curl
		
#Add node references and update to install node		
RUN		curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
ADD 	nodesource.list /etc/apt/sources.list.d/nodesource.list
ADD		nodepreferences /etc/apt/preferences.d/nodepreferences

##Specify to install from the non default repository
RUN		apt-get update && \
		apt-get install -y nodejs libpoppler-qt4-dev libcairo2-dev

RUN 	npm install -g sails && \
		cd /app && npm install

EXPOSE 443
EXPOSE 80
EXPOSE 1337

CMD ["sails","lift"]