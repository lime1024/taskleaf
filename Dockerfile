FROM ruby:2.5.3

RUN apt update && apt install -y --no-install-recommends nodejs

WORKDIR /var/taskleaf

RUN gem uninstall bundler && gem install bundler -v 2.0.1

COPY Gemfile Gemfile.lock ./

RUN bundle install
