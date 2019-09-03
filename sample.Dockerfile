# Sample contents of Dockerfile
# Stage 1
FROM kalthurion/node-net-core-sdk AS builder
WORKDIR /source

# caches restore result by copying csproj file separately
COPY *.csproj .
COPY ./ClientApp/*.json ./ClientApp/
COPY ./ClientApp/yarn.lock ./ClientApp/

RUN dotnet restore && cd ClientApp && yarn

# copies the rest of your code
COPY . .
RUN dotnet publish --output /app/ --configuration Release

# Build runtime image
FROM microsoft/dotnet:2.2-aspnetcore-runtime-alpine

RUN apk --no-cache add shadow && \
    groupadd -g 998 serviceuser && \
    useradd -r -m -u 999 -g serviceuser serviceuser && \
    chown -R serviceuser:serviceuser /home/serviceuser && \
    chmod -R 700 /home/serviceuser

WORKDIR /home/serviceuser

COPY --from=builder /app/out .

USER serviceuser

EXPOSE 8080

ENTRYPOINT ["dotnet", "MyApp.dll"]