# docker build
# docker pull registry.plugfox.dev/dart-job-auth

# Base
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80/tcp

# Build
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY server/jwt_validator_firebase/JwtValidatorFirebase/JwtValidatorFirebase.csproj JwtValidatorFirebase/
RUN dotnet restore "JwtValidatorFirebase/JwtValidatorFirebase.csproj"
COPY server/jwt_validator_firebase/ .
WORKDIR "/src/JwtValidatorFirebase"
RUN dotnet build "JwtValidatorFirebase.csproj" -c Release -o /app/build

# Publish
FROM build AS publish
RUN dotnet publish "JwtValidatorFirebase.csproj" -c Release -o /app/publish

# Final
FROM base AS final
WORKDIR /app

COPY --from=publish /app/publish .
ADD server/jwt_validator_firebase/JwtValidatorFirebase/dart-job-jwt-validator-firebase.json dart-job-jwt-validator-firebase.json

# Add lables
LABEL name="registry.plugfox.dev/dart-job-auth" \
      vcs-url="https://github.com/PlugFox/dart-jobs" \
      github="https://github.com/PlugFox/dart-jobs" \
      maintainer="Plague Fox <plugfox@gmail.com>" \
      authors="@plugfox" \
      family="PlugFox/dart-jobs"

# Start server.
EXPOSE 80/tcp

CMD ["dotnet", "JwtValidatorFirebase.dll"]
