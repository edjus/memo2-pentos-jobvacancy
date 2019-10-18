#!/bin/bash

RACK_ENV=development bundle exec rake db:migrate db:seed
