# FROM ruby:2.4.1-slim
FROM phusion/passenger-ruby24

# Install essential Linux packages
RUN apt-get update -qq
RUN apt-get install --yes postgresql-client nodejs
