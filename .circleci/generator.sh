#!/bin/bash

DEV_BUILD=$1
cat << EOF > main.yaml
version: 2.1
jobs:
  job1:
    docker:
      - image: cimg/base:2021.04
    steps:
      - run: echo $TF_ENV
workflows:
  workflow1:
    jobs:
      - job1
EOF
      