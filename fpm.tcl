
set search_path "/afs/iitd.ac.in/service/tools/public/asiclib/umcoa/L65/libraries/UMC65LLSC/synopsys/ccs"
set_attribute lib_search_path "/afs/iitd.ac.in/service/tools/public/asiclib/umcoa/L65/libraries/UMC65LLSC/synopsys/ccs/"
set_attribute hdl_search_path "/afs/iitd.ac.in/user/n/na/nammi/vertex/rtl/"
set_attribute library "uk65lscllmvbbr_100c25_tc_ccs.lib"

read_hdl fpmp.v
elaborate
check_design -unresolved
read_sdc ~/vertex/consts/fpm.sdc
synthesize -to_mapped -effort high
write_hdl > /afs/iitd.ac.in/user/n/na/nammi/vertex/typical/synth_typical.v
write_sdc > /afs/iitd.ac.in/user/n/na/nammi/vertex/typical/sdc_typical.sdc

