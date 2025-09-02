FROM cassandra:4.1

# set test user
ARG ARG_USER=test
ARG ARG_PASS=test
ENV USER=${ARG_USER}
ENV PASS=${ARG_PASS}

# root for package installation
USER root

# test user
RUN useradd -m -s /bin/bash ${USER} && \
    echo "${USER}:${PASS}" | chpasswd

# ssh installation
RUN apt-get update && apt-get install -y --no-install-recommends openssh-server
# ssh configuration
RUN mkdir -p /var/run/sshd && echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
# cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# entrypoint
COPY entry.sh /entry.sh
RUN chmod +x /entry.sh

# wrapper to modify original cassandra entry
ENTRYPOINT ["/entry.sh"]
CMD ["cassandra", "-f"]
