#!/usr/bin/env bash

# Copyright 2017 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
set -euo pipefail

function guess_runfiles() {
    pushd ${BASH_SOURCE[0]}.runfiles > /dev/null 2>&1
    pwd
    popd > /dev/null 2>&1
}

function exe() { echo "\$ ${@/eval/}" ; "$@" ; }

RUNFILES="${PYTHON_RUNFILES:-$(guess_runfiles)}"

PYTHON_RUNFILES=${RUNFILES} %{resolve_script} | \
  exe  %{kubectl_tool} %{namespace_arg} apply $@ -f -
