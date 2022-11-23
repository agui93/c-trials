#!/bin/bash

if [ ! -d cmake-build ]; then
  mkdir -p cmake-build
fi

cd cmake-build

cmake ../

make

echo "Test"
./Tutorial 4
