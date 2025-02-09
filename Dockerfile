FROM mcr.microsoft.com/dotnet/core/sdk:2.2

# set up node
ENV NODE_VERSION 12.9.1
ENV YARN_VERSION 1.17.3
ENV NODE_DOWNLOAD_SHA 5488e9d9e860eb344726aabdc8f90d09e36602da38da3d16a7ee852fd9fbd91f
ENV NODE_DOWNLOAD_URL https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz

RUN wget "$NODE_DOWNLOAD_URL" -O nodejs.tar.gz \
    && echo "$NODE_DOWNLOAD_SHA  nodejs.tar.gz" | sha256sum -c - \
    && tar -xzf "nodejs.tar.gz" -C /usr/local --strip-components=1 \
    && rm nodejs.tar.gz \
    && npm i -g yarn@$YARN_VERSION \
    && ln -s /usr/local/bin/node /usr/local/bin/nodejs

WORKDIR /
