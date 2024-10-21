#!/bin/bash -lx
#SBATCH --job-name="torch"
#SBATCH --nodes=1                   # number of nodes
#SBATCH --ntasks-per-node=1        # Do not change
#SBATCH --gpus-per-node=4          # number of gpus per node
#SBATCH --time=12:00:00            # total run time limit (HH:MM:SS)

CONDA_ENV_NAME=x86_torch_dev

# add --build-wheel to build wheel instead of develop mode

srun --environment=megatron_x86  numactl --membind=0-3  bash -c "\
    export PATH=/capstor/scratch/cscs/ctianche/bristen/miniconda/bin:\$PATH && \
    export LD_LIBRARY_PATH=/capstor/scratch/cscs/ctianche/bristen/miniconda/envs/${CONDA_ENV_NAME}/lib/:/capstor/scratch/cscs/ctianche/bristen/miniconda/lib:\$LD_LIBRARY_PATH && \
    source /capstor/scratch/cscs/ctianche/bristen/miniconda/etc/profile.d/conda.sh && \
    echo \"conda path: \$(which conda)\" && \
    conda activate ${CONDA_ENV_NAME} && \
    echo \"python path: \$(which python)\" && \
    cd /capstor/scratch/cscs/ctianche/bristen/pytorch && \
    export CMAKE_PREFIX_PATH="\${CONDA_PREFIX:-'\$(dirname \$(which conda))/../'}:${CMAKE_PREFIX_PATH}" && \
    echo \"CMAKE_PREFIX_PATH: \$CMAKE_PREFIX_PATH\" && \
    python setup.py develop"
