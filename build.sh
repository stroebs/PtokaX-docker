#!/bin/bash

# do not continue script on errors
set -eou pipefail

set -x

BASEDIR=/root
SRCDIR=/root/PtokaX

cd ${BASEDIR}

# Stop dpkg-reconfigure tzdata from prompting for input
export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get -y upgrade

# See PtokaX/compile.txt
apt-get -y install wget make g++ zlib1g-dev libtinyxml-dev liblua5.4-dev

# Download PtokaX
wget -q http://www.ptokax.org/files/0.5.3.0-nix-src.tgz
tar xf 0.5.3.0-nix-src.tgz

cd ${SRCDIR}

# Hack the makefile for static build
sed -i 's/^CXX = c++$/CXX = c++ -static/' makefile

# Build static binary and strip debug symbols
make

strip PtokaX
