FROM jenkins

USER root

#install node
RUN curl -sL https://deb.nodesource.com/setup_4.x| bash -
RUN apt-get update && apt-get install -y apt-utils && apt-get install -y nodejs
RUN apt-get install -y libtcnative-1

#install grunt
RUN npm install -g grunt-cli mocha istanbul

#drop back to jenkins user
USER jenkins
