image:
	docker build -t charlieegan3/trees-vue .

install: image
	docker run -it -v $$(pwd):/app charlieegan3/photos-vue yarn install

serve: install
	docker run -it -v $$(pwd):/app -p 8080:8080 charlieegan3/photos-vue yarn serve

build: install
	docker run -it -v $$(pwd):/app charlieegan3/photos-vue yarn build
