#!/bin/bash

this_dir=$(dirname "${BASH_SOURCE[0]}")

uci_exe_default="node $this_dir/../public/uci.js"
uci_exe=${uci_exe:-$uci_exe_default}

bench_file_default="$this_dir/../bench-signature.txt"
bench_file_no_embedded="$this_dir/../bench-signature-no-embedded.txt"

if [ -n "$UCI_NNUE_FILE" ] && [ -f "$bench_file_no_embedded" ]; then
  sign_ref=$(cat "$bench_file_no_embedded")
elif [ -z "$sign_ref" ] && [ -f "$bench_file_default" ]; then
  sign_ref=$(cat "$bench_file_default")
elif [ -z "$sign_ref" ]; then
  sign_ref=$(git log | grep "Bench:" | head -n 1 | awk '{print $NF}')
fi

echo -n "Running bench ... "

sign=$(eval "$uci_exe bench" | grep "Nodes searched" | awk '{ print $NF }')

echo -n "(sign, sign_ref) = ($sign, $sign_ref) ... "

if [ "$sign" == "$sign_ref" ]; then
  echo "[ok]"
else
  echo "[fail]"
  exit 1
fi
