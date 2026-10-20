FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src
RUN apt-get update && apt-get install -y --no-install-recommends python3 && rm -rf /var/lib/apt/lists/*
RUN dotnet workload install wasm-tools

COPY src/Directory.Build.props src/Directory.Packages.props src/
COPY src/LoremIpsum.Core/LoremIpsum.Core.csproj src/LoremIpsum.Core/
COPY src/LoremIpsum.Web/LoremIpsum.Web.csproj src/LoremIpsum.Web/
RUN dotnet restore src/LoremIpsum.Web/LoremIpsum.Web.csproj

COPY src/LoremIpsum.Core/ src/LoremIpsum.Core/
COPY src/LoremIpsum.Web/ src/LoremIpsum.Web/
RUN dotnet publish src/LoremIpsum.Web/LoremIpsum.Web.csproj -c Release -o /app --no-restore

FROM nginx:alpine AS runtime
COPY --from=build /app/wwwroot /usr/share/nginx/html
COPY src/LoremIpsum.Web/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
