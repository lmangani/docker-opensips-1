NAME ?= opensips
OPENSIPS_VERSION ?= master

all: build start

.PHONY: build start
build:
	docker build --build-arg=VERSION=$(OPENSIPS_VERSION) --tag="opensips/opensips:$(OPENSIPS_VERSION)" .

start:
	docker run -d --name $(NAME) -p 5060:5060/udp -p 5061:5061/tcp opensips/opensips:$(OPENSIPS_VERSION)

stop:
	docker stop $(NAME)

remove:
	docker rm -v $(NAME)
	
test:
	docker run -ti --rm --name $(NAME) -p 5060:5060/udp -p 5061:5061/tcp opensips/opensips:$(OPENSIPS_VERSION)
