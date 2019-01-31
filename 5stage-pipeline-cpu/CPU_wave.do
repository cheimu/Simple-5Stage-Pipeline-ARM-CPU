onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /CPU_testbench/dut/fetch_instruction/instruction
add wave -noupdate -radix hexadecimal /CPU_testbench/dut/computation_unit/core/result
add wave -noupdate /CPU_testbench/dut/control_unit/Rn
add wave -noupdate /CPU_testbench/dut/control_unit/Rm
add wave -noupdate /CPU_testbench/dut/computation_unit/Rd
add wave -noupdate /CPU_testbench/dut/computation_unit/port_b/sel
add wave -noupdate /CPU_testbench/dut/computation_unit/port_b/inp
add wave -noupdate /CPU_testbench/dut/computation_unit/port_b/out
add wave -noupdate /CPU_testbench/dut/control_unit/DAddr12
add wave -noupdate -radix hexadecimal {/CPU_testbench/dut/computation_unit/register_file/eachDff[0]/dff/dataOut}
add wave -noupdate -radix hexadecimal {/CPU_testbench/dut/computation_unit/register_file/eachDff[1]/dff/dataOut}
add wave -noupdate -radix hexadecimal {/CPU_testbench/dut/computation_unit/register_file/eachDff[2]/dff/dataOut}
add wave -noupdate -radix hexadecimal {/CPU_testbench/dut/computation_unit/register_file/eachDff[3]/dff/dataOut}
add wave -noupdate -radix hexadecimal {/CPU_testbench/dut/computation_unit/register_file/eachDff[4]/dff/dataOut}
add wave -noupdate -radix hexadecimal {/CPU_testbench/dut/computation_unit/register_file/eachDff[5]/dff/dataOut}
add wave -noupdate -radix hexadecimal {/CPU_testbench/dut/computation_unit/register_file/eachDff[6]/dff/dataOut}
add wave -noupdate -radix hexadecimal {/CPU_testbench/dut/computation_unit/register_file/eachDff[7]/dff/dataOut}
add wave -noupdate -radix hexadecimal {/CPU_testbench/dut/computation_unit/register_file/eachDff[8]/dff/dataOut}
add wave -noupdate -radix hexadecimal {/CPU_testbench/dut/computation_unit/register_file/eachDff[9]/dff/dataOut}
add wave -noupdate -radix hexadecimal {/CPU_testbench/dut/computation_unit/register_file/eachDff[10]/dff/dataOut}
add wave -noupdate -radix ascii {/CPU_testbench/dut/computation_unit/register_file/eachDff[11]/dff/dataOut}
add wave -noupdate {/CPU_testbench/dut/computation_unit/register_file/eachDff[12]/dff/dataOut}
add wave -noupdate {/CPU_testbench/dut/computation_unit/register_file/eachDff[13]/dff/dataOut}
add wave -noupdate {/CPU_testbench/dut/computation_unit/register_file/eachDff[14]/dff/dataOut}
add wave -noupdate {/CPU_testbench/dut/computation_unit/register_file/eachDff[15]/dff/dataOut}
add wave -noupdate {/CPU_testbench/dut/computation_unit/register_file/eachDff[16]/dff/dataOut}
add wave -noupdate {/CPU_testbench/dut/computation_unit/register_file/eachDff[17]/dff/dataOut}
add wave -noupdate {/CPU_testbench/dut/computation_unit/register_file/eachDff[18]/dff/dataOut}
add wave -noupdate {/CPU_testbench/dut/computation_unit/register_file/eachDff[19]/dff/dataOut}
add wave -noupdate {/CPU_testbench/dut/computation_unit/register_file/eachDff[20]/dff/dataOut}
add wave -noupdate /CPU_testbench/dut/computation_unit/DAddr16
add wave -noupdate /CPU_testbench/dut/computation_unit/shamt
add wave -noupdate /CPU_testbench/dut/computation_unit/temp0
add wave -noupdate -radix hexadecimal /CPU_testbench/dut/computation_unit/movzd/value
add wave -noupdate -radix hexadecimal /CPU_testbench/dut/computation_unit/movzd/result
add wave -noupdate /CPU_testbench/dut/computation_unit/mask1
add wave -noupdate /CPU_testbench/dut/computation_unit/mask2
add wave -noupdate -radix hexadecimal /CPU_testbench/dut/computation_unit/mk/Dw
add wave -noupdate /CPU_testbench/dut/computation_unit/disk/address
add wave -noupdate /CPU_testbench/dut/computation_unit/disk/write_data
add wave -noupdate /CPU_testbench/dut/computation_unit/register_file/WriteData
add wave -noupdate /CPU_testbench/dut/computation_unit/Move
add wave -noupdate /CPU_testbench/dut/computation_unit/ZorK
add wave -noupdate -radix hexadecimal /CPU_testbench/dut/computation_unit/movz_result
add wave -noupdate -radix hexadecimal /CPU_testbench/dut/computation_unit/movk_result
add wave -noupdate -radix hexadecimal {/CPU_testbench/dut/computation_unit/disk/mem[0]}
add wave -noupdate -radix hexadecimal {/CPU_testbench/dut/computation_unit/disk/mem[1]}
add wave -noupdate -radix hexadecimal {/CPU_testbench/dut/computation_unit/disk/mem[2]}
add wave -noupdate -radix hexadecimal {/CPU_testbench/dut/computation_unit/disk/mem[3]}
add wave -noupdate -radix hexadecimal {/CPU_testbench/dut/computation_unit/disk/mem[4]}
add wave -noupdate -radix hexadecimal {/CPU_testbench/dut/computation_unit/disk/mem[5]}
add wave -noupdate -radix hexadecimal {/CPU_testbench/dut/computation_unit/disk/mem[6]}
add wave -noupdate -radix hexadecimal {/CPU_testbench/dut/computation_unit/disk/mem[7]}
add wave -noupdate -radix hexadecimal {/CPU_testbench/dut/computation_unit/disk/mem[8]}
add wave -noupdate -radix hexadecimal {/CPU_testbench/dut/computation_unit/disk/mem[9]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[10]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[11]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[12]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[13]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[14]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[15]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[16]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[17]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[18]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[19]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[23]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[20]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[21]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[22]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[80]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[81]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[82]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[83]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[84]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[85]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[86]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[87]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[88]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[89]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[90]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[91]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[92]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[93]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[94]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[95]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[96]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[97]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[98]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[99]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[100]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[101]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[102]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[103]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[104]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[105]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[106]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[107]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[108]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[109]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[110]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[111]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[112]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[113]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[114]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[115]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[116]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[117]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[118]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[119]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[120]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[121]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[122]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[123]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[124]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[125]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[126]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[127]}
add wave -noupdate {/CPU_testbench/dut/computation_unit/disk/mem[128]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {28132144420 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 389
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
WaveRestoreZoom {0 ps} {12597914036 ps}
