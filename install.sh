#!/bin/bash

set -e

echo ""
echo "================================"
echo "    SETTING UP PWW CODESPACE    "
echo "================================"
echo ""

echo "Checking for depot_tools..."
if [ ! -d "/home/vscode/workspace/depot_tools" ]; then
    echo "----------------------"
    echo "Setting up depot_tools"
    echo "----------------------"
    echo ""
    cd /home/vscode/workspace
    git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
    export PATH=/home/vscode/workspace/depot_tools:$PATH
    echo "export PATH=/home/vscode/workspace/depot_tools:\$PATH" >> ~/.zshrc
fi

echo "Checking for v8 and dependencies..."
if [ ! -d "/home/vscode/workspace/v8" ]; then
    echo "---------------------------------------"
    echo "Fetching v8 and installing dependencies"
    echo "---------------------------------------"
    echo ""
    cd /home/vscode/workspace
    mkdir v8 
    cd v8
    fetch v8
    cd v8
    build/install-build-deps.sh --no-arm --no-chromeos-fonts --no-nacl --no-backwards-compatible
fi

echo "Checking for perf..."
if [ ! -d "/home/vscode/workspace/kernel/tip/tools/perf" ]; then
    echo "----------------------------------"
    echo "Building & installing perf command"
    echo "----------------------------------"
    echo ""
    cd /home/vscode/workspace
    mkdir kernel
    cd kernel
    git clone --depth 1 git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
    cd tip/tools/perf
    make
    echo "export PATH=/home/vscode/workspace/kernel/tip/tools/perf:\$PATH" >> ~/.zshrc
fi

echo ""
echo "================================"
echo "     PWW CODESPACE COMPLETE     "
echo "================================"
echo ""