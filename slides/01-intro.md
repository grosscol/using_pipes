---
author: Colin Gross
title: Working with Pipes
---

# Pipes
- One way interprocess communication
- First in, first out
- Backed my memory

```txt
echo "example" | wc
```

## Named Pipes
- Looks like a file
- Do not touch disk

```txt
⮞ mkfifo pipe0
⮞ ls
. .. pipe0
```

# Why
- Fast
- Avoid clutter

## RAM is fast. Disk is slow.
_"The disk is molasses"_

  is the new 

_"The floor is lava"_

## Latency & Speed

| Read | [Read Latency](https://people.eecs.berkeley.edu/~rcs/research/interactive_latency.html) | [Throughput](https://www.eatyourbytes.com/ddr4-ram-data-transfers-speed-latency-and-voltage/)      |
|------|----------------|------------|
| RAM  |           3 μs | 35000 Mb/s |
| SSD  |         825 μs |   500 Mb/s |

Disks have transfer time, controller overhead, queuing delay

