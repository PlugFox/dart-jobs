FROM dart:beta AS build

# Resolve app dependencies.
WORKDIR /app
COPY pubspec.* ./
RUN dart pub get

# Copy app source code and AOT compile it.
COPY . .
# Ensure packages are still up-to-date if anything has changed
RUN dart pub get --offline \
#   && dart pub run build_runner build --delete-conflicting-outputs \
    && dart compile exe bin/job.dart -o bin/server

# Build minimal serving image from AOT-compiled `/server` and required system
# libraries and configuration files stored in `/runtime/` from the build stage.
FROM scratch

COPY --from=build /runtime/ /
COPY --from=build /app/bin/server /app/bin/

# Add lables
LABEL name="registry.plugfox.dev/dart-jobs-service" \
      vcs-url="https://github.com/PlugFox/dart-jobs" \
      github="https://github.com/PlugFox/dart-jobs" \
      maintainer="Plague Fox <plugfox@gmail.com>" \
      authors="@plugfox" \
      family="plugfox/dart-jobs"

# Start server.
EXPOSE 9090/tcp

ENTRYPOINT ["/app/bin/server", "--port=9090"]