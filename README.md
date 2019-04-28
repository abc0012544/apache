# Apache

Apache VM base on Ubuntu 14.04

Installation

```
docker pull abc0012544/apache
```

Run with 22 and 80 ports opened:

```
docker run -d -it -p 30022:22 -p 30080:80 abc0012544/apache
```

Connect apache VM with following setting:

Login by SSH

```
ssh root@localhost -p 30022

password: Test1234
```
Web URL:

```
http://localhost:30080
```