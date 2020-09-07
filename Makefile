help:
	cat Makefile

requirements:
	python3 -m pip install --upgrade -r requirements.txt

clonesite:
	rm -fr site/
	git clone -b master git@ch4zm.github.com:ch4zm/ch4zm.github.io site

setup_cinder:
	wget https://github.com/chrissimpkins/cinder/archive/v1.0.4.zip
	unzip v1.0.4.zip
	mv cinder-1.0.4/cinder cinder
	rm -fr cinder-1.0.4
	rm -f v1.0.4.zip

site:
	rm -fr output/*
	mkdocs build
