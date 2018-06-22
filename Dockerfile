FROM ruby:2.5.1-slim

# Install essential Linux packages
RUN apt-get update -qq
RUN apt-get install --yes postgresql-client nodejs
