vlib work
vlog -f src_files.list
vsim -voptargs=+acc work.alu_test -classdebug -uvmcontrol=all
run -all