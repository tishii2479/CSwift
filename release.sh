#!/bin/zsh

swift build -c release
cp -f ./.build/release/CSwift /usr/local/bin
