## TinyProxy Dox
Scripts to dockerize [TinyProxy](https://tinyproxy.github.io/).


### How to Use
#### Step 1. Build Base Image

The base image is the fundamental part for tinyproxy docker image.

It is using the latest version of tinyproxy to install and doing automatically image cleanup, so that it only occupies like 400~500MB.

```shell
$ docker build -f base.dockerfile -t base .
```

#### Step 2. Build TinyProxy Image with Entrypoint File

Assume your baseimage named "tinyproxy-base"(change it in _tinyproxy-dox.dockerfile_), use below command to build the final tinyproxy image.

```shell
$ docker build -f tinyproxy-dox.dockerfile -t tinyproxy .
```

#### Questions
__Q1. Why splitting as two dockerfiles?__

A: Because it costs relatively long time to preparing the building environment and executing the build with recent release. 

So splitting into two files will help you focus on your own business and logics in _tinyproxy-dox.dockerfile_ and _entrypoint.sh_, they are more relative to businesses.

__Q2. Why using a entrypoint shell?__

A: Using _entrypoing.sh_ helps you organize your building flow and extract the common parameters you might need to customize. It offers good comments and should be clear enough for later customization.

__Q3. How to test tinyproxy?__

A. Assuming you are in the running container of tinyproxy docker image, then by executing the following command you could check the response.

```shell
curl --proxy localhost:8888 --proxy-user username:password -k https://www.google.com
```

>Be noted that "Allow xxx.xxx.xxx.xxx" only works with "BasicAuth" in _tinyproxy.conf_, so setup in onetime might help to resolve the authorization issue.

### Links
Tinyproxy Homepage
https://tinyproxy.github.io/

Tinyproxy Github Repo
https://github.com/tinyproxy/tinyproxy

How to setup a simple proxy server with tinyproxy (Debian 10 Buster)
https://nxnjz.net/2019/10/how-to-setup-a-simple-proxy-server-with-tinyproxy-debian-10-buster/