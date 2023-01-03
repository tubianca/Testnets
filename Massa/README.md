![Logo](https://static.wixstatic.com/media/0669d3_7e53eea984a047ba86659e34452e24ff~mv2.png/v1/fill/w_198,h_198,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/3F42F1E3-8627-4BE5-A95E-6411E306BFCF_PNG.png)

#Massa Labs 

Massa is a truly decentralized blockchain controlled by thousands of people. With the breakthrough multithreaded technology, we’re set for mass adoption.



## Minimum Hardware Requirements




| CPU | RAM     | GB                |
| :-------- | :------- | :------------------------- |
| `4` | `8` | 60 |


Not:Right now 4 cores and 8 GB of RAM should be enough to run a node, but it might increase in the future. More info in the FAQ.


## Install

Use script for a quick installation:
```bash
  wget https://raw.githubusercontent.com/tubianca/Testnets/main/Massa/massascript.sh  && chmod 777 massascript.sh && sudo ./massascript.sh
```


## Post installation

To check your node logs

```bash
screen -r massa-node
```

To check your client command page
```bash
screen -r massa-client
```

## Creat wallet and save discord bot

Open your client
```bash
screen -r massa-client
```

Create new wallet 
```bash
wallet_generate_secret_key
```
Check your wallet details
(copy your adress and paste to testnet-faucet channel on Massa discord)
```bash
wallet_info
```
Buy rols (make sure you are on client screen to paste code )
```bash
buy_rolls <addres> 1 0
```
Save your secret key for staking 
```bash
node_add_staking_secret_keys <secretKey>
```
Go the Massa discord server and click 👍 in the testnet-rewards-registration channel.
```bash
node_testnet_rewards_program_ownership_proof <your_staking_address> <discordId>
```
Copy the terminal output and send it to the discord bot.
then send the ip address of your server as well.

## Documentation

[Official Guide](https://docs.massa.net/en/latest/testnet/install.html)

[Massa Website](https://massa.net/)


