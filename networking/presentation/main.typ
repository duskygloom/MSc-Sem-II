#import "@preview/touying:0.7.3": *
#import themes.metropolis: *

#set list(marker: ("#", "-"))

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  align: top,
  config-info(
    title: [DNS],
    author: [Harsh Sarkar],
    institution: [M.Sc. Computer Science, Visva-bharati],
    subtitle: [Static and dynamic DNS],
  ),
)

#show table.cell.where(y: 0): set block(
  inset: (y: 0.4em),
  fill: luma(230),
  stroke: black,
)


= DNS: Domain Name System

== Introduction

- Any resource available in a network must be located in a computer connected to the network, and has to be accessed by using the network address of the computer.
- DNS allows us to use high-level, readable names to identify computers in a network.
- Advantages:
  - We do not need to remember IP addresses to access a computer.
  - An organization can change its IP address without needing to inform its users as the host name remains unchanged.

== History

- Back in the ARPANET days, a file, _hosts.txt_, /* see /etc/hosts */ listed all the computer names and their IP addresses.
- Every night, all of the hosts would fetch it from the site at which it was maintained.
- Disadvantages:
  - The size of the file would become too large.
  - Host name conflicts would occur constantly unless names were centrally managed, something unthinkable in a huge international network due to the load and latency.
- The *Domain Name System* was invented in 1983 to address these problems.

== Overview

- To map a name onto an IP address, an application program calls a library procedure called the *stub resolver*, passing it the name as a parameter.
- The stub resolver sends a query containing the name to a local DNS resolver called the *local resolver*.
- The local resolver performs a *recursive lookup* for the name against a set of DNS resolvers.
- Once the local resolver receives a reply containing the IP address, it caches the reply and forwards it to the stub resolver, which in turn returns it to the application.
- DNS utilizes UDP to transfer queries and replies through port 53.
- The `dig` tool in linux can be used to inspect the entire resolution process.

#figure(
  caption: [DNS resolution],
  image("assets/dns_lookup_iterative.png", height: 18em),
)

== DNS Namespace

- Managing a large and constantly changing set of names is a nontrivial problem. In the postal system, name management is done by requiring letters to specify the country, state or province, city, street address, and name of the addressee.
- For the Internet, the top of the naming hierarchy is managed by an organization called *ICANN* (Internet Corporation for Assigned Names and Numbers, _estd 1998_).
- The Internet is divided into over 250 top-level domains (TLDs). Each TLD is further divided into sub-domains which are further partitioned and so on. In the hostname, the partitions are separated by the dot symbol.
- There are two types of TDLs:
  - *Generic domains:* Domains introduced via applications to ICAAN.
  - *Country domains:* A domain for each country.

#pagebreak()

- TLDs are run by *registrars* appointed by ICANN.
- Getting a second-level domain requires going to the required registrar. The registrar checks if the desired name is available, and then the requester pays the registrar an annual fee and gets the name.
- Each domain controls how it allocates the domains under it.
- For example: To create a new hostname for our department, say _dcss.visvabharati.ac.in_, we only need to contact our university IT department and not the registrar of _in_.

#figure(
  caption: [DNS namespace],
  image("assets/dns_namespace.png", height: 18em),
)

== Domain Resource Records

- Every domain has a set of *resource records* associated with it.
- The primary function of DNS is to map domain names onto resource records.
- A resource record is a five-tuple consisting of:
  + *Domain name:* Specifies the domain to which the record belongs.
  + *Time to live:* Specifies how long the DNS cache will persist.
  + *Class:* Specifies the network context. For most of the cases, it is _IN_ and stands for _Internet_.
  + *Type:* Tells what kind of record it is. Some important record types will be discussed later.
  + *Value:* Contains some additional data about the record. As for the type of data, it depends on the record type.

== Record Types

#figure(caption: [Commonly used record types], table(
  columns: (1fr, 2fr, 4fr),
  align: (left,) * 3,
  table.header([*Type*], [*Meaning*], [*Value*]),

  [_SOA_],
  [Start Of Authority],
  [Provides the name of the authoritative name server, email address of its administrator, a unique serial number, and various flags and timeouts.],

  [_A_], [Address], [Holds a 32-bit IPv4 address of a host.],

  [_AAAA_], [IPv6 Address], [Holds a 128-bit IPv6 address of a host.],

  [_NS_],
  [Name Server],
  [Specifies a name server for the domain. A name server contains a copy of the DNS database of the domain.],

  [_CNAME_], [Canonical Name], [Allow aliases to be created.],

  [_PTR_],
  [Pointer],
  [Points to another name. It is used to associate a name with an IP address during *reverse lookup*.],
))

#pagebreak()

#figure(caption: [Examples of DNS records], table(
  columns: (2fr, 1fr, 1fr, 1fr, 3fr),
  align: (left,) * 5,
  table.header([*Domain*], [*TTL*], [*Class*], [*Type*], [*Value*]),
  [_._], [2754], [`IN`], [`NS`], [_e.root-servers.net._],
  [_visvabharati.ac.in._], [900], [`IN`], [`NS`], [_toby.ns.cloudflare.com._],
  [_visvabharati.ac.in._], [300], [`IN`], [`A`], [_103.14.99.163_],
  [_visvabharati.ac.in._],
  [1800],
  [`IN`],
  [`SOA`],
  [_demi.ns.cloudflare.com._ _dns.cloudflare.com._ 2404087003 10000 2400 604800 1800],

  [_163.99.14.103.in-addr.arpa._], [3600], [`IN`], [`PTR`], [_cloud.visvabharati.ac.in._],
  [_www.visvabharati.ac.in._], [300], [`IN`], [`CNAME`], [_visvabharati.ac.in._],
))

== Name Servers

- To avoid the problems associated with having only a single source of information, the DNS name space is divided into nonoverlapping *zones*.
- A zone usually contains one _primary name server_, which gets its information from a file on its disk, and one or more _secondary name servers_, which get their information from the primary name server.
- Types of name servers:
  - *Root name servers:* These servers maintain the root of the DNS hierarchy. Provides reference to TLDs. For more information on root name servers, go to #link("https://www.iana.org/domains/root/servers", text(fill: blue, underline("www.iana.org"))).
  - *TLD name servers:* These servers maintain the top-level domains of the DNS hierarcy. For more information on TLD name servers, go to #link("https://www.iana.org/domains/root/db", text(fill: blue, underline("www.iana.org"))).
  - *Authoritative name servers:* They are the primary name servers of their respective zones and contain the DNS database.
  - *Local name servers:* Same as the _local resolvers_ discussed earlier.
#figure(
  caption: [DNS namespace divided into zones],
  image("assets/dns_zones.png", height: 18em),
)
#figure(
  caption: [Root name servers, _source: wikipedia.org_],
  image("assets/root_name_servers.png", height: 17em),
)

== Name Resolution

#figure(
  caption: [Recursive name resolution],
  image("assets/dns_lookup_recursive.png", height: 17em),
)

== References

+ _Computer Networks, A Tanenbaum - 5th Edition_
+ _Computer Networking: A Top-Down Approach, Kurose - 6th Edition_
+ #link("https://chatgpt.com", text(fill: blue, underline("https://chatgpt.com")))
+ #link("https://en.wikipedia.org", text(fill: blue, underline("https://en.wikipedia.org")))
+ Linux `man` pages
