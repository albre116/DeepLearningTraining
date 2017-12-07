# DeepLearningTraining
Training Materials for Deep Learning on Google Cloud with Fast AI ([fastai course](http://course.fast.ai/)).

We port over the course content to be run on google cloud instead of AWS.

## VM machine and GPU and setup

* Go to the google cloud [console](https://console.cloud.google.com) and log into the platform 
* Under compute engine => VM instances
* Under the compute Engine dashboard select create instance
    * Review which regions GPUs are available in [GPU Available Regions](https://cloud.google.com/compute/docs/gpus/) 
    * Pick a VM from that zone (i.e. us-east1-c is suitable)
    * Select a 1 vCPU system and click customize to GPU tab below
    * Select NVIDIA Tesla K80 (which is really a K40 board (or 1/2 a K80) if you do 1 GPU... talk about bad advertising)
    * Change the OS and storage drive to be Ubuntu 16.04 LTS and go for a 100GB drive (instead of default 10GB)
* Launch the image with Create
    * Google Cloud has a nice SSH client you can just use in the browser instead of putty
        * terminal in as root for all commands below by running ``` sudo su ```
    * As a note, you will be using a corporate account which already has added firewall policies to unblock ports 80,443,8888 so you will not need to do that
* Clone this repository to gain access to the build scripts
    * Following the documentation for [Creating a GPU instance](https://cloud.google.com/compute/docs/gpus/add-gpus#create-new-gpu-instance)
        * Run the cuda_bare_metal.sh install file found in the setup folder
        * Verify your install by running at the command line ``` nvidia-smi ```