#! /bin/sh -e
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

THIS_DIR=$(readlink -f $(dirname $0))

if [ -n "$1" ]; then
    TARGET="$1"
else
    TARGET="all"
fi

rm -rf $THIS_DIR/build
mkdir -p $THIS_DIR/build

docker build -t garmin/pyrex-util:latest -f Dockerfile $THIS_DIR

docker run -it --rm --init \
    --mount type=bind,source=$THIS_DIR,target=/pyrex \
    garmin/pyrex-util:latest \
    /pyrex/scripts/build_$TARGET.sh

rm -rf $THIS_DIR/checksums
mkdir -p $THIS_DIR/checksums

(
    cd $THIS_DIR/build
    for f in *; do
        sha256sum $f | cut -f1 -d' ' > $THIS_DIR/checksums/$f.sha256
    done
)

