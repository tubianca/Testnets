
![Logo](https://global-uploads.webflow.com/620b86dd36c9285a4b3048fa/6216af2dd100a155f79b5148_minima_logo.svg)
# Minima Testnet Guide 

Minima IncentiveCash Program that rewards users for running and maintaining a complete node on the Minima network.
As they test and improve Minima ahead of  Mainnet launch, working collaboratively is key to perfecting the Minima application and protocol. 
This is why excited for people to be part of building the network, testing how devices operate, and finding bugs.
In return for collaboratively working together with Minima, users on the IncentiveCash Program will earn one Minima coin each day with their balance updated weekly. All earned coins will be issued at the Token Generation Event, currently scheduled to be in Q2 2022.
The reason behind the IncentiveCash Program is core to our philosophy at Minima. 
Minima believes that to create the most robust, secure, and scalable network, everyone involved must play an equal part. To do this, Minima has made it far easier to run a complete (validating and constructing) node than any other blockchain. People can start running a node via a simple app download, using up no more space or energy than a regular messaging app.
Minima’s ease of adoption will drive the node count which is directly proportional to the resilience and scalability of the network. Having a few hundred, or even a few thousand nodes, does little to reduce the risk of an attack. Having centralized actors such as separate miners, producers, and validators, limits the speed, scalability, and security of what’s truly possible with blockchain technology.


## Minimum Hardware Requirements




| CPU | RAM     | GB                |
| :-------- | :------- | :------------------------- |
|    `1` |  `2` | `50` |


Not:Note: You may need more than these requirements to be competitive






## Install

Use script and choice "🛠 Install Minima Node" option to start
```bash
wget -O minima.sh https://raw.githubusercontent.com/tubianca/Testnets/main/Minima/minima.sh && chmod +x minima.sh && ./minima.sh
```

You have to set your password and insert it with ‘YOURPASSWORD’ in the command below
```bash
docker run -d -e minima_mdspassword=YOURPASSWORD -e minima_server=true -v ~/minimadocker9001:/home/minima/data -p 9001-9004:9001-9004 --restart unless-stopped --name minima9001 minimaglobal/minima:latest
```

Ensure Docker starts up automatically when the server starts
```bash
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
```

Start a Watchtower container to automatically update Minima when a new version is available.
```bash
docker run -d --restart unless-stopped --name watchtower -e WATCHTOWER_CLEANUP=true -e WATCHTOWER_TIMEOUT=60s -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower
```
## Start the Minima Terminal by running the command

```bash
docker exec -it minima9001 minima
```
Register with your incentive cash uid  (replace your incetivecash uid with xxxx-xxxx-xxxx-xxxx

```bash
incentivecash uid:xxxx-xxxxx-xxxx-xxx
```

Check your node status

```bash
status
```

Back up your Mnemonic

```bash
vault
```
How to check your MiniDapp System password

```bash
mds
```










## Documentation

[Official Guide](https://docs.minima.global/docs/runanode/get_started)

[Aleo Website](https://www.minima.global/)


