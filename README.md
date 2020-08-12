# README


## Build
```bash
docker build -t portfolio:local .
```

## Run
```bash
docker run -d --name portfolio -v ${PWD}/workspace:/opt/portfolio/workspace -p 5800:5800 -e KEEP_APP_RUNNING=1 -e USER_ID=0 -e GROUP_ID=0 -e TZ="Europe/Berlin" portfolio:local
```

## Links
* https://forum.portfolio-performance.info/t/portfolio-performance-in-docker/10062