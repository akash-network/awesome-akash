# What is iPerf / iPerf3 ?
iPerf3 is a tool for active measurements of the maximum achievable bandwidth on IP networks. It supports tuning of various parameters related to timing, buffers and protocols (TCP, UDP, SCTP with IPv4 and IPv6). For each test it reports the bandwidth, loss, and other parameters.

## Typical Workflow
On Server machine:
```
# Start server listening on specific port
iperf3 -s -p 5201
```

On Client machine:
```
# Connect to server at 127.0.0.1
iperf3 -c 127.0.0.1 -p 5201
```
