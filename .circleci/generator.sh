#!/bin/bash

DEV_BUILD=$1
cat > main.yml \<<- "EOF"

version: 2.1
parameters:
  run_dev:
    type: boolean
    default: $DEV_BUILD


jobs:
  build:
    docker:
      - image: cimg/ruby:2.7.1-node
    steps:
      - checkout
      - run:
          name: "Update Node.js and npm"
          command: |
            curl -sSL "https://nodejs.org/dist/v11.10.0/node-v11.10.0-linux-x64.tar.xz" | sudo tar --strip-components=2 -xJ -C /usr/local/bin/ node-v11.10.0-linux-x64/bin/node
            curl https://www.npmjs.com/install.sh | sudo bash
      - run:
          name: Check current version of node
          command: node -v
          
workflows:
  build-code-wf:
    when:
      or:
        - << pipeline.parameters.run_dev >>
    jobs:
      - build

EOF