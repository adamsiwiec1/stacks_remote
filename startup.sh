bash scripts/docker_install.sh -y && \
bash scripts/volumes.sh && \
bash scripts/portainer.sh && \  # portainer used for ease of monitoring
git clone https://github.com/adamsiwiec1/stacks.git && \
bash scripts/deploy_stacks.sh