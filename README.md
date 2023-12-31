# pes_ripple_counter
# Contents
- [Ripple Counter](#ripple-counter)
- [Iverilog and yosys installation](#iverilog-and-yosys-installation)
- [GLS Process to verify Ripple Counter](#gls-process-to-verify-ripple-counter)
- [Installation of ngspice magic and OpenLANE](#installation-of-ngspice-magic-and-openlane)
- [OpenLANE Flow](#openlane-flow)

## Ripple Counter
A ripple counter is a type of digital counter circuit used in digital electronics to count clock pulses or events. It is also known as an asynchronous counter because the flip-flops or stages in the counter change their state asynchronously, meaning that the output of one flip-flop triggers the next one. Each flip-flop in the ripple counter is triggered by the output of the previous flip-flop, causing a ripple effect.

The most common type of ripple counter is the binary counter, which is used to count in binary (base-2) representation. It can have two or more flip-flops connected in a chain, with each flip-flop representing a different bit in the binary count. For example, a 3-bit binary ripple counter has three flip-flops, and it can count from 000 (binary) to 111 (binary) before rolling over to 000 again.

Ripple counters are often used in applications where the speed and precision of counting are not critical, and simplicity and minimal component count are more important. In cases where precise and synchronous counting is required, synchronous counters, which use a common clock signal to trigger all flip-flops simultaneously, are preferred.

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
```
read_liberty -lib ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog pes_ripple_counter.v
synth -top pes_ripco
```

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/90fd2c16-a4d0-487e-8b3b-af3366ef488c)

```
abc -liberty ../lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
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
iverilog ../verilog_model/primitives.v ../verilog_model/sky130_fd_sc_hd.v pes_ripple_counter_net.v pes_ripple_counter_tb.v
```
- Now we type ```./a.out``` to generate the .vcd file.
- To see the waveform we type the command
```
gtkwave pes_ripco_tb.vcd
```

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/dcde6159-6716-49bd-9122-2ffc550d5032)
- The following waveform is generated.
- THe synthesis and simulation are matching

## Installation of ngspice magic and OpenLANE

**ngspice**
- Download the tarball from https://sourceforge.net/projects/ngspice/files/ to a local directory
```
cd $HOME
sudo apt-get install libxaw7-dev
tar -zxvf ngspice-41.tar.gz
cd ngspice-41
mkdir release
cd release
../configure  --with-x --with-readline=yes --disable-debug
sudo make
sudo make install
```

**magic**
```
sudo apt-get install m4
sudo apt-get install tcsh
sudo apt-get install csh
sudo apt-get install libx11-dev
sudo apt-get install tcl-dev tk-dev
sudo apt-get install libcairo2-dev
sudo apt-get install mesa-common-dev libglu1-mesa-dev
sudo apt-get install libncurses-dev
git clone https://github.com/RTimothyEdwards/magic
cd magic
./configure
sudo make
sudo make install
```

**OpenLANE**
```
sudo apt-get update
sudo apt-get upgrade
sudo apt install -y build-essential python3 python3-venv python3-pip make git

sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
sudo docker run hello-world
sudo groupadd docker
sudo usermod -aG docker $USER
sudo reboot 
# After reboot
docker run hello-world (should show you the output under 'Example Output' in https://hub.docker.com/_/hello-world)

- To install the PDKs and Tools
cd $HOME
git clone https://github.com/The-OpenROAD-Project/OpenLane
cd OpenLane
make
make test
```

## OpenLANE Flow

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/f900f851-61f7-4174-bf3a-a73a121bf972)
- First we create a folder under the name of our design in the 'designs' folder.
- Do ```cd pes_ripple_counter```.

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/2e9df8ba-48c4-4a43-8db6-0b56b7ce6b09)
- Here we create a config.json file.
- We make a new directory called 'src'.
- Do ```cd src```

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/46f0b83b-d9f6-4eac-9e33-08fa63960fbc)
- We add the following files to this directory.
- All these files are found above in the 'pes_ripple_counter' folder.

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/fe51669c-cd8a-4642-8fab-1e7b351e1eec)
- Now in the main 'Openlane' directory type ```mkdir pdks```.
- Copy paste the above file in it. Found in the verilog_model folder above.

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/e361d6df-47a1-4746-8dab-44459d9fb7fe)
- Type ```make mount``` in the main Openlane folder.
- Then type ```./flow.tcl -interactive```.
- To prep the design type
```
prep -design pes_ripple_counter
```

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/6a2bfa9d-9995-461d-9d46-76fae801e0a1)

### Synthesis
- Type
```
run_synthesis
```

**Physical Cells**

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/cd0f869e-0721-4b5f-a26d-aa73419588b1)
- Flop Ratio = 2/6 = 0.33

### Floorplan
- Now to run the floorplan we type
```
run_floorplan
```
![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/8ddc3d10-3739-42f1-8b23-4c70416df230)


- To view the design we type
```
magic -T /home/aniruddhan/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def pes_ripco.def &
```
![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/5a65f42a-a96c-4636-a0d9-b93a6d929d9c)

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/848bb470-d498-4bb9-875c-a018501a82e4)

### Placement
- Now to run the placement we type
```
run_placement
```
![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/d9d2c01c-471f-44a1-a9c5-b6d1d16d1cba)

- To view the design we type
```
magic -T /home/aniruddhan/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def pes_ripco.def &
```
![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/385ad16f-12d0-4ac2-a1c3-ae3efab14dde)

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/fa36a659-8c83-4d7a-95a3-5a8499836df2)

### CTS(Clock Tree Synthesis)
- Now to run cts we type
```
run_cts
```
![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/61245018-46f9-4828-9031-bcdf653baa94)

- The reports generated are given below

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/322dc364-79e1-4811-9588-3251e17dd9bf)

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/92e2e269-4af2-4321-af16-e77c0bf17b4b)

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/a8be3f87-4dd3-48d9-9071-f358b87694ca)

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/02a278bc-7774-4c13-b6ef-ddb258bf9a6b)

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/c48c2700-5b64-4e18-b3ab-a03c1eeb6f5f)

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/6e9e50a6-5f4b-40e8-a445-feea6b6d45b9)

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/8eae23c8-17c7-4cd5-9a4f-7f38cf5cad36)

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/e60d59e2-8f8e-47aa-820c-bb658edb5250)

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/df452773-4ed0-4649-9a50-805eb63a93fc)

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/c16382f2-3882-4ffc-b899-b0c55a400130)

**Power Report**
![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/77987d2a-c134-4fc7-8f66-54c230428a20)

**Skew Report**
![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/7044adf2-01a3-4f3e-aa34-2cc1f27956bb)

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/60f1e27d-5696-421b-a4c0-9eb3f92caed2)

**Area Report**
![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/2b21b664-9cec-4bb2-9935-bb45d16b78df)

### Routing
- Now to run routing we type
```
run_routing
```
![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/3a1d50b9-7601-49eb-a169-f5bc68fd7ba9)

- To view the design we type
```
magic -T /home/aniruddhan/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def pes_ripco.def &
```
![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/b8050a63-5b18-499d-aa94-7e2d9e92bdf6)

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/4568397a-c4ef-4b03-8fca-92289c2fdb0c)

![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/b4d79c44-36a6-4790-a2cb-b00f99ed7fec)

**Congestion Report**
![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/3710defc-00e6-4961-a25f-f0bd8a5bb3bc)

**Power and Clock Skew Report**
![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/2562225a-75d6-4c4d-a964-fc3757a01b26)

**Summary Report and Area Report**
![image](https://github.com/AniruddhaN2203/pes_ripple_counter/assets/142299140/8f9ee540-2e56-4fa8-8fad-a8760285ba93)

**Statistics**
- Area = 351.155 um2
- Internal Power = 2.08e-06 W
- Switching Power = 5.18e-07
- Leakage Power = 8.24e-11
- Total Power = 2.59e-06
