# Portfolio Performance (dockerized)

This is a dockerized version of [Portfolio Performance](https://www.portfolio-performance.info/en/).

An open source tool to calculate the overall performance of an investment portfolio - across all accounts - using True-Time Weighted Return or Internal Rate of Return.

## Prerequisite
* `docker` is installed, up and running

## Build
```bash
# Change to repo folder
$ cd <REPO-PATH>

# build container
$ docker build -t portfolio:local .
```

## Run
```bash
$ docker run -d --name portfolio \
	-v ${PWD}/workspace:/opt/portfolio/workspace \
	-p 5800:5800 \
	-e KEEP_APP_RUNNING=1 -e USER_ID=0 -e GROUP_ID=0 -e TZ="Europe/Berlin" \
	portfolio:local
```

## Use
Use a browser and connect to Portfolio Performance via URL: `<IP-ADRESS>:5800`
* where `<IP-ADRESS>` is the IP of the machine on which you run the container
* if it's the same machine, then it's e.g. `127.0.0.1` OR `localhost`


Files are saved in the `<REPO>/workspace/` Folder.

## Links
* https://forum.portfolio-performance.info/t/portfolio-performance-in-docker/10062 (thx to Loader23)