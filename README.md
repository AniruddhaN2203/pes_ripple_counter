# pes_ripple_counter
# Contents
- [Ripple Counter](#ripple-counter)
- [Iverilog and yosys installation](#iverilog-and-yosys-installation)
- [GLS Process to verify Ripple Counter](#gls-process-to-verify-ripple-counter)
- [Installation of ngspice, magic and OpenLANE](#installation-of-ngspice,-magic-and-openlane)
- OpenLANE Design

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

## Insallation of ngspice, magic and OpenLANE

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
hi
