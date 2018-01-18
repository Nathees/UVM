if [file exists work] {vdel -all}
vlib work
vlog -f compile.f
vsim -voptargs="+acc" top +UVM_TESTNAME=test1 +UVM_VERBOSITY=UVM_LOW;
run -all

