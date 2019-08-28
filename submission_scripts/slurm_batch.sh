#!/bin/bash

# Arguments
CONFIG_FILE=filename

module load namd/2.13b1-cuda

namd2 +p8 ./$CONFIG_FILE.inp > ./$CONFIG_FILE.log
