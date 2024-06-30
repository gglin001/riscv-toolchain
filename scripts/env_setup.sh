#!/bin/bash

# manually download & install micromamba from:
# https://github.com/mamba-org/micromamba-releases/releases
#
# curl -O -L https://github.com/mamba-org/micromamba-releases/releases/latest/download/micromamba-osx-arm64
# curl -O -L https://github.com/mamba-org/micromamba-releases/releases/latest/download/micromamba-linux-aarch64
# curl -O -L https://github.com/mamba-org/micromamba-releases/releases/latest/download/micromamba-linux-64
# or
# bash <(curl -L https://micro.mamba.pm/install.sh)

# for newlib
micromamba install texinfo

# TODO: check more needed tools & libs
