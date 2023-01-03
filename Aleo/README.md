
![Logo](https://static.wixstatic.com/media/0669d3_823ae49e8eec49cdac30aca2bb7a3736~mv2.png/v1/fill/w_262,h_262,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/3954C488-8CCE-4EF3-846E-064815B0F24B_PNG.png)
# Aleo 

Modular and compliant. The ultimate toolkit for building private applications is finally here.
Data privacy platform Aleo is launching its incentivized testnet 
on Dec 2. it set aside 25M ALEO credits for Testnet 3 incentives. Prover incentives account for 7.5M credits (30%). The incentive period will last until January 26th, 2023, or until all 7.5M credits are released


## Minimum Hardware Requirements




| CPU | RAM     | GB                |
| :-------- | :------- | :------------------------- |
| `16` | `16` | `128` |


Not:You will require more than these requirement in order to be competitive



## Setup Node

Update packages
```bash
sudo apt update && sudo apt upgrade -y
```

Install dependencies
```bash
sudo apt install wget git curl screen -y
```
Open screen
```bash
screen -S aleo
```
## Download and build binaries
```bash
git clone https://github.com/AleoHQ/snarkOS.git --depth 1
```
```bash
cd snarkOS
```
```bash
./build_ubuntu.sh
```
```bash
source $HOME/.cargo/env
```
```bash
cargo install --path .
```
## Creat wallet
Do not forget to save your wallet information given as terminal output.
```bash
snarkos account new
```

## Start Prover
You can access your private key in the wallet information that you have saved above.
```bash
./run-prover.sh
```

## Documentation

[Official Guide](https://github.com/AleoHQ/snarkOS)

[Aleo Website](https://www.aleo.org/)


