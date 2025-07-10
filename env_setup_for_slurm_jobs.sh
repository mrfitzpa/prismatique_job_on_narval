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



# The current script will create a virtual environment, then activate it within
# the current shell, and then install the ``prismatique`` library within said
# environment.
#
# The correct form of the command to run the script is::
#
#  source <path_to_current_script> <path_to_virtual_env>
#
# where ``<path_to_current_script>`` is the absolute or relative path to the
# current script; and ``<path_to_virtual_env>`` is the path to the virtual
# environment.



# Begin timer, and print starting message.
start_time=$(date +%s.%N)

msg="Beginning virtual environment creation and setup..."
echo ""
echo ${msg}
echo ""
echo ""
echo ""



# Get the path to the directory containing the current script.
cmd="realpath "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)""
path_to_dir_containing_current_script=$(${cmd})



# Parse the command line arguments.
if [ $# -eq 0 ]
then
    path_to_virtual_env=~/emicroml
else
    path_to_virtual_env=$1
fi



# Load some DRAC software modules.
module load StdEnv/2023
module load python/3.11 hdf5 cuda



# Create the virtual environment, activate it, and then upgrade ``pip``.
cmd="realpath "$(dirname "${path_to_virtual_env}")""
path_to_parent_dir_of_virtual_env=$(${cmd})
    
mkdir -p ${path_to_parent_dir_of_virtual_env}
    
virtualenv --no-download ${path_to_virtual_env}
source ${path_to_virtual_env}/bin/activate
pip install --no-index --upgrade pip

    

# Install the remaining libraries in the virtual environment. Where applicable,
# GPU-supported versions of libraries are installed.
cd ${path_to_dir_containing_current_script}/_wheels_for_env_setup

pkgs="numpy<2.0.0 numba hyperspy h5py pytest ipympl jupyter"
pkgs=${pkgs}" blosc2 msgpack pyopencl pyFAI pyprismatic-gpu"
pip install --no-index ${pkgs}

pkgs="czekitout*.whl fancytypes*.whl h5pywrappers*.whl empix*.whl"
pkgs=${pkgs}" embeam*.whl prismatique*.whl"
pip install ${pkgs}

cd -



# End timer and print completion message.
end_time=$(date +%s.%N)
elapsed_time=$(echo "${end_time} - ${start_time}" | bc -l)

echo ""
echo ""
echo ""
msg="Finished virtual environment creation and setup. Time taken: "
msg=${msg}"${elapsed_time} s."
echo ${msg}
echo ""
