# Prepare web release
FROM plugfox/flutter:stable-web AS build

# USER root
WORKDIR /home

# Copy app source code and compile it
COPY --chown=101:101 client client
COPY --chown=101:101 shared shared

RUN set -eux; \
    # Change directory to client for monorepo
    cd client \
    # Ensure packages are still up-to-date if anything has changed
    && flutter pub get \
    # Codegeneration
    && flutter pub run build_runner build --delete-conflicting-outputs --release \
    # Localization
    #&& flutter pub global run intl_utils:generate
    # Build web release (opt --tree-shake-icons)
    && flutter build web --release --no-source-maps \
        --pwa-strategy offline-first \
        --web-renderer auto --base-href /

# Production from scratch
FROM nginx:alpine as production

COPY --from=build --chown=101:101 /home/client/build/web /usr/share/nginx/html

# Expose server
EXPOSE 80/tcp
