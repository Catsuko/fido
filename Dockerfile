FROM ruby:3.2.2-alpine

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock fido.rb ./

RUN bundle config --global frozen 1

RUN apk update \
    && apk add --no-cache build-base \
    && bundle install \
    && apk del build-base

COPY ./lib ./lib/
COPY ./bin ./bin/

RUN mkdir ./fetches

ENTRYPOINT ["/usr/local/bin/ruby", "./bin/fido"]
