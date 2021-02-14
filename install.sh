#!/bin/bash

set -e

echo ""
echo "================================"
echo "    SETTING UP PWW CODESPACE    "
echo "================================"
echo ""

echo "----------------------"
echo "Setting up depot_tools"
echo "----------------------"
echo ""
cd ~/workspace
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH=/home/vscode/workspace/depot_tools:$PATH

echo "-------------------------"
echo "Installing v8 depedencies"
echo "-------------------------"
cd /home/vscode/workspace \
    && git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git \
    && export PATH=/home/vscode/workspace/depot_tools:$PATH \
    && mkdir v8 && cd v8 \
    && fetch v8 \
    && cd v8 \
    && build/install-build-deps.sh

echo "----------------------------------"
echo "Building & installing perf command"
echo "----------------------------------"
echo ""
cd /home/vscode/workspace \
    && mkdir kernel && cd kernel \
    && git clone --depth 1 git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git \
    && cd tip/tools/perf \
    && make \
    && ln -s /home/vscode/workspace/kernel/tip/tools/perf/perf /usr/bin/perf

