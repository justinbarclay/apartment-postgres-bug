FROM mcr.microsoft.com/devcontainers/ruby:3.4

# Install Rails dependencies
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends postgresql-client
