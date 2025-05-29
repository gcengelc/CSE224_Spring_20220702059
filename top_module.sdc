# Clock definition
create_clock -name clk -period 10 [get_ports CLK]

# Input delays
set_input_delay -clock clk 1 [get_ports {control reset}]

# Output delays
set_output_delay -clock clk 1 [get_ports {seg[*] an[*] Result[*]}]

# False paths for button inputs
set_false_path -from [get_ports control]
set_false_path -from [get_ports reset]

# Case analysis for reset
set_case_analysis 0 [get_ports reset]