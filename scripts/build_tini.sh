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

mkdir tini
cd tini

TINI_SHA1=c3b92ce685d0387c5d508f1856aa6d4cae25db8d
wget -O tini.tar.gz https://github.com/JPEWdev/tini/archive/${TINI_SHA1}.tar.gz
tar -xvzf tini.tar.gz
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr/local ../tini-${TINI_SHA1}
make
check_static tini-static
cp tini-static /pyrex/build/tini

