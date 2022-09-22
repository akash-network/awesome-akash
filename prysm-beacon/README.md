# Prysm's beacon node

The beacon-chain node shipped with Prysm is the keystone component of the Ethereum proof-of-stake protocol. It is responsible for running a full Proof-of-Stake blockchain, known as a beacon chain, which uses distributed consensus to agree on blocks both proposed and attested on by validators in the network. Beacon nodes communicate their processed blocks to their peers via a P2P (peer-to-peer) network, which also manages the lifecycle process of active validator clients.

https://docs.prylabs.network/docs/getting-started

# Beacon node functionality

At runtime, the beacon node initialises and maintains a number of services that are all vital to providing all the features of Ethereum proof-of-stake. In no particular order, these services include:

- A blockchain service which processes incoming blocks from the network, advances the beacon chain's state, and applies a fork choice rule to select the best head block.
- An operations service prepares information contained in beacon blocks received from peers (such as block deposits and attestations) for inclusion into new validator blocks.
- A core package containing Ethereum beacon-chain core functions, utilities, and state transitions required for conformity with the protocol.
- A sync service which both queries nodes across the network to ensure latest canonical head and state are synced and processes incoming block announcements from peers.
- An ETH 1.0 service that listens to latest event logs from the validator deposit contract and the ETH 1.0 blockchain.
- A public RPC server that requests information about the beacon chain's state, the latest block, validator information, etcetera.
- A P2P server which handles the life cycle of peer connections and facilitates broadcasting across the network.
- A full test suite for running simulation on Ethereum beacon chain state transitions, benchmarks and conformity tests across clients.

We isolate each of these services into separate packages, each responsible for its own life cycle, logging and dependency management. Each Prysm service implements an interface to start, stop, and verify its status at any time.

## Blockchain service

The blockchain service is arguably the most important part of the project, as it allows the network to reach consensus on the state of the protocol itself. It is responsible for handling the life cycle of blocks, and applies the fork choice rule and state transition function provided by the core package to advance the beacon chain.

In Ethereum, blocks can be proposed in intervals known as slots, which are period of seconds. During a slot, proposers are assigned to create and send blocks into the beacon node for acceptance. It is possible, however, that proposer may fail to do their job at their assigned slot; in this case, the blockchain service processes skipped slots appropriately to ensure that the chain does not stall.

## Operations service

The operations service handles important information contained in blocks on the beacon chain, such as voluntary validator exits, proposals, attestations, slashings and more. The operation is received from the sync service via the P2P network, or from data the node retrieves locally.

## Core package

The core package implements the Ethereum beacon chain state transition function, as well as the core helpers and utilities. Every function that manages block processing, epoch processing, validator shuffling and finality is defined within this package. It is designed to be a near-identical translation of the official specification. The aim is to keep this package as free of outside code as possible, and it is comprised of mostly pure functions which do not require access to the other services across Prysm to function.

## Sync service

The sync service has two responsibilities: ensuring the local beacon chain is up-to-date with the latest canonical head and state as observed by the network, and to listen and respond to requests for new block announcements from peers. The service was designed to be as independent as possible from the rest of the system, and is the main point of interaction for peers over the P2P network. Everything in the sync service runs concurrently through a single Start() function, which handles several different message requests and responses.

## ETH1 service

The ETH1 service uses the go-ethereum ethclient to connect to a running Ethereum 1.0 node in order to listen for incoming validator deposit contract logs. The validator clients include deposit objects inside of their proposed blocks, and the beacon chain state transition function then activates any pending validators from these deposits.

As the beacon node will need to frequently access information and one cannot rely on perfect latency from the ETH1 node, the service also includes the ability to cache received logs and blocks from the Ethereum 1.0 chain.
Public RPC server#

The public RPC server is one of the most critical components of the beacon node. It implements a variety of methods that validators connected to the node can query and obtain assignments to propose or attest blocks. The API is defined in a protobuf formatted file, and any client that implements the client side of these methods can connect via gRPC to the beacon node and begin requesting data from its public endpoints.
