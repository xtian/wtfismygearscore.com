FROM ruby:2.7.1-alpine AS build

ARG RAILS_ROOT=/app

ENV BUNDLE_DEPLOYMENT=true
ENV BUNDLE_JOBS=4
ENV BUNDLE_WITHOUT=development:test
ENV RAILS_ENV=production

WORKDIR $RAILS_ROOT

RUN apk update && \
    apk upgrade && \
    apk add --update --no-cache build-base nodejs postgresql-dev tzdata

COPY . .

RUN bin/bundle install && \
    find vendor/bundle/ruby/2.7.0/gems/ -name "*.c" -delete && \
    find vendor/bundle/ruby/2.7.0/gems/ -name "*.o" -delete

RUN bin/rake assets:precompile && \
    rm -rf app/assets vendor/assets

FROM ruby:2.7.1-alpine

ARG RAILS_ROOT=/app

ENV PUMA_MAX_THREADS=5
ENV RACK_ENV=production
ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true

WORKDIR $RAILS_ROOT

RUN apk update && \
    apk upgrade && \
    gem install foreman --conservative

COPY --from=build $RAILS_ROOT $RAILS_ROOT

EXPOSE 3000
HEALTHCHECK CMD curl -f http://localhost:3000/ping.txt || exit 1

CMD ["foreman", "start"]
