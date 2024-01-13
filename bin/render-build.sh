#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
sudo ./bin/rails assets:precompile
sudo ./bin/rails assets:clean 