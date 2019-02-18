# Target Image Video Search Based on Local Features (TISLF)

The codes are used for implementing TISLF for target image deterction in videos in:  

    Guan B, Ye H, Liu H, Sethares W. Target Image Video Search Based on Local Features. arXiv preprint arXiv:1808.03735. 2018 Aug 11.

# Required softwares
Python2.7

Matlab 2016a+

# How to run this code

1. Clone this repository with `git clone https://github.com/gbc8181/TISLF.git`.

2. Install Parallel Computing Toolbox in Matlab.

3. After toolbox is set up, you need to download a testing video (about 78M) from [Youtube](https://www.youtube.com/watch?v=vxz8NA9gMYc), and testing target images from [Google Drive](https://drive.google.com/open?id=1Ky3TDieRz7t5CAKmNkU2o1YtACE0XduU)

4. Now, enter `oak/` directory of the codes. Run `python divide.py` to generate source images from video.

5. Enter `pine/` directory of the codes. Run `partdivide.m` to segment video into scenes.

6. Move `Num.mat` from `pine/` to `wattle/` and run `main.m` 

# How to run quickly
Be sure you are in the root directory of the codes. Just try to run `run.sh`

# License
The codes are released under the MIT License.
