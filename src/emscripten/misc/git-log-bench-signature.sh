#!/bin/bash

bench_file="$(dirname "$0")/bench-signature.txt"

if [ -f "$bench_file" ]; then
  cat "$bench_file"
else
  git log | grep "bench:" | head -n 1 | awk '{print $NF}'
fi
