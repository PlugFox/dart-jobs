FROM dart:beta AS build

WORKDIR /app

COPY ./shared /app/shared
COPY ./server /app/server

# Ensure packages are still up-to-date if anything has changed
RUN cd server && dart pub get \
   #&& dart pub run build_runner build --delete-conflicting-outputs \
    && dart compile exe bin/job.dart -o bin/server

# Build minimal serving image from AOT-compiled `/server` and required system
# libraries and configuration files stored in `/runtime/` from the build stage.
#FROM scratch
FROM curlimages/curl AS production

COPY --from=build /runtime/ /
COPY --from=build /app/server/bin/server /app/bin/

LABEL name="registry.plugfox.dev/dart-jobs-service" \
      vcs-url="https://github.com/PlugFox/dart-jobs" \
      github="https://github.com/PlugFox/dart-jobs" \
      maintainer="Plague Fox <plugfox@gmail.com>" \
      authors="@plugfox" \
      family="plugfox/dart-jobs"

ENV PORT=80
EXPOSE 80/tcp

ENTRYPOINT ["/app/bin/server", "--port=80"]