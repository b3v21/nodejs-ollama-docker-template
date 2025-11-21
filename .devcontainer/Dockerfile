FROM node:24

# Install pnpm globally
RUN npm install -g pnpm

RUN apt update

RUN apt -y install postgresql \
    postgresql-client \
    ripgrep \
    git \
    fd-find \
    net-tools

# allow passwordless sudo
RUN apt-get install -y sudo \
    && echo node ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/node \
    && chmod 0440 /etc/sudoers.d/node

# Install and generate locales
RUN apt-get install -y locales && \
    sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /home/node/work

COPY . .

# Use the node user that comes with the image
USER node