# NGINX Rate Limiting


1. Open a terminal in this directory
2. Run `docker compose up -d` (or `docker compose up`) to start the services
3. Use a tool such as the [Ddosify Docker Extenion](https://open.docker.com/extensions/marketplace?extensionId=ddosify/ddosify-docker-extension) to load test the two endpoints.


# Testing With Ddosify

- Make sure to use the following urls, when testing from a container such as Ddosify Docker Extension:
    - http://host.docker.internal:8080/rate-limit
    - http://host.docker.internal:8080/no-limit

- When testing from outside of the container, make sure to use these urls:   
    - http://localhost:8080/rate-limit
    - http://localhost:8080/no-limit



# Examples of results using Ddosify
| **Status**                        | **Successful Run** | **Failed Run** | **Avg. Duration**  |
|-----------------------------------|--------------------|----------------|--------------------|
| ✔️ Successful Run: 70             | 70 (100%)          | 0 (0%)          | 0.00539s           |
| ✔️ Successful Run: 100            | 100 (100%)         | 0 (0%)          | 0.00454s           |

## Test on /no-limit endpoint
### Parameters
| **Parameter**       | **Value**                  |
|------------------|----------------------------|
| **URL**          | host.docker.internal:8080/no-limit |
| **Request Count**| 100                        |
| **Duration(s)**  | 2                          |
| **Load Type**    | Linear                     |

### Result Counts
| **Metric**                        | **Value**          |
|------------------------------------|--------------------|
| **Success Count**                  | 100 (100%)         |
| **Failed Count**                   | 0 (0%)             |

### Durations (Avg)
| **Metric**                        | **Duration**       |
|------------------------------------|--------------------|
| **DNS**                            | 0.0000s            |
| **Connection**                     | 0.0001s            |
| **Request Write**                  | 0.0000s            |
| **Server Processing**              | 0.0044s            |
| **Response Read**                  | 0.0000s            |
| **Total**                          | 0.0045s            |

### Status Code (Message) - Count
| **Status Code** | **Count**         |
|-----------------|-------------------|
| 200 (OK)        | 100               |

## Test on /rate-limit endpoint
### Parameters
| **Parameter**       | **Value**                  |
|------------------|----------------------------|
| **URL**          | host.docker.internal:8080/rate-limit |
| **Request Count**| 100                        |
| **Duration(s)**  | 2                          |
| **Load Type**    | Linear                     |


| **Status**                        | **Successful Run** | **Failed Run** | **Avg. Duration**  |
|-----------------------------------|--------------------|----------------|--------------------|
| ✔️ Successful Run: 70             | 70 (100%)          | 0 (0%)          | 0.00410s           |
| ✔️ Successful Run: 100            | 100 (100%)         | 0 (0%)          | 0.00407s           |

## Result
| **Metric**                        | **Value**          |
|------------------------------------|--------------------|
| **Success Count**                  | 100 (100%)         |
| **Failed Count**                   | 0 (0%)             |

### Durations (Avg)
| **Metric**                        | **Duration**       |
|------------------------------------|--------------------|
| **DNS**                            | 0.0000s            |
| **Connection**                     | 0.0001s            |
| **Request Write**                  | 0.0000s            |
| **Server Processing**              | 0.0039s            |
| **Response Read**                  | 0.0000s            |
| **Total**                          | 0.0041s            |

### Status Code (Message) - Count
| **Status Code**         | **Count**         |
|-------------------------|-------------------|
| 200 (OK)                | 20                |
| 429 (Too Many Requests) | 80                |
