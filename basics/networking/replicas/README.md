# Networking & docker compose replicas

This demo shows how each replica of a service in a docker compose (deployed with replicas) can be reached by name.

## How to use
```powershell
# Prepare:
docker compose up -d
# or if you want to specify replicas by cli:
docker compose up -d --scale listener=10 

# Test:
# Perform your tests

# Cleanup:
docker compose down;
```

## Tests

```shell
# Full Curl Output

# The following command:
#   - Starts a container with curl installed
#   - Attaches to the (existing) docker network, created by the docker compose up command
#   - Sends an http request to the container, via dns hostname of the service/container instance 
#           demo = the docker compose NAME (see top of compose.yml)
#           1    = the instance number
docker run --rm --network demo_default curlimages/curl:latest curl http://demo-listener-1:8080 

# When using the default 3 replicas, all 3 following commands should succeed
# Curl instance 1:
docker run --rm --network demo_default curlimages/curl:latest curl http://demo-listener-1:8080 
# Curl instance 2:
docker run --rm --network demo_default curlimages/curl:latest curl http://demo-listener-2:8080 
# Curl instance 3:
docker run --rm --network demo_default curlimages/curl:latest curl http://demo-listener-3:8080

# When using the default 3 replicas, all 3 following commands should timeout (no instance 4 present)
# Curl instance 4:
docker run --rm --network demo_default curlimages/curl:latest curl http://demo-listener-4:8080 

# The following command can be used to display only status code
docker run --rm --network demo_default curlimages/curl:latest curl -o /dev/null -s -w "%{http_code}\n" http://demo-listener-1:8080 

```