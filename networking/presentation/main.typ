#import "@preview/touying:0.7.3": *
#import themes.metropolis: *

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  align: top,
  config-info(
    title: [DNS],
    author: [Harsh Sarkar],
    institution: [M.Sc. Semester II, Computer Science, Visva-bharati],
    subtitle: [Static and Dynamic DNS],
    // logo: image("assets/visvabharati_logo.png", height: 1.5em),
  ),
)

#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()

#show table.cell.where(y: 0): set block(
  inset: (y: 0.4em),
  fill: luma(230),
  stroke: black,
)

#set list(marker: ("#", "-"))

#title-slide()

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
- Different types of name servers:
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
  caption: [Recursive + iterative name resolution],
  image("assets/dns_lookup_iterative.png", height: 18em),
)

#figure(
  caption: [Recursive name resolution],
  image("assets/dns_lookup_recursive.png", height: 18em),
)

= Static and Dynamic DNS

== Static IP Address

- A static IP address is a manually configured identifier assigned to a device that remains consistent and cannot change across multiple network sessions.
- Individuals do not typically need a static IP address, but businesses need them to host their own servers. Server and account administrators may also use whitelisted static IP addresses to manage sensitive assets that block most IP addresses.

#grid(
  columns: (1fr, 1fr),
  [
    - *Pros*
      - Better name resolution
      - Anywhere and anytime access
  ],
  [
    - *Cons*
      - Easy-to-track addresses
      - Difficult to change
      - Costly
  ],
)

== Dynamic IP Address

- ISPs temporarily assign dynamic IP addresses via the *Dynamic Host Configuration Protocol* (DHCP) server. This means an IP address can change every time a user reboots their router or system, and when the user connects to their ISP service.
- When not in use, a dynamic IP addresses can be automatically assigned to another device. This makes dynamic IP addresses more suitable for home networks than large organizations.

#grid(
  columns: (1fr, 1fr),
  [
    - *Pros*
      - Cost reduction
      - Enhanced security
      - Automatic configuration
  ],
  [
    - *Cons*
      - Hosting problems
      - Problematic remote access
  ],
)

== Static DNS

- DNS maps hostnames to IP addresses.
- A new hostname (e.g. _dcss.visvabharati.ac.in_) can be created under an existing hostname (e.g. _visvabharati.ac.in_) without informing name servers higher in the DNS hierarchy by adding a new record in the authoritative name server of the university.
- But what if we want to change the IP address associated with the hostname? Futhermore, what if the IP address is dynamic and changes without our knowledge?


== Dynamic DNS (DDNS)

- In a *Dynamic DNS*, the record automatically changes when there is a change in the IP address of a host.
- How is it done?
  + *Provider API*
    - A DNS provider may provide an API to update our record. It also authenticates the API request to ensure no unauthorized person can update our record.
    - In most cases, the provider also provides a GUI application to simplify the process.
  + *RFC 2136*
    - The RFC 2136 standard, titled _Dynamic Updates in the Domain Name System (DNS UPDATE)_, defines a protocol extension that allows DNS records to be added, modified, or deleted programmatically without manually editing zone files.
    - It especially focuses on validation and authentication so that there is no issue when updating DNS records.

= DNS Providers

== Cloudflare

- Cloudflare is more than just a DNS provider. Cloudflare is a platform that provides web services essential to build, deploy, secure and scale applications fast and with ease.
- They provide a wide range of services including:
  - Database and storage
  - DDoS protection and rate limiting
  - CDN, DNS and load balancing
  - And a lot more...
- Cloudflare was launched in 2010, and by 2019, Cloudflare’s global network spanned 193 cities across more than 90 countries and it is still growing.
- Cloudflare now powers 20% of the Internet!
- You may read this blog at #link("https://blog.cloudflare.com/scaling-the-cloudflare-global/", text(blue, underline("https://blog.cloudflare.com"))) to learn more.

#figure(
  caption: [Distribution of Cloudflare data centers, _source: cloudflare.com_],
  image("assets/cloudflare_data_centers.png", height: 18em),
)


== No-IP

- No-IP provides DNS services for both personal and business use cases.
- It offers the following services:
  - Dynamic DNS
  - Managed DNS
  - Fast and reliable DNS due to a global Anycast network of more than 150 servers worldwide.
- No-IP provides a free DDNS domain along with an application to automatically update IP address. So, you may use your free domain by creating a No-IP account.

#figure(
  caption: [Distribution of No-IP DNS servers, _source: noip.com_],
  image("assets/noip_servers.png", height: 18em),
)

== Duck DNS

- _what does the service actually do?_\
  Duck DNS is a free service which will point a DNS (sub domains of duckdns.org) to an IP of your choice
- _who are we?_\
  the team consists of two software engineers who each have worked in the industry for over 15 years
- _why do I need a dynamic DNS service_\
  DDNS is a handy way for you to refer to a server/router with an easily rememberable name, where the servers ip address is likely to change when your router reconnects, or ec2 server reboots, its ip address is set by the provider of that connection, this means it may update at any time
- _why make a free DDNS service?_\
  because we can, because before we started we couldn't, learning is fun


= Proxy & Reverse Proxy

== Proxy

#grid(
  columns: (1fr, 1fr),
  [
    - Every time you open a website, your device talks directly to another server on the Internet. Your IP address, location and basic network details are visible to that server. In many cases, this is fine. But there are situations where you may want more control over how your requests travel across the Internet.
    - A *proxy* acts as an intermediary between you and the Internet.
    - From the server’s point of view, it’s the proxy that is making the request, not you.
  ],
  figure(
    caption: [Proxy server as an intermediary],
    image("assets/proxy.png", height: 14em),
  ),
)

== Internet Requests without a Proxy

- When you type a website address into your browser, your computer resolves the domain name to an IP address using DNS. It then opens a connection directly to that server.
- Your IP address is included as part of the network connection so the server knows where to send the response.
- The server can log your IP address, infer your location, detect your network provider and apply rules based on that information.
- Some websites restrict access by country. Others rate-limit or block traffic from specific IP ranges. In automated systems, repeated requests from the same IP are often flagged as suspicious.

== Types of Proxies

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1em,
  [
    *Forward Proxies*
    - These are used by clients to access external resources.
    - Corporate networks often use forward proxies to control employee internet access.
    #image("assets/forward_proxy.png")
  ],

  [
    *Reverse Proxies*
    - They sit in front of servers rather than clients.
    - Websites use reverse proxies to load balance traffic, terminate TLS and protect backend systems.
    #image("assets/reverse_proxy.png")
  ],
)

== Proxy Use Cases

- *To protect online identity:* One of the most common reasons to use a proxy is IP masking. By routing traffic through a proxy, your real IP address is hidden from the destination server.
- *Bypass geographic restrictions:* Proxies are also used for geographic routing. If a service behaves differently in different countries, a proxy located in a specific region lets you see what users there experience.
- *Automation and web scraping:* In automation and scraping systems, proxies are essential. Sending thousands of requests from a single IP is a fast way to get blocked. Rotating proxies distribute traffic across many IPs, reducing detection.
- *Monitor and restrict traffic:* Companies use proxies to monitor, filter and log traffic. This helps with compliance, security and performance optimisation.

== Reverse Proxy Use Cases

- *Load balancing:* Popular websites have multiple servers distributed all over the world. By using a reverse proxy, the client sends requests only to the proxy, and the proxy forwards it to a suitable server among the pool of servers.
- *Protection from attacks:* Since only the reverse proxy is visible to the public, an attacker can only attack the proxy server which has tighter security implemented.
- *Caching:* A reverse proxy server can also cache content, resulting in faster performance.

== NGINX

- *NGINX* is a free and open-source web server known for its high performance and low resource consumption.
- Beyond serving static web files, it is heavily used as a reverse proxy, load balancer, API gateway and HTTP cache.
- Key features:
  - *Reverse proxy:* Intercepts client requests and forwards them to backend application servers, hiding the backend structure for improved security and flexibility.
  - *Load balancer:* Distributes incoming network traffic across multiple servers, ensuring high availability and preventing any single server from becoming a bottleneck.
  - *Caching:* Efficiently serves static assets like images, HTML and CSS while offloading requests to application servers.
- NGINX provides easy-to-understand documentation, so if you want to get started, visit:\
  #link("https://nginx.org/en/docs/beginners_guide.html", text(
    blue,
    underline("https://nginx.org/en/docs/beginners_guide.html"),
  ))

= References

+ _Computer Networks, A Tanenbaum - 5th Edition_
+ _Computer Networking: A Top-Down Approach, Kurose - 6th Edition_
+ #link("https://chatgpt.com", text(fill: blue, underline("https://chatgpt.com")))
+ Linux `man` pages
+ #link("https://en.wikipedia.org/wiki/Root_name_server", text(
    fill: blue,
    underline("https://en.wikipedia.org/wiki/Root_name_server"),
  ))
+ #link("https://www.fortinet.com/resources/cyberglossary/static-vs-dynamic-ip", text(
    fill: blue,
    underline("https://www.fortinet.com/resources/cyberglossary/static-vs-dynamic-ip"),
  ))
+ #link("https://www.cloudflare.com/", text(blue, underline("https://www.cloudflare.com")))
+ #link("https://www.noip.com/", text(blue, underline("https://www.noip.com")))
+ #link("https://www.freecodecamp.org/news/a-developers-guide-to-proxy-servers", text(
    blue,
    underline("https://www.freecodecamp.org/news/a-developers-guide-to-proxy-servers"),
  ))
+ #link("https://www.cloudflare.com/learning/cdn/glossary/reverse-proxy", text(
    blue,
    underline("https://www.cloudflare.com/learning/cdn/glossary/reverse-proxy"),
  ))
+ #link("https://nginx.org", text(blue, underline("https://nginx.org")))
