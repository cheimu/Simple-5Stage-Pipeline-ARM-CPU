# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./regfile.sv"
vlog "./register.sv"
vlog "./D_FF.sv"
vlog "./mux2_1.sv"
vlog "./mux4_1.sv"
vlog "./mux8_1.sv"
vlog "./mux32_1.sv"
vlog "./dec1_2.sv"
vlog "./dec1_4.sv"
vlog "./dec1_8.sv"
vlog "./dec1_32.sv"
vlog "./regstim.sv"
vlog "./alu_mux8_1.sv"
vlog "./alu_mux4_1.sv"
vlog "./alu_mux.sv"
vlog "./adder.sv"
vlog "./add_sub.sv"
vlog "./alu_1b.sv"
vlog "./alu.sv"
vlog "./zeroflag.sv"
vlog "./datamem.sv"
vlog "./CPU.sv"
vlog "./computation.sv"
vlog "./control.sv"
vlog "./pc.sv"
vlog "./op_mux2_1.sv"
vlog "./sign_extension.sv"
vlog "./instr_fetch.sv"
vlog "./math.sv"
vlog "./movkMake.sv"
vlog "./instructmem.sv"




# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work instr_fetch_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do ins_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
