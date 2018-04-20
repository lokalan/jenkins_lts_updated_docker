FROM jenkins/jenkins:lts

# We have to switch the container user to root in order to leverage Docker containers as build agents
USER root

# Remove existing (older) version of Docker from the base image
RUN apt-get update \
 && apt-get remove -y docker docker.io \
 && apt-get install -y apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common
 
# Install the newest version of Docker
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add - \
 && add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable" \
 && apt-get update \
 && apt-get install -y docker-ce