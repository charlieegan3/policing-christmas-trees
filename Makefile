PROJECT := charlieegan3/policing-christmas-trees
TAG := $(shell tar -cf - . | md5sum | cut -f 1 -d " ")

build_%:
	cd $* && docker build -t $(PROJECT)-$*:$(TAG) -t $(PROJECT)-$*:latest .

push_%: build_%
	docker push $(PROJECT)-$*:$(TAG)

test_server:
	cd server && opa test *.rego -v --explain=notes

vue_image:
	docker build -t $(PROJECT)-vue -f frontend/Dockerfile.dev frontend

vue_install: vue_image
	cd frontend && docker run -it -v $$(pwd):/app $(PROJECT)-vue yarn install

vue_serve: vue_install
	cd frontend && docker run -it -v $$(pwd):/app --network="host" $(PROJECT)-vue yarn serve

build_push_all:
	cd server && docker build -t $(PROJECT)-server:$(TAG) .
	cd server && docker build -t $(PROJECT)-server:arm-$(TAG) -f Dockerfile.arm .
	cd frontend && docker build -t $(PROJECT)-frontend:$(TAG) .
	cd frontend && docker build -t $(PROJECT)-frontend:arm-$(TAG) -f Dockerfile.arm .
	docker push $(PROJECT)-server:$(TAG)
	docker push $(PROJECT)-server:arm-$(TAG)
	docker push $(PROJECT)-frontend:$(TAG)
	docker push $(PROJECT)-frontend:arm-$(TAG)
