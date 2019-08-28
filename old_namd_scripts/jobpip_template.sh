#!/bin/bash

#Usage: bash jobpip.sh

#first job
jobid=$(sbatch  NAME.31.sh  | cut -f 4 -d' ')
echo $jobid

#Dependent Jobs
for i in {32..45}
do
    jobid=`sbatch -d afterany:$jobid NAME.$i.sh | cut -f 4 -d' '`
    echo $jobid
done
