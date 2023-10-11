# pes_ripple_counter
# Contents
- [Iverilog and yosys installation](#iverilog-and-yosys-installation)
- [GLS Process to verify Ripple Counter](#gls-process-to-verify-ripple-counter)

## Iverilog and yosys Installation
- To install iverilog and gtkwave we type the following
```
- sudo apt-get update
- sudo apt-get install iverilog gtkwave
```

- To install yosys we type the following
```
- git clone https://github.com/YosysHQ/yosys.git
- sudo apt install make
- sudo apt-get install build-essential clang bison flex \
   libreadline-dev gawk tcl-dev libffi-dev git \
   graphviz xdot pkg-config python3 libboost-system-dev \
   libboost-python-dev libboost-filesystem-dev zlib1g-dev
```

- Now we type ```cd yosys``` and go into the yosys folder.
- Now we type
```
sudo make install
```
## GLS Process to Verify Ripple Counter

First we will look at the waveform simulation of the program 

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/f861df6a-b520-4b3f-9d58-3d757d97e8b1)

- We first read the design and testbench file using the command
```
iverilog pes_ripple_counter.v pes_ripple_counter_tb.v
```
- Then we type ```./a.out``` to generate the .vcd file
- Now we type
```
gtkwave pes_ripco_tb.vcd
```
The waveform is obtained as follows.'

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/ea9607da-e590-42cb-ae5e-3eecdac11cb2)

Now we will synthesize the design and generate the netlist file.

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/5afde0eb-f9ad-4d7c-b976-983fcc643815)
- Now we will import the cells from the library file by using the command
```
read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
- We read the verilog file using
```
read_verilog pes_ripple_counter.v
```
- We synthesize the dsign using
```
synth -top pes_ripco
```
- These are the results displayed.

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/90fd2c16-a4d0-487e-8b3b-af3366ef488c)

- We then map the library file to the design using
```
abc -liberty ../my_lib//lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/0f88e3d0-ef53-4692-8480-5ed39a0da491)


- We type ```show``` to display the design.
![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/3bcbb83e-f4b3-459a-ab83-3127855a3e0f)

- To generate the netlist file we must type the command
```
write_verilog -noattr pes_ripple_counter_net.v
```
- Now using the netlist file, we verify the waveform once more

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/48075ae5-566d-424b-b5e5-89bcb310a0b3)
- To read the design and test bench file we must use the command
```
iverilog ../my_lib/verilog_model/primitives.v ../my_lib/verilog_model/sky130_fd_sc_hd.v pes_ripple_counter_net.v pes_ripple_counter_tb.v
```
- Now we type ```./a.out``` to generate the .vcd file.
- To see the waveform we type the command
```
gtkwave pes_ripco_tb.vcd
```

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/dcde6159-6716-49bd-9122-2ffc550d5032)
- The following waveform is generated.
- THe synthesis and simulation are matching
