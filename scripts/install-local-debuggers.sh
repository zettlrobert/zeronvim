#!/bin/bash

install_path="${HOME}/.local/share/nvim/debug-adapters"
firefox_debug="vscode-firefox-debug"
url_firefox_debug="https://github.com/firefox-devtools/vscode-firefox-debug.git"

# check if debug-adapters folder exists, if not create it
if [ ! -d "$install_path"  ]; then
  mkdir -p $install_path
fi

if [ ! -d "${install_path}/${firefox_debug}" ]; then
  echo -e ""${url_firefox_debug}" "${install_path}/${firefox_debug}""
fi
