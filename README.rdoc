== Code Status
https://travis-ci.org/roadhouse/mtgmgmt
![travis](https://api.travis-ci.org/roadhouse/mtgmgmt.png?branch=master)
[![Code Climate](https://codeclimate.com/github/roadhouse/mtgmgmt/badges/gpa.svg)](https://codeclimate.com/github/roadhouse/mtgmgmt)
[![Test Coverage](https://codeclimate.com/github/roadhouse/mtgmgmt/badges/coverage.svg)](https://codeclimate.com/github/roadhouse/mtgmgmt)

== Description of Contents

I try to isolate all business logic in lib dir, so the rails app has only the basic code to glue things.

=== lib/orthanc/

A "Query Service" responsable to make complex query using arel, like top decks (decks more playables) and a basic card finder.

