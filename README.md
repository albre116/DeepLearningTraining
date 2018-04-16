# DeepLearningTraining
Training Materials for Deep Learning on Google Cloud with Fast AI ([fastai course](http://course.fast.ai/)).

* Each Person can launch a fully functioning GPU instance using the following instructions
* Make sure to shut down your instance when finished

## Full Build Instructions

### Google VM machine and GPU and setup

* Go to the google cloud [console](https://console.cloud.google.com) and log into the platform
* Under compute engine => VM instances
* Under the compute Engine dashboard select create instance
    * Review which regions GPUs are available in [GPU Available Regions](https://cloud.google.com/compute/docs/gpus/)
    * Pick a VM from that zone (i.e. us-east1-c is suitable)
    * Select a 2 vCPU system with 13 GB memory and click customize to GPU tab below
    * Select NVIDIA Tesla K80 (which is really a K40 board (or 1/2 a K80) if you do 1 GPU... talk about bad advertising)
    * Change the OS and storage drive to be Ubuntu 16.04 LTS and go for a 100GB drive (instead of default 10GB)
* Launch the image with Create
    * Google Cloud has a nice SSH client you can just use in the browser instead of putty
        * terminal in as root for all commands below by running ``` sudo su ```
    * As a note, you will be using a corporate account which already has added firewall policies to unblock port 8888 so you will not need to do that
* Clone this repository to gain access to the build scripts
    * Following the documentation for [Creating a GPU instance](https://cloud.google.com/compute/docs/gpus/add-gpus#create-new-gpu-instance)
        * Change dir into the project ``` cd DeepLearningTraining ```
	* Run the cuda_bare_metal.sh install file found in the setup folder ``` sh setup/cuda_bare_metal.sh ```
        * Verify your install by running at the command line ``` nvidia-smi ```
### NVIDIA Docker Install
We will use the docker engine to connect to the underlying CUDA drivers, but this requires and additional driver set that makes the connection between docker and the bare metal CUDA drivers.
![nvidia-gpu-docker](https://cloud.githubusercontent.com/assets/3028125/12213714/5b208976-b632-11e5-8406-38d379ec46aa.png)

* run the file getdrivers_dockerce.sh by ```sh setup/getdrivers_dockerce.sh```
* test the install by running ``` docker run --runtime=nvidia --rm nvidia/cuda nvidia-smi ```

### Build the Deep Learning Environment using Docker for Part 1
Fast AI was finally migrated to python 3, but the available docker builds have some issues.  I've taken on of those builds from [Paperspace](https://github.com/Paperspace/fastai-docker) and have performed slight modifications.  You'll need to build using the build shell in the folder:
#### If you want to build the docker image yourself (optional do not run)
* Do Not Run, will take a long time: ```sh build.sh```

#### Get a Pre-Build Image from Docker Hub and Launch the Notebook (much faster)
* ``` docker run --runtime=nvidia -d -p 8888:8888 -v $(pwd):/MountData albrmar/deeplearningtraining:v1  ```
* the notebook password is set as ``` Normal ``` in the docker run command in the file 

#### Course Materials
* The course notebooks once in the jupyter notebook are under ```./courses/dl1 ```

#### Hosting your own scripts and checking them in for all to use
* You have probably noticed that there is a mounted volume to the working directory that is soft linked to ```./courses/dl1/MountData ```
* Save your scripts in an examples folder if you want to commit and share
* If you want to run custom data you'll need to do that from that directory too.  See the example in the ipynb folder

