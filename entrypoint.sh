#!/bin/sh -l

PATH=$PATH:/app
cd /app
mkdir -p "$GITHUB_WORKSPACE/threagile/output"
threagile -model "$GITHUB_WORKSPACE/$1" -output "$GITHUB_WORKSPACE/threagile/output" -verbose
