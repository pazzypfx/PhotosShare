FROM ruby:2.3.3

MAINTAINER A. Boudi <abr.boudi@gmail.com>

RUN apt-get update -yqq \
 && apt-get install -qq -y --no-install-recommends \
    build-essential nodejs libpq-dev \
 && rm -rf /var/lib/apt/lists

ENV INSTALL_PATH /usr/src/photosShare
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

VOLUME ["$INSTALL_PATH/public"]

EXPOSE 3000
CMD puma -C config/puma.rb
