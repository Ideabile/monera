COMPILERS = es6 browserify
SRC?="example_src/"
DEST?="dist/"
TARRULE=${SRC}*


${COMPILERS}:
		docker build -t monera-${@} -f ./${@}/Dockerfile .

build-compilers: ${COMPILERS}

build-base:
		docker build -t monera-base -f ./Dockerfile .

build: build-base build-compilers

test: build-project

test-buffer:
		echo "class Mauro {}" | docker run -i monera-es6 | docker run -i monera-browserify

build-project:
		if [ $(DEST -d)  ]; then rm -rf $(DEST)/*; else mkdir $(DEST); fi && \
		tar c $(TARRULE) | docker run -e "TYPE=tar" -i monera-es6 | docker run -e "TYPE=tar" -i monera-browserify | \
    tar x -v -C $(DEST) && \
		echo "Compiled!"

.PHONY: ${COMPILERS}
