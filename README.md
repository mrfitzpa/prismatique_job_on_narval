# `prismatique` job on Narval

This repository contains, more or less, a minimal example for submitting jobs on
the Narval server that execute commands that use the `prismatique` library.

Unlike the the Cedar server, Narval's compute nodes cannot access the
internet. Hence, it is impossible to install `prismatique` properly (if at all)
without downloading a set of Python wheels or git repositories from a login node
prior to submitting a SLURM job, wherein you would create your virtual
environment with `prismatique` installed. Digital Research Alliance of Canada
(DRAC) has only a subset of the dependencies of `prismatique` pre-built as
wheels that are locally available.

Below we describe the files in this repository.

## ./job.py

This Python scripts contains the main steps of your SLURM job to be executed on
Narval. This particular script generates a set of potential slices using
`prismatique`.

## ./data/atomic_coords.xyz

This is an input data file that stores the atomic coordinates of the model of
the sample for which to generate the potential slices. This file is required
required to execute the file `./job.py` successfully.

## ./data/sim_param_generator_output/multislice_stem_sim_params.json

This is an input data file that stores multislice simulation parameters. Only a
subset of these parameters are actually used to generate potential slices. This
file is required required to execute the file `./job.py` successfully.

## ./download_required_wheels.sh

This script downloads the Python wheels required to install `prismatique` in a
new virtual environment. Users should run this script prior to submitting any
SLURM jobs that execute commands that use the `prismatique` library. The correct
form of the command to run this script is:

 bash download_required_wheels.sh

Upon completion of the script, the wheels will be downloaded to the directory
`./_wheels_for_env_setup`.

## ./env_setup_for_slurm_jobs.sh

This script will create a virtual environment, then activate it within the
current shell, and then install the `prismatique` library within said
environment. This script should only be executed via the batch script
`./prepare_and_submit_slurm_job.sh`

## ./prepare_and_submit_slurm_job.sh

This is the batch script that is responsible for preparing and submitting a
SLURM job that: creates a virtual environment; activates said environment;
installs `prismatique`; then executes the Python script `./job.py`, i.e. the
main steps of the SLURM job. The correct form of the command to run this script
is:

 sbatch prepare_and_submit_slurm_job.sh

Users can modify the `SBATCH` options according to their needs. For instance,
one might want to add the line `#SBATCH --mail-user=<your_email_address>`, where
`<your_email_address>` is your email address. By adding this line, you would
receive emails notifying you when job execution starts and finishes.

## ./.gitignore

This file specifies intentionally untracked files that `git` should ignore. This
file is not used at all for submitting SLURM jobs.