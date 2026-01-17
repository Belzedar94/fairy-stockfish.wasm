#!/bin/bash

bench_file="$(dirname "$0")/../bench-signature.txt"

if [ -f "$bench_file" ]; then
  cat "$bench_file"
  exit 0
fi

git log | grep "bench:" | head -n 1 | awk '{print $NF}'
