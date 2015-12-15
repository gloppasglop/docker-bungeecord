# Dockerfile to build a Bungeecord server

FROM centos:latest

MAINTAINER Christophe Roux (gloppasglop)

# Install the required components.
RUN yum -y update; yum clean all
RUN yum -y install \ 
    java-1.8.0-openjdk-headless \
    tmux \
    wget

RUN mkdir /bungeecord && wget -O /bungeecord/BungeeCord.jar http://ci.md-5.net/job/BungeeCord/lastStableBuild/artifact/bootstrap/target/BungeeCord.jar

COPY bc /bungeecord/

RUN groupadd -r bungeecord && \
    useradd -r -g bungeecord -d /bungeecord bungeecord && \
    chown -R bungeecord:bungeecord /bungeecord/ && \
    chmod +x /bungeecord/bc && \
    echo "set -g status off" > ~bungeecord/.tmux.conf

# Expose the recommended ports.
EXPOSE 25565

USER bungeecord
WORKDIR /bungeecord

CMD ["/bungeecord/bc","start"]
