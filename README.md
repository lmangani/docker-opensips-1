# OpenSIPS Docker Image
http://www.opensips.org/

Docker recipe for building and starting an OpenSIPS image

## Building the image
You can build the docker image by running:
```
make build
```

This command will build a docker image with OpenSIPS using repository packages. 
To build a different git version, you can run:
```
OPENSIPS_VERSION=2.3 make build
```

To start the image, simply run:
```
make start
```
