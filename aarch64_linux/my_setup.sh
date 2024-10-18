#!/bin/bash -lx
#SBATCH --job-name="torch"
#SBATCH --nodes=1                   # number of nodes
#SBATCH --ntasks-per-node=1        # Do not change
#SBATCH --gpus-per-node=4          # number of gpus per node
#SBATCH --time=6:00:00            # total run time limit (HH:MM:SS)
#SBATCH -A a06
#SBATCH --reservation=sai-a06

CONDA_ENV_NAME=aarch64_torch_env
# conda init


# print python path
# echo "python path: $(which python)"

PATH=/users/ctianche/miniconda3/bin:$PATH
LD_LIBRARY_PATH=/users/ctianche/miniconda3/envs/${CONDA_ENV_NAME}/lib/:/users/ctianche/miniconda3/lib:$LD_LIBRARY_PATH
DESIRED_PYTHON=3.10
DESIRED_CUDA=12.6
GPU_ARCH_VERSION=12.6


USE_PRIORITIZED_TEXT_FOR_LD=1 

srun --environment=megatron  numactl --membind=0-3  bash -c "\
    source /users/ctianche/miniconda3/etc/profile.d/conda.sh && \
    conda activate ${CONDA_ENV_NAME} && \
    echo \"python path: \$(which python)\" && \
    python /capstor/scratch/cscs/ctianche/playground/torch-builder/aarch64_linux/aarch64_wheel_ci_build.py --enable-mkldnn --enable-cuda"
