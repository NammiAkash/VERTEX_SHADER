
set sdc_version 1.7

set_units -capacitance 1000.0fF
set_units -time 1ns

# Set the current design
current_design test

create_clock -name "clk" -add -period 3 -waveform {0 1.5} [get_ports "clk"]
set_clock_transition -rise 0.1 [get_clocks "clk"]
set_clock_transition -fall 0.1 [get_clocks "clk"]

#set_input_delay -max 1.0 [get_ports "rst"]

#set_input_delay -max 1.0 [get_ports "a"]

#set_input_delay -max 1.0 [get_ports "b"]

#set_output_delay -max 1.0 [get_ports "result"]



# Define the reset signal
#set_input_delay -max 1 [get_ports rst] -clock [get_clocks clk]
#set_input_delay -min 0.5 [get_ports rst] -clock [get_clocks clk]

# Define input delays for inputs a and b (assuming data is stable 2 ns after clock edge)
set_input_delay -max 1 [get_ports a0] -clock [get_clocks clk]
set_input_delay -max 1 [get_ports b0] -clock [get_clocks clk]

# Define output delays for result signal (assuming it takes 2 ns to become stable)
set_output_delay -max 1 [get_ports r0] -clock [get_clocks clk]

set_wire_load_mode "top"

