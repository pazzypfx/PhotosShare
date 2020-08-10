FROM ruby:2.6

LABEL maintainer="A. Boudi <abr.boudi@gmail.com>"

RUN apt-get update -yqq \
 && apt-get install -qq -y --no-install-recommends \
    build-essential nodejs libpq-dev ruby-dev graphicsmagick \
 && rm -rf /var/lib/apt/lists

# Install bundler 2
RUN gem install bundler

ENV INSTALL_PATH /app
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle
RUN gem install bundler
ENV PATH="${BUNDLE_BIN}:${PATH}"

COPY . $INSTALL_PATH

VOLUME ["$INSTALL_PATH/public"]

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

