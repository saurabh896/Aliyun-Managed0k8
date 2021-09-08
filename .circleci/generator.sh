#!/bin/bash

DEV_BUILD=$1
cat << EOF > .circleci/main.yaml
version: 2.1
jobs:
  job1:
    docker:
      - image: cimg/base:2021.04
    steps:
      - run: echo $DEV_BUILD
workflows:
  workflow1:
    jobs:
      - job1
EOF
      