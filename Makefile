COMPILERS = es6 browserify metalsmith

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
		if [ -d $(DEST_JS) ]; then rm -rf $(DEST_JS)*; else mkdir -p $(DEST_JS); fi

compile-js:
		$(MAKE) clean-js && \
		cd $(SRC_JS) && \
		tar c -h * | \
		docker run -e "TYPE=tar" -i monera-es6 | \
		docker run -e "TYPE=tar" -i monera-browserify | \
	  tar x -v -C "$(DEST_JS)" && \
		echo "JS Compiled!"

compile-content:
		cd $(SRC) && \
		tar c -h content/* layouts/* partials/* | docker run -i -e "TYPE=tar" monera-metalsmith | \
	  tar x -v -C "$(DEST)" && \
		echo "JS Compiled!"


.PHONY: ${COMPILERS}
