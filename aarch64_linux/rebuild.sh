#!/bin/bash

podman build -t cuda_dev .
export XDG_RUNTIME_DIR=/dev/shm/$USER/xdg_runtime_dir
mkdir -p $XDG_RUNTIME_DIR

enroot import -o cuda_dev_new.sqsh podman://cuda_dev

# remove sqsh if exists
rm -f cuda_dev.sqsh

mv cuda_dev_new.sqsh cuda_dev.sqsh
