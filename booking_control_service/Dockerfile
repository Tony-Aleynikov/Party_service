FROM ruby:2.7

WORKDIR /app

COPY Gemfile* .
RUN gem install bundler
RUN bundle install

EXPOSE 3002
