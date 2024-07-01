#!/bin/bash

# ^That's the hashbang, as it's written in bash.

    # #SBATCH comments will be run as if they were sbatch arguments
#SBATCH --mem=8G # I want 8GBs of ram
#SBATCH --nodes=1
#SBATCH --time=24:00:00 # set a timelimit of 24 hours. Good sanity check incase your code gets stuck

#SBATCH --comment="This appears nowhere as far as I can tell"

    # The job name will be accessible to all users, so don't be rude.
#SBATCH --job-name=python_example
    # (you can't use substitutions in the jobname, I've tried)

    # These next lines are Sheffield specific and are to get a GPU available
#SBATCH --partition=gpu
#SBATCH --qos=gpu
#SBATCH --gpus-per-node=1

    # Next line uses substitutions: 
    #   %A is the job number and
    #   %a is the sub-job number for array tasks called with sbatch
#SBATCH --output=logs/output-%A-%a

echo Setting up environment...
export SLURM_EXPORT_ENV=ALL

# This variable is only really useful for Slurm array jobs. Makes sure the python script
#  that I call at the end can access that task ID
printenv SLURM_ARRAY_TASK_ID
export SLURM_ARRAY_TASK_ID

module load Anaconda3/2019.07
module load CUDAcore/11.1.1

# This line activates an Anaconda environment I previously created and gave the name "huggingface_env":
source activate huggingface_env

# Altering the Anaconda environment. (Probably should have used a requirements.txt)
echo Running pip...
pip install torch torchvision evaluate -q
# the -q makes it print less to the output, lots of commands have "quiet" modes

echo Running training script...
cd football_data

# and finally, run your actual python script
python train.py
