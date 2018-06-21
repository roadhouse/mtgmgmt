#!/bin/bash
echo "Bundling"
bundle check || bundle install  -j 5 -r 5

echo "Server..."
echo rails s
bundle exec rails s -b 0.0.0.0
