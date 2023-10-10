# pes_ripple_counter

## GLS Process to verify Ripple Counter

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

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/5f6f338c-4c83-4bbb-a7fd-e1fdbcd11ed5)
- These are the results displayed.
- We then use the command
```
dfflibmap -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
since it is a sequential design.
- We then map the library file to the design using
```
abc -liberty ../my_lib//lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
- We type ```show``` to display the design.
![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/204ff87b-01cd-4814-a2d8-0a17a74b6725)

- To generate the netlist file we must type the command
```
write_verilog -noattr pes_ripple_counter_net.v
```
- Now using the netlist file, we verify the waveform once more

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/f7b30472-674a-4733-bff0-ce80e4fd3469)
- To read the design and test bench file we must use the command
```
iverilog ../my_lib/verilog_model/primitives.v ../my_lib/verilog_model/sky130_fd_sc_hd.v pes_ripple_counter.v pes_ripple_counter_tb.v
```
- Now we type ```./a.out``` to generate the .vcd file.
- To see the waveform we type the command
```
gtkwave pes_ripco_tb.vcd
```

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/f11dbe79-e382-4766-823a-6b5321c6b570)
- The following waveform is generated.
- THe sythesis and simulation are matching
