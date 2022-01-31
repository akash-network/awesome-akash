# ns: Set to your login at https://hub.docker.com
ns := andrey01
branch := master
# commit: optional
commit := 3f38dd27
repo := https://github.com/Sifchain/sifchain-ui.git
date := $(shell date --rfc-3339=date)
# since Akash agressively caches the images...
unixtimestamp := $(shell date +%s)
tag := $(or $(commit),$(branch))-$(date)-$(unixtimestamp)
image := $(ns)/sifchain-ui
image_tag := $(image):$(tag)

image_last_tag := $(shell docker images --format "{{.Repository}}:{{.Tag}}" --filter "reference=$(image)" | head -1)

all: build push update-sdl clean

build:
	docker build --build-arg COMMIT=$(commit) --build-arg BRANCH=$(branch) --build-arg REPO=$(repo) --build-arg DATE=$(date) -t $(image_tag) .
	$(eval image_last_tag := $(image_tag))
push:
	docker push $(image_last_tag)
update-sdl:
	sed -i 's@\(image:\)\(.*\)@\1 '"$(image_last_tag)"'@' deploy.yaml
test:
	docker run --rm -ti -p8080:80 -p8443:443 $(image_last_tag)
debug:
	docker run --rm -ti -p8080:80 -p8443:443 --entrypoint sh $(image_last_tag)
clean:
	docker images --format "{{.Repository}}:{{.Tag}}" --filter "reference=$(image)" |  sort -nr -k2,2 | awk 'NR>2' | xargs -r docker rmi 2>/dev/null || true

.PHONY: build
