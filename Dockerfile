FROM homebrew/ubuntu20.04:3.4.2

ENV TIMEZONE "Europe/Warsaw"
ENV DEBIAN_FRONTEND=noninteractive

# Setup time zones.
RUN sudo ln -snf "/usr/share/zoneinfo/$TIMEZONE" /etc/localtime && \
  echo $TIMEZONE | sudo tee /etc/timezone

ENV DOCKERIZED true

# Configure dotfiles.
USER root
RUN apt update
COPY ./setup.sh /tmp/setup.sh
RUN /tmp/setup.sh

# Start zsh login shell.
CMD ["zsh", "-l"]
