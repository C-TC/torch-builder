# Aarch64 (ARM/Graviton) Support Scripts
Scripts for building aarch64 PyTorch PIP Wheels. These scripts build the following wheels:
* torch
* torchvision
* torchaudio
* torchtext
* torchdata
## Aarch64_ci_build.sh
This script is design to support CD operations within PyPi manylinux aarch64 container, and be executed in the container. It prepares the container and then executes __aarch64_wheel_ci_build.py__ to build the wheels. The script "assumes" the PyTorch repo is located at: ```/pytorch``` and will put the wheels into ```/artifacts```.
### Usage
```DESIRED_PYTHON=<PythonVersion> aarch64_ci_build.sh```

__NOTE:__ CI build is currently __EXPERMINTAL__

## Build_aarch64_wheel.py
This app allows a person to build using AWS EC3 resources and requires AWS-CLI and Boto3 with AWS credentials to support building EC2 instances for the wheel builds. Can be used in a codebuild CD or from a local system.

### Usage
```build_aarch64_wheel.py --key-name <YourPemKey> --use-docker --python 3.8 --branch <RCtag>```


# Compiling torch on ALPS

1. create `aarch64_torch_env` conda env, install packages listed in `aarch64_ci_setup.sh`, also install zip.
2. in cuda devel cudnn ngc container (or pytorch ngc container), activate env, run `my_setup.sh` manually (copy paste commands, because sometimes conda falls back to base env for unknown reason). 


## Notice: 
1. uncomment `os.system(f"cd {REPO_PATH}/pytorch; python setup.py clean")` and/or `build_ArmComputeLibrary()` if necessary