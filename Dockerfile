FROM ruby:2.7.2

ENV RUNTIME_PACKAGES="linux-headers libxml2-dev libxslt-dev make gcc libc-dev nodejs tzdata postgresql-dev postgresql" \
    DEV_PACKAGES="build-base curl-dev" \
    HOME="/myapp"

ENV DEBCONF_NOWARNINGS yes

WORKDIR $HOME

# Counter Measure to Error:"Autoprefixer doesn’t support Node v4.8.2. Update it"
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \
        && apt-get install -y nodejs

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

# yarnパッケージ管理ツールインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn


RUN apt-get update && \
    apt-get install -y default-mysql-client \
    postgresql-client \
    sqlite3 \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*


ADD Gemfile      $HOME/Gemfile
ADD Gemfile.lock $HOME/Gemfile.lock

RUN bundle install

ADD ./ $HOME
COPY ./ $HOME

CMD ["rails", "server", "-b", "0.0.0.0"]