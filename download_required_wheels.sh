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



# The current script downloads the Python wheels required to install
# ``prismatique`` in a new virtual environment. The correct form of the command
# to run the script is::
#
#  bash download_required_wheels.sh
#
# Upon completion of the script, the wheels will be downloaded to the directory
# ``<root>/_wheels_for_env_setup``, where ``<root>`` is the root of the
# repository.



# Get the path to the directory containing the current script.
cmd="realpath "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)""
path_to_dir_containing_current_script=$(${cmd})

# Create directory in which to download wheels. 
mkdir -p ${path_to_dir_containing_current_script}/_wheels_for_env_setup

# Change into the aforementioned directory.
cd ${path_to_dir_containing_current_script}/_wheels_for_env_setup

# Download the wheels.
pip download --no-deps czekitout
pip download --no-deps fancytypes
pip download --no-deps h5pywrappers
pip download --no-deps empix
pip download --no-deps embeam
pip download --no-deps prismatique

# Change into the directory containing the current script.
cd ${path_to_dir_containing_current_script}
