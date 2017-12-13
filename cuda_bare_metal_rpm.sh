

#!/bin/bash
echo "Checking for CUDA and installing."
# Check for CUDA and try to install.
if ! dpkg-query -W cuda-8-0; then
  # centos7 uses rhel7
  curl -O http://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-repo-rhel7-9.0.176-1.x86_64.rpm
  rpm -i cuda-repo-rhel7-9.0.176-1.x86_64.rpm
  yum clean all
  yum install cuda
fi
nvidia-smi
# Enable persistence mode
nvidia-smi -pm 1
