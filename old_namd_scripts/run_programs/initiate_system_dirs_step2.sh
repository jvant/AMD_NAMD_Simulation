#!/bin/bash

var=$(ls ../put_pdbs_here)
for i in $var
do
    echo ${i:0:4}
    mkdir ../systems/${i:0:4}
    cp ../put_pdbs_here/$i ../systems/${i:0:4}/
    cp ../systems/system_template_dir/* ../systems/${i:0:4}/
done

echo "These pdbs have been copied over to a corresoponding systems directory"
echo $var
