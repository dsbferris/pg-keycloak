
VERSION=$(shell cat VERSION)

buildx:
	docker buildx create --name bob --use

build:
	docker buildx build \
		--load \
		-f Dockerfile \
		--build-arg VERSION=$(VERSION) \
		-t ghcr.io/dsbferris/pg-keycloak:latest \
		-t ghcr.io/dsbferris/pg-keycloak:$(VERSION) \
		. 

push:
	docker buildx build \
		--platform linux/amd64,linux/arm64 \
		--push \
		-f Dockerfile \
		--build-arg VERSION=$(VERSION) \
		-t ghcr.io/dsbferris/pg-keycloak:latest \
		-t ghcr.io/dsbferris/pg-keycloak:$(VERSION) \
		. 
	git tag $(VERSION)
	git push origin $(VERSION)

delete-push:
	git tag -d $(VERSION)
	git push -d origin $(VERSION)
	echo "Delete the package at github"
