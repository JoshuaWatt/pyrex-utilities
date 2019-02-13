#! /bin/bash
#
# Copyright 2019 Garmin Ltd. or its subsidiaries
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

. $(dirname $0)/setup.sh

mkdir icecream
cd icecream

ICECREAM_SHA1=e39103ff5fb6aa7e939b486df25d621696ba1d6f
wget -O icecream.tar.gz https://github.com/icecc/icecream/archive/${ICECREAM_SHA1}.tar.gz
tar -xvzf icecream.tar.gz
cd icecream-$ICECREAM_SHA1
mkdir build
cd build
../autogen.sh
../configure --prefix=/usr/local/ \
    --enable-gcc-color-diagnostics \
    --enable-gcc-show-caret \
    --enable-gcc-fdirectives-only \
    --enable-clang-rewrite-includes \
    --without-man \
    LDFLAGS="-static"

make -j$(nproc) LDFLAGS="--static"
make install-strip DESTDIR=$(pwd)/../install

check_static ../install/usr/local/bin/icecc

tar -czf icecream.tar.gz -C ../install .
cp icecream.tar.gz /pyrex/build

