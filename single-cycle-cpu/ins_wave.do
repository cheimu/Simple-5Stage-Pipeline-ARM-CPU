onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /instr_fetch_testbench/BrTaken
add wave -noupdate /instr_fetch_testbench/UncondBr
add wave -noupdate /instr_fetch_testbench/CondAddr19
add wave -noupdate /instr_fetch_testbench/BrAddr26
add wave -noupdate /instr_fetch_testbench/dut/program_counter/address
add wave -noupdate /instr_fetch_testbench/dut/program_counter/addressin
add wave -noupdate /instr_fetch_testbench/dut/compute_normal/sum
add wave -noupdate /instr_fetch_testbench/dut/brTak/out
add wave -noupdate /instr_fetch_testbench/dut/shift_2/result
add wave -noupdate /instr_fetch_testbench/dut/instr_mem/instruction
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {28142154 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 413
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {182615876 ps}
