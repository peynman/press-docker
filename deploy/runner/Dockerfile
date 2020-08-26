FROM gitlab/gitlab-runner:latest

RUN apt-get update -y && apt-get install rsync -y
RUN apt-get install -y openssh-client

USER root

RUN mkdir -p /home/gitlab-runner/.ssh
COPY ./ssh/runner_id_rsa /home/gitlab-runner/.ssh/id_rsa
COPY ./ssh/runner_id_rsa.pub /home/gitlab-runner/.ssh/id_rsa.pub

RUN touch /home/gitlab-runner/.ssh/known_hosts
RUN ls -lah /home/gitlab-runner/.ssh/
RUN chmod 644 -R /home/gitlab-runner/.ssh
RUN chown gitlab-runner:gitlab-runner -R /home/gitlab-runner/.ssh

USER gitlab-runner
