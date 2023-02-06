FROM elixir:1.14.0-alpine as build
ENV APP_NAME=cache_utility_service
RUN apk add build-base

WORKDIR /app
COPY . /app

RUN mix local.hex --force \
    && mix local.rebar --force \
    && mix deps.get \
    && mix deps.compile \
    && mkdir -p /app/_build/prod/rel/$APP_NAME/releases/RELEASES \
    && MIX_ENV=prod mix distillery.release \
    && rm -rf /app/_build/prod/rel/$APP_NAME/etc


FROM elixir:1.14.0-alpine
ENV APP_NAME=cache_utility_service
WORKDIR /app
EXPOSE 8082
RUN apk update && apk upgrade && apk add bash && mkdir -p /app/rel/$APP_NAME/var && chown -R nobody:nobody /app/rel/$APP_NAME/var
COPY --from=build /app/_build/prod /app
VOLUME /app/rel/$APP_NAME/etc
RUN chown -R nobody: /app
USER nobody
ENTRYPOINT exec /app/rel/$APP_NAME/bin/$APP_NAME foreground