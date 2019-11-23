PROJECT := charlieegan3/policing-christmas-trees
TAG := $(shell tar -cf - . | md5sum | cut -f 1 -d " ")

build_%:
	cd $* && docker build -t $(PROJECT)-$*:$(TAG) -t $(PROJECT)-$*:latest .

push_%: build_%
	docker push $(PROJECT)-$*:$(TAG)

test_server:
	cd server && opa test *.rego -v --explain=notes
