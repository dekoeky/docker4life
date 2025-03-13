# Using tcpdump to capture a containers (incoming) traffic


```console
# List network adapters
ip a
```

```console
# Install tcpdump
sudo apt update && sudo apt install tcpdump -y
```

## From inside the nginx container

1. Exec into the nginx container
```console
docker exec -it nginx sh
```

2. Install tcpdump (if not installed)
```console
apt update && apt install -y tcpdump
```

3. Prepare a location to store dumps
You can either:
 - Use a bind mount  
   This is obviously the easiest/best solution, but it requires re upping your compose
 - Store the files in the container, and extract them later  
   A bit more complex, but it requires no changes to the compose  
   In this example, we use this option and so we create a folder for storing the dumps: `mkdir /tmp/network-captures`

4. Capture traffic

```console
# Capture and display traffic on nginx container port 80
tcpdump -i eth0 port 80 -nn -A
```
-- OR --
```console
# Capture and store traffic on nginx container port 80
tcpdump -i eth0 port 80 -nn -w /tmp/network-captures/traffic.pcap
```
 - -i eth0 → Captures traffic on the main network interface.
 - port 80 → Filters traffic for HTTP.
 - -nn → Prevents DNS resolution (faster).
 - -A → Shows ASCII output (easier to read HTTP requests).
 - -w /tmp/network-captures/traffic.pcap → Write traffic to file

5. Extract files from container
This step is only needed when no bind mount is used.
```console
docker cp nginx:/tmp/network-captures ./network-captures
```

## Tip
Test this in github codespaces, if you don't have any linux environment at your disposal.
When you `docker compose up` github will suggest to open a port that is accessible via url in your browser (something like https://some-random-name.app.github.dev)