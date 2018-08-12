# IT Networking Fundamentals

## TCP/IP suite

A `network protocol` is a common language that systems on a network use to
comunicate with one another. It has rules to define the communication.

TCP/IP is a `nonproprietary group of protocols` that provide communication among
different `routable network segments`.

TCP/IP uses a layered architecture similar to the OSI reference model:
- `application layer` (giving programs access to the internet)
- `transport layer` (creating packages of data)
- `internet layer` (addressing and routing of packets)
- `network interface` layer (ethernet, token ring, ATM, etc)

Example:

+---------------------+-------------------------+-------------------------------+
| *Layer*             | *Client*                | *Server*                      |
+---------------------+-------------------------+-------------------------------+
| Application         | Web Browser             | Web Server                    |
+---------------------+-------------------------+-------------------------------+
| Transport           | TCP                     | TCP                           |
+---------------------+-------------------------+-------------------------------+
| Internet            | IP addressing and ARP   | Protocol Address verification |
+---------------------+-------------------------+-------------------------------+
| Network Interface   | Frames and CRCs         | MAC verification              |
+---------------------+-------------------------+-------------------------------+

CRC = Cycle Redundancy Check

source: https://www.udemy.com/it-networking-comptia-network-n10-006/learn/v4/t/lecture/3067934

### Transport Layer

Many functions are performed at the transport layer by TCP and UDP. The primary
function at the transport layer is to divide large packets into smaller sections
ready for transport. A process known as `fragmentation`, that ensures faster
transference and more efficient communication.

The size of the packet is defined by the network architecture and other factors.

Because the data is broken in multiple parts, each part receives a `sequence
number` and the destination system uses this information to reassemble the data.

TCP/IP networks are categorized as `packet-switched networks`, where packets can
travel through different paths and order.

The transport layer identifies the application layer using `port numbers` and
`sockets`.

TCP also provides the concept of `windowing` and `acknowledgment`, during the
`session negotiation` the size X of the window is stablished, so the source will
always send X packets to the destination and will wait for your aknowledgment
before send the next X packets or resend the same X "lost" packets.

UDP is categorized as `connectionless`, reliability in this case is
responsibility of the programs itself. It also is known as a "fire and forget"
protocol.

The choice of which transport protocol you are using will depend on the upper
layer protocols that are in use.

The port number in combination with the destination IP addres is known as a
`socket`.

### Internet Layer

The protocols that exist in this layer are those that are in coltrol of packets
and their moviment across the network, they are responsible for addressing and
routing.

IP protocol is resposible for addressing packets (IPv4 or IPv6), determines the
routing that packets take and delivers packets to the next hop.

ARP is used to resolve MAC and cache addresses on behalf of IP.

ICMP is a throubleshooting protocol for TCP/IP, used by ping, traceRT, etc. The
`ping` sends an `echo` request and hopes for the echo reply.

IGMP provides multicasting for TCP/IP, it keeps track of the membership
associated with the multicast address.
