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

set -e
set -o pipefail

check_static() {
    local f
    for f in "$@"; do
        local deps="$(readelf -d "$f" | grep "NEEDED")"
        if [ -n "$deps" ]; then
            echo "ERROR: $f is not a static executable"
            echo "$deps"
            exit 1
        fi
    done
}

mkdir -p /usr/src
cd /usr/src

