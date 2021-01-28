#!/bin/bash

# Ubuntu dependency installation script for Cyrus IMAP libs
# Tested on Ubuntu 20.10 (groovy)

# General build dependencies (assuming git is already installed)
BUILD_ENV_DEPS="sudo cmake check build-essential tcl autoconf automake libtool"
BUILD_ENV_DEPS="${BUILD_ENV_DEPS} pkg-config bison flex libssl-dev libxml2-dev"
BUILD_ENV_DEPS="${BUILD_ENV_DEPS} uuid-dev libicu-dev texinfo"

# Libjansson dependencies
JANSSON_DEPS="zlib1g zlib1g-dev libglib2.0-dev"

# Xapian dependencies
XAPIAN_DEPS="graphviz doxygen python3-docutils help2man libmagic-dev"

# Libwslay dependencies
LIBWSLAY_DEPS="sphinx-doc"

apt-get install -y ${BUILD_ENV_DEPS} ${JANSSON_DEPS} ${XAPIAN_DEPS} ${LIBWSLAY_DEPS}
