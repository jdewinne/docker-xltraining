FROM ubuntu:latest
MAINTAINER Joris De Winne <jdewinne@xebialabs.com>
RUN apt-get update
RUN apt-get install -y python-pip openssh-server supervisor zip
RUN pip install jinja2
RUN pip install markdown

RUN echo "root:xltraining" | chpasswd

ADD "resources/sshd_config" "/etc/ssh/sshd_config"
ADD "resources/supervisord.conf" "/etc/supervisor/conf.d/supervisord.conf"
RUN chmod 644 /etc/ssh/sshd_config
RUN mkdir -p /var/log/supervisor /var/run/sshd

VOLUME /data
WORKDIR /data

EXPOSE 22
CMD ["/usr/bin/supervisord"]
CMD ["/data/generate_all_decks.sh"]
