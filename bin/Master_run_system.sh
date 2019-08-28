#!/bin/bash                                                                     

###########################################################################     
#                                                                               
#        Created by:  John Vant                                                 
#                     jvant@asu.edu                                             
#                     Biodesign Institute, ASU                                  
#                                                                               
#        This Script is meant to setup a equilibration simulaiton in namd       
#                                                                               
#                                                                               
###########################################################################     

# Usage: bash Master_setup_all_systems.sh                                       

###########################################################################     

# Arguments                                                                     
systems=( "$@" )

###########################################################################     
# Define parameters                                                             
nnodes=1
ncpu=8
wall_time=2-00:00
partition=asinghargpu1
queue=wildfire
gpu=1
###########################################################################     
# Main                                                                          
cd ../
SCRIPTS_PATH=$(pwd)
SCRIPTS_PATH_sed="$(echo $SCRIPTS_PATH | sed 's/\//\\\//g')"

# No longer using config_param file
#awk -v CWD=cwd -v PSF_PDB_NAME=psf_pdb_name -v STEP_NUM=step_num -v SCRIPTS_PATH=$SCRIPTS_PATH 'BEGIN {print CWD, PSF_PDB_NAME, STEP_NUM, SCRIPTS_PATH }'> ./config_params.str

echo "Simulating the following systems $systems"
for sys in $systems
do
    cd ../systems/$sys
    for STEP_NUM in 9
    do
        sed -e s/MYSYS_NAME/$sys-solv_ion/ -e s/STEP/$STEP_NUM/ -e s/SCRIPTS_PATH/$SCRIPTS_PATH_sed/ $SCRIPTS_PATH/namd_scripts/amd_template.inp > ./step$STEP_NUM-AMD.inp
        job=$(sed -e s/filename/step$STEP_NUM-AMD/ $SCRIPTS_PATH/submission_scripts/slurm_batch.sh | sbatch -N $nnodes -n $ncpu -t $wall_time -p $partition -q $queue --gres=gpu:$gpu -o ./slurm.out -J $sys | cut -f 4 -d' ')
        echo "submitted step$STEP_NUM for $sys"
    done
    cd -
done
