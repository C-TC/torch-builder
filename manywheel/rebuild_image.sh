#!/bin/bash

export XDG_RUNTIME_DIR=/capstor/scratch/cscs/ctianche/bristen/xdg_runtime_dir
mkdir -p $XDG_RUNTIME_DIR

podman build -t megatron_x86 .

enroot import -o megatron_x86_new.sqsh podman://megatron_x86

# remove sqsh if exists
rm -f megatron_x86.sqsh

mv megatron_x86_new.sqsh megatron_x86.sqsh