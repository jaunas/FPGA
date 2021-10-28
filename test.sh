#!/bin/bash

exit=0

# Populate $confs variable with test configuration file paths
mapfile -d $'\0' confs < <(find `pwd` -name "test.txt" -print0)
n=${#confs[@]}

# For each configuration
for ((i=0; i<$n; i++)); do
    dir=`dirname ${confs[${i}]}`
    echo "--> Working for $dir"
    cd $dir

    # Populate $modules variables with modules names to compile
    mapfile -d $'\0' modules < <(tr '\n' '\0' < test.txt)
    m=${#modules[@]}
    
    for ((j=0; j<$m; j++)); do
        module=${modules[${j}]}
        echo "    --> Compiling $module"
        ghdl -a $module.vhd
        if [ $? -ne 0 ] ; then
            exit=1
        fi
        
        ghdl -e $module
        if [ $? -ne 0 ] ; then
            exit=1
        fi
    done
    
    echo "    ==> Running $module"
    ghdl -r $module
    if [ $? -ne 0 ] ; then
        exit=1
    fi
done

if [ $exit -ne 0 ] ; then
    echo "xx> One or more tests have failed"
else
    echo "++> All tests have passed"
fi

exit $exit
