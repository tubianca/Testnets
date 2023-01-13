![Logo](https://avatars.githubusercontent.com/u/100386277?s=200&v=4)
# Lava Testnet Guide 

Lava pairs Providers with Applications for scalable, private and uncensored access to Web3.

Lava Network, a trustless market for blockchain Remote Procedure Calls (RPC). Lava facilitates relay requests to any blockchain. The market runs on an appchain built using the Cosmos Software Development Kit (SDK) and Tendermint Byzantine Fault Tolerance (BFT) consensus. Lava exists because there are no cryptoeconomic incentives for providing access to blockchains, like the mining / validator rewards that exist for block building. It is no longer reasonable to expect each network participant to maintain their own node. Today, the most commonly used RPC endpoints are provided through trusted Node-as-a-Service or rate-limited public nodes because running a node requires expertise, is time-intensive, costly and requires an increasingly significant amount of compute resources. Growing demand for robust RPC service has led to concentrated reliance on a small group of node operators. This reintroduces a single point of failure for Web3 and requires trust in node runners to ensure data integrity, scalability, privacy, and censorship-resistance.

## Minimum Hardware Requirements




| CPU | RAM     | GB                |
| :-------- | :------- | :------------------------- |
|   `4` | `8` | `100` |


Note: You may need more than these requirements to be competitive





## Install

The only code you need for the installation is the script created below. With this code, we will set up a node, create a wallet, check our logs and create a validator. 
```bash
wget -O lava.sh https://raw.githubusercontent.com/tubianca/Testnets/main/Lava/lava.sh && chmod +x lava.sh && ./lava.sh
```

## Directions

**STEP 1:**  Use script and choice "🛠 Install Lava Node" option to start

**STEP 2:**  Use script to check the logs by choice  "👀 Check Logs" option 

**STEP 3:**  Use script Choice "🔑 Create wallet" option to creat your Lava wallet
(make sure you take note of Mnemonic after you create the wallet, because without it you can't recover the wallet.)

**STEP 4:**  Go to [Faucet](https://discord.com/channels/963778337904427018/1059851367717556314) and get test tokens to creat validator ($request YOURLAVAWALLETADRESS )

**STEP 5:**  Next you have to make sure your validator is syncing blocks. You can use command below to check synchronization status
(wait for catching_up": False)


```bash
$HOME/.lava/cosmovisor/current/bin/lavad status | jq
```
**STEP 6:**   Use script and choice "💎 Be validator" option.

That's all. Your node is ready for Lava.  Don't forget to backup your CONFIG file.


## Documentation

[Official Guide](https://docs.lavanet.xyz/)

[Lava Website](lavanet.xyz)


