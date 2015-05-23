# Live Demo
http://mtgmgmt.herokuapp.com
## Code Status
[![Build Status](https://travis-ci.org/roadhouse/mtgmgmt.svg?branch=master)](https://travis-ci.org/roadhouse/mtgmgmt)
[![Code Climate](https://codeclimate.com/github/roadhouse/mtgmgmt/badges/gpa.svg)](https://codeclimate.com/github/roadhouse/mtgmgmt)
[![Test Coverage](https://codeclimate.com/github/roadhouse/mtgmgmt/badges/coverage.svg)](https://codeclimate.com/github/roadhouse/mtgmgmt)
[![Dependency Status](https://www.versioneye.com/user/projects/546ab3c09508257317000146/badge.svg?style=flat)](https://www.versioneye.com/user/projects/546ab3c09508257317000146)

## Description of Contents

I try to isolate all business logic in `lib` dir, so the rails app has only the basic code to glue things.

`lib/orthanc/` The "Query Service" responsable to make complex query using arel, like top decks (decks most playables) and a basic card finder.

`lib/laracna` this crawler has two functions:
* consume cards from [mtgapi.com](http://mtgapi.com/) (a JSON API) 
* consume decks from [mtgdecks.net](http://www.mtgdecks.net/) and [decklists.net](http://www.decklists.net/) using `nokogiri`

