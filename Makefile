COMPILERS = es6 browserify

BASEPATH?=$(realpath .)/
SRC ?=$(BASEPATH)src/
DEST ?=$(BASEPATH)dist/

DEST_JS ?=$(DEST)js/
SRC_JS ?=$(SRC)js/

${COMPILERS}:
		docker build -t monera-${@} -f ./${@}/Dockerfile .

build-compilers: ${COMPILERS}

build-base:
		docker build -t monera-base -f ./Dockerfile .

build: build-base build-compilers

test: test-js-buffer test-js-dir

test-js-dir: compile-js

test-js-buffer:
		echo "class Mauro {}" | docker run -i monera-es6 | docker run -i monera-browserify

clean-js:
		rm -rf $(DEST_JS)*

compile-js:
		if [ -d $(DEST_JS) ]; then $(MAKE) clean-js; else mkdir -p $(DEST_JS); fi && \
		cd $(SRC_JS) && \
		tar c * | \
		docker run -e "TYPE=tar" -i monera-es6 | \
		docker run -e "TYPE=tar" -i monera-browserify | \
	  tar x -v -C "$(DEST_JS)" && \
		echo "JS Compiled!"

.PHONY: ${COMPILERS}
