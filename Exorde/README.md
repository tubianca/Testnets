
![Logo](https://static.wixstatic.com/media/0669d3_27dbba77fa7c42f78a92f3f559094d46~mv2.png/v1/fill/w_284,h_284,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/B6622963-6E7A-4C9A-8900-3AB743652BAA_PNG.png)
# Exorde Testnet Guide 

Exorde is a data aggregation and linking protocol. In simple terms, the project protocol collects all possible data from social networks, videos, articles, photos, comments, etc. Then, in a decentralized data pipeline, all this information is processed and the output is a graph of data, which connects all the similar facts.

$EXD is the utility token of the Exorde protocol.

All contributors can earn reputation and EXD, the cryptocurrency of the Exorde protocol


## Minimum Hardware Requirements



| CPU | RAM     | GB                |
| :-------- | :------- | :------------------------- |
|   `2` | `4` | `1` |


Not:You will require more than these requirement in order to be competitive



## Install

1-Use script for a quick installation(end of the installation you will see that your docker ACTIVE. kindly press CTRL+C and follow the commands bellow)
```bash
wget -O exorde.sh https://raw.githubusercontent.com/tubianca/Testnets/main/Exorde/exorde.sh && chmod +x exorde.sh && ./exorde.sh
```

2-Open Screen
```bash
screen -S exorde
```

3-Change <YOUR_MAIN_ETH_ADDRESS> with your main Ethereum (ETH) Mainnet address.
```bash
docker run -d --restart unless-stopped --pull always --name exorde-cli exordelabs/exorde-cli -m <YOUR_MAIN_ETH_ADDRESS> -l 2

```

## Node Check Commands

Check if your container are working

```bash
docker ps
```
Restart node

```bash
docker restart exorde-cli
```
Check Logs
```bash
docker logs --follow  exorde-cli
```

## Update to Newest Version
Stop docker
```bash
docker stop exorde-cli
```
Delete docker
```bash
docker rm exorde-cli
```
Pull newest version and start
```bash
docker run -d --restart unless-stopped --pull always --name exorde-cli exordelabs/exorde-cli -m <YOUR_MAIN_ETH_ADDRESS> -l 2
```

## Documentation

[Official Guide](https://docs.exorde.network/)

[Exorde Website](https://exorde.network/)


