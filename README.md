# Installation of srsLTE with ZeroMQ to Ubuntu 18.04

NOTE: Instead of Software-defined radio board e.g. USRP B210, substitute RAN(RF-Frontend) with ZeroMQ(libzmq3-dev)
libzmq3-dev should be installed before start of srsLTE cmake.

http://wiki.zeromq.org/whitepapers:measuring-performance

Proceed whole installation as root, under /root folder.

sudo -i
                                          
apt-get update

apt-get install git

apt-get install build-essential

apt-get install cmake libfftw3-dev libmbedtls-dev libboost-program-options-dev libconfig++-dev libsctp-dev

apt-get install libzmq3-dev                      

git clone https://github.com/srsLTE/srsLTE.git

cd srsLTE

mkdir build

cd build

cmake ../ 

make

make test

make install

ldconfig

srslte_install_configs.sh user

Open new terminal session as root (sudo –i) for each module:

ip netns add ue1

ip netns list

srsepc

srsenb --rf.device_name=zmq --rf.device_args="fail_on_disconnect=true,tx_port=tcp://*:2000,rx_port=tcp://localhost:2001,id=enb,base_srate=23.04e6"

srsue --rf.device_name=zmq --rf.device_args="tx_port=tcp://*:2001,rx_port=tcp://localhost:2000,id=ue,base_srate=23.04e6" --gw.netns=ue1

ping 172.16.0.2

ip netns exec ue1 ping 172.16.0.1


