#!/bin/bash


var=$(ls ../put_pdbs_here)
for i in $var
do
    cd ../systems/${i:0:4}/
    pwd
    echo ${i:0:4}
    echo " "
    echo "Building System :}"
    echo " "
    vmd -dispdev text -e ../../scripts/build_system.pgn -args $i
    cd -
done
