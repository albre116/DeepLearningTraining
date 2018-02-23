# DeepLearningTraining
Training Materials for Deep Learning on Google Cloud with Fast AI ([fastai course](http://course.fast.ai/)).

We port over the course content to be run on google cloud instead of AWS.  This will take about 1/2 a day a week for a 2 month period to complete.

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
    * This repo contains a submodule to fast.ai repository, so you'll need to get that too ```git submodule update --init --recursive```
    * Following the documentation for [Creating a GPU instance](https://cloud.google.com/compute/docs/gpus/add-gpus#create-new-gpu-instance)
        * Run the cuda_bare_metal.sh install file found in the setup folder ``` sh cuda_bare_metal.sh ```
        * Verify your install by running at the command line ``` nvidia-smi ```
## NVIDIA Docker Install
We will use the docker engine to connect to the underlying CUDA drivers, but this requires and additional driver set that makese the connection between docker and the bare metal CUDA drivers.
![nvidia-gpu-docker](https://cloud.githubusercontent.com/assets/3028125/12213714/5b208976-b632-11e5-8406-38d379ec46aa.png)

* run the file getdrivers_dockerce.sh by ```sh getdrivers_dockerce.sh```
* test the install by running ``` docker run --runtime=nvidia --rm nvidia/cuda nvidia-smi ```

## Build the Deep Learning Environment using Docker for Part 1
Fast AI was finally migrated to python 3, but the available docker builds have some issues.  I've taken on of those builds from [Paperspace](https://github.com/Paperspace/fastai-docker) and have performed slight modifications.  You'll need to build using the build shell in the folder:

* ```sh build.sh```
* ``` docker run --runtime=nvidia -d -p 8888:8888 -v $(pwd):/MountData robinson/fastai-course-1  ```
* you'll need to get the notebook password through exec into the container and get the token for the running notebook

## Build the Deep Learning Environment using Docker for Part 2
We are going to use [Deepo](https://hub.docker.com/r/ufoym/deepo/) to configure our keras and tensor flow environments.  check out the github page here [Deepo Github](https://github.com/ufoym/deepo).  They have a large number of deep learning optoins (see the grid of choices) but for our purposes we will use the all-in-one with jupyter stack.
* Important, for part 1 of the course you must use python 2.7 or the code will not run and you will need to back down keras install version
* pull the image and mount to the current volume ```nvidia-docker run -it -d -p 8888:8888 -v $(pwd):/root ufoym/deepo:all-py27-jupyter jupyter notebook --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token="Normal" --notebook-dir='/root'```
* Go to the IP Address of your machine at port 8888 (i.e. http://IPaddr:8888) and use password Normal
* In the notebook, we need to downgrade keras to 1.2.2 for the course materials in part 1 (we will upgrade for part 2 of the training)
* Downgrade keras ```!pip uninstall -y keras\ !pip install keras==1.2.2```

## Test that your code worked by building a keras example
* We pull a LSTM example with timings that should match the K40 timings (since we only get half a board... how silly) from [keras examples](https://github.com/fchollet/keras/blob/master/examples/imdb_cnn.py).  You can find this code in an ipython notebook folder under examples folder.
* Additionally, all of the keras examples were copied into a folder under examples.


## Azure Notes:
* Link pip ```!sudo ln -s /anaconda/bin/pip /usr/local/sbin/pip```
* Use Python 2 kernel
* Downgrade keras ```!pip uninstall -y keras\ !pip install keras==1.2.2```
* Get cats and dogs data, and put in correct location ```cd /data\ wget http://files.fast.ai/data/dogscats.zip\ unzip -q dogscats.zip```
* Set appropriate path in path variable in notebook ```path = "/data/dogscats/sample/"```
* OOM Errors: If you have an OOM error then check ```nvidia-smi``` and kill all processes using the GPU, then try running your code again. If you are using K-80 then the code for lesson 1 should be fine with batch sizes at least as large as 128.
