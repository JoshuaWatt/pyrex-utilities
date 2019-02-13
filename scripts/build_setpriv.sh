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

wget https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.33/util-linux-2.33.1.tar.xz
tar -xvf util-linux-2.33.1.tar.xz
cd util-linux-2.33.1
mkdir build
cd build

../configure \
    --disable-all-programs \
    --enable-setpriv \
    --disable-doc \
    LDFLAGS="-static" \
    --disable-nls \
    --without-bashcompletion \
    --prefix=/usr/local

make -j$(nproc) LDFLAGS="--static"
make install-strip DESTDIR=$(pwd)/../install

check_static ../install/usr/local/bin/setpriv
cp ../install/usr/local/bin/setpriv /pyrex/build

