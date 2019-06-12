# Apache Derby Docker Image
This repository provides a Docker image for Apache Derby using OpenJDK JRE.

## Software Versions
* Derby: 10.15.1.3 (http://db.apache.org/derby/index.html)
* Base Image: Latest OpenJDK 11 JRE image with Debian slim (https://github.com/docker-library/openjdk)

## Image Properties
* Exposes port _1527_
* Provides a volume _/dbs_ that will contain the Apache Derby databases
* _derby.log_ is redirected to _stdout_
* Basic health check that verifies that Derby is attached to the listen port
* Use env variable **$DBNAME** to create a new db  
* USe env varialbe **$DERBY_USER** to set the default user and schema of **$DBNAME**. Default is "APP"

# Run

```
sudo docker run -d -e DBNAME=dbtest -p 1527:1527 -v $(pwd)/dbs:/dbs --name derby -t adito/derby
```