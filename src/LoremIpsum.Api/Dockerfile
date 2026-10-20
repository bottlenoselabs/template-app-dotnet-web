FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

COPY src/Directory.Build.props src/Directory.Packages.props src/
COPY src/LoremIpsum.Core/LoremIpsum.Core.csproj src/LoremIpsum.Core/
COPY src/LoremIpsum.Infrastructure/LoremIpsum.Infrastructure.csproj src/LoremIpsum.Infrastructure/
COPY src/LoremIpsum.Api/LoremIpsum.Api.csproj src/LoremIpsum.Api/
RUN dotnet restore src/LoremIpsum.Api/LoremIpsum.Api.csproj

COPY src/LoremIpsum.Core/ src/LoremIpsum.Core/
COPY src/LoremIpsum.Infrastructure/ src/LoremIpsum.Infrastructure/
COPY src/LoremIpsum.Api/ src/LoremIpsum.Api/
RUN dotnet publish src/LoremIpsum.Api/LoremIpsum.Api.csproj -c Release -o /app --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS runtime
WORKDIR /app
COPY --from=build /app .
EXPOSE 8080
ENTRYPOINT ["dotnet", "LoremIpsum.Api.dll"]
