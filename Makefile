help:
	cat Makefile

requirements:
	python3 -m pip install --upgrade -r requirements.txt

clonesite:
	rm -fr site/
	git clone -b master git@ch4zm.github.com:ch4zm/ch4zm.github.io site

clean:
	rm -fr site/*

build: clean
	mkdocs build

gen:
	./scripts/gen_site.sh

all: gen build
