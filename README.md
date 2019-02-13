# Pyrex Utilites

[![Build Status](https://travis-ci.org/JoshuaWatt/pyrex-utilities.svg?branch=master)](https://travis-ci.org/JoshuaWatt/pyrex-utilities)

Builds a number of utilities that are used in Pyrex builds so that they don't
have to be compiled on the fly when the Docker image is built. All utilities
are statically linked to avoid the need for any dependencies

## setpriv
This is part of the util-linux package and is useful for dropping permissions
in images. It was added to util-linux fairly recently and thus is not present
in Ubuntu 16.04 or 14.04

## tini
Compiles tini with a custom patch required for post-processing commands (see
https://github.com/krallin/tini/pull/129)

## icecream
Builds a bleeding edge version of icecream to fix a bug in the latest release
