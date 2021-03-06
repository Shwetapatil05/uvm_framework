# ############################################################################
#
#  This script reads the uvmf package file generated by the 
#     QVIP configurator and generates a base python config 
#     file for generating the encapsulating environment and bench.
#
# Command:  build_e_and_b_configs configuratorBenchName EncapsulatingEnvironmentName testBenchName
#
# Arguments:  
#         configuratorBenchName        :The name of the test bench 
#                                       generated by the QVIP Configurator.
#
#         EncapsulatingEnvironmentName :The name of the environment that 
#                                       will encapsulate the QVIP configurator 
#                                       generated environment.
#
#         testBenchName                :The name of the test bench.
#
# Ouptut:
#         EncapsulatingEnvironmentName_config.py : Python file for generating 
#                                                  the top environment using 
#                                                  the UVMF Code generator.
#
#         testBenchName_config.py                : Python file for generating 
#                                                  the test bench using the UVMF 
#                                                  Code generator.
#         
#
cat $UVMF_HOME/templates/python/scripts/env_config_header.py > $2_config.py
grep addQvipSubEnv $1_dir/uvmf/$1_pkg.sv >> $2_config.py
cat $UVMF_HOME/templates/python/scripts/env_config_trailer.py >> $2_config.py

sed 's/\/\/ //' <$2_config.py>e_tmp.py
mv e_tmp.py $2_config.py


sed /MY_ENV_NAME/s//$2/g $2_config.py > e_tmp.py
mv e_tmp.py $2_config.py

chmod a+x $2_config.py



cat $UVMF_HOME/templates/python/scripts/bench_config_header.py > $3_config.py
grep addQvipBfm $1_dir/uvmf/$1_pkg.sv >> $3_config.py
cat $UVMF_HOME/templates/python/scripts/bench_config_trailer.py >> $3_config.py

sed 's/\/\/ //' <$3_config.py>b_tmp.py
mv b_tmp.py $3_config.py

sed /MY_ENV_NAME/s//$2/g $3_config.py > b_tmp.py
mv b_tmp.py $3_config.py

sed /MY_BENCH_NAME/s//$3/g $3_config.py > b_tmp.py
mv b_tmp.py $3_config.py

chmod a+x $3_config.py
