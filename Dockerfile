FROM ruby:2.5-slim

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

COPY . $INSTALL_PATH

VOLUME ["$INSTALL_PATH/public"]

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
# Add bundle entry point to handle bundle cache

ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"
