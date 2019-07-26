FROM zeekozhu/aspnetcore-node-deps:3.0.0-preview7.19365.7

# Copy and paste from https://github.com/dotnet/dotnet-docker/blob/master/3.0/aspnet/alpine3.9/amd64/Dockerfile

# Install ASP.NET Core
ENV ASPNETCORE_VERSION 3.0.0-preview7.19365.7

RUN wget -O aspnetcore.tar.gz https://dotnetcli.blob.core.windows.net/dotnet/aspnetcore/Runtime/$ASPNETCORE_VERSION/aspnetcore-runtime-$ASPNETCORE_VERSION-linux-musl-x64.tar.gz \
    && aspnetcore_sha512='1b3f55b9eefe548daa6a8f8ed9be3b2196c3daf8ed896c5e32d8169aceb6e3f8cbc5f7aebb910c19ee8d343255045446c73e6b65366097768263620e72c06667' \
    && echo "$aspnetcore_sha512  aspnetcore.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf aspnetcore.tar.gz -C /usr/share/dotnet \
    && rm aspnetcore.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet
