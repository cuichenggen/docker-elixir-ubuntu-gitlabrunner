FROM senggen/elixir-ubuntu

# install dumb-init
ADD https://github.com/Yelp/dumb-init/releases/download/v1.0.2/dumb-init_1.0.2_amd64 /usr/bin/dumb-init
RUN chmod +x /usr/bin/dumb-init
                                                                                                                                                
# install gitlab-runner
RUN curl -s https://packages.gitlab.com/install/repositories/runner/gitlab-ci-multi-runner/script.deb.sh | bash && \
    apt-get -y update && \
    apt-get -y install gitlab-ci-multi-runner && \
    apt-get -y clean && \
    apt-get -y autoremove

VOLUME ["/etc/gitlab-runner", "/etc/gitlab-runner"]
ADD run.sh /home
RUN chmod +x /home/run.sh

WORKDIR /home/gitlab-runner
CMD /home/run.sh
