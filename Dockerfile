FROM ruby:3.2.2-alpine

RUN apk update && apk add --no-cache build-base
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock fido.rb ./
RUN bundle install

COPY ./lib ./lib/
COPY ./bin ./bin/

RUN mkdir ./fetches

ENTRYPOINT ["/usr/local/bin/ruby", "./bin/fido"]
