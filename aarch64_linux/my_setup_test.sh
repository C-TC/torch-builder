#!/bin/bash -lx
#SBATCH --job-name="torch"
#SBATCH --nodes=1                   # number of nodes
#SBATCH --ntasks-per-node=1        # Do not change
#SBATCH --gpus-per-node=4          # number of gpus per node
#SBATCH --time=8:00:00            # total run time limit (HH:MM:SS)
#SBATCH --exclusive                # Do not change
#SBATCH -c 256

CONDA_ENV_NAME=aarch64_torch_env

# add --build-wheel to build wheel instead of develop mode

srun --environment=/capstor/users/cscs/ctianche/.edf/megatron.toml  numactl --membind=0-3  bash -c "\
    export USE_PRIORITIZED_TEXT_FOR_LD=1 && \
    export PATH=/capstor/scratch/cscs/ctianche/clariden/miniconda3/bin:\$PATH && \
    export LD_LIBRARY_PATH=/capstor/scratch/cscs/ctianche/clariden/miniconda3/envs/${CONDA_ENV_NAME}/lib/:/capstor/scratch/cscs/ctianche/clariden/miniconda3/lib:\$LD_LIBRARY_PATH && \
    export DESIRED_PYTHON=3.10 && \
    export DESIRED_CUDA=12.6 && \
    export GPU_ARCH_VERSION=12.6 && \
    source /capstor/scratch/cscs/ctianche/clariden/miniconda3/etc/profile.d/conda.sh && \
    conda activate ${CONDA_ENV_NAME} && \
    echo \"python path: \$(which python)\" && \
    cd /capstor/scratch/cscs/ctianche/playground/pytorch && \
    export CMAKE_PREFIX_PATH="\${CONDA_PREFIX:-'\$(dirname \$(which conda))/../'}:\${CMAKE_PREFIX_PATH}" && \
    echo \"CMAKE_PREFIX_PATH: \$CMAKE_PREFIX_PATH\" && \
    python setup.py develop"
