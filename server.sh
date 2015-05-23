#!/bin/bash

cwd=$(pwd)
cd server/
bundle install
# rackup -sPuma -Eproduction -p3000 config.ru
puma -p3000 config.ru
cd $cwd
