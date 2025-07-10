#!/bin/bash
# -*- coding: utf-8 -*-
# Copyright 2025 Matthew Fitzpatrick.
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, version 3.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this program. If not, see <https://www.gnu.org/licenses/gpl-3.0.html>.



# The current script prepares and submits a SLURM job that executes a Python
# script with the basename ``job.py``. To execute this script as intended,
# change into the directory containing the current script, and run
#
#   sbatch prepare_and_submit_slurm_job.sh
#
# Make sure that the files with the basenames ``download_required_wheels.sh``,
# ``env_setup_for_slurm_jobs.sh``, and ``job.py`` are also located in the same
# directory containing the current script.



#SBATCH --job-name=run_job
#SBATCH --nodes=1
#SBATCH --cpus-per-task=2              # CPU cores/threads
#SBATCH --gpus-per-node=a100_1g.5gb:1  # GPU type and number of GPUs per node.
#SBATCH --mem=15G                      # CPU memory per node
#SBATCH --time=00-02:59                # time (DD-HH:MM)
#SBATCH --mail-type=ALL

# Setup the Python virtual environment used to execute the Python script. Note
# that the environment will be created at
# ``${SLURM_TMPDIR}/tempenv``. Computations will generally run faster when you
# create virtual environment on the node-local storage, i.e. within
# ``${SLURM_TMPDIR}``. It is also generally a good idea to handle most file I/O
# operations there too. See the following link for more details:
# https://docs.alliancecan.ca/wiki/Using_node-local_storage.
source env_setup_for_slurm_jobs.sh ${SLURM_TMPDIR}/tempenv



# Execute the Python script.
basename=job.py
path_to_script_to_execute=job.py

python ${path_to_script_to_execute}
python_script_exit_code=$?

if [ "${python_script_exit_code}" != 0 ];
then
    msg="\n\n\nThe slurm job terminated early with at least one error. "
    msg=${msg}"See traceback for details.\n\n\n"
    echo -e ${msg}
    exit 1
fi
