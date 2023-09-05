# pes_ripple_counter

## GLS Process to verify Ripple Counter

First we will look at the waveform simulation of the program 

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/53cfa01e-09ab-437c-ab05-f5ac31abf402)
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

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/d746773b-15e4-44eb-b176-a489423bb13b)

Now we will synthesize the design and generate the netlist file.

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/de743bae-b8ff-489c-9a58-781f0abaffe8)
- Now we will import the cells from the library file by using the command
```
read_liberty -lib ../my_lib/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
- We read the verilog file using
```
read_verilog pes_ripple_counter.v
```
- We synthesize the dsign using
```
synth -top pes_ripco
```

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/f98df9e6-467e-43f2-ab9f-e053c583a160)
- These are the results displayed.
- We then use the command
```
dfflibmap -liberty ../my_lb/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
since it is a sequential design.
- We then map the library file to the design using
```
abc -liberty ../my_lib//lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
- We type ```show``` to display the design.
![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/204ff87b-01cd-4814-a2d8-0a17a74b6725)

Now let us s
