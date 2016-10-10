COMPILERS = base es6 browserify metalsmith sass

BASEPATH?=$(realpath .)/
SRC ?=$(BASEPATH)src/
DEST ?=$(BASEPATH)dist/

DEST_JS ?=$(DEST)js/
SRC_JS ?=$(SRC)js/

DEST_SASS ?=$(DEST)style/
SRC_SASS ?=$(SRC)style/

${COMPILERS}:
		docker build -t monera-${@} -f ./${@}/Dockerfile .

build-compilers: ${COMPILERS}

build: build-compilers

test: test-js-buffer test-js-dir

test-js-dir: compile-js

test-js-buffer:
		echo "class Mauro {}" | docker run -i monera-es6 | docker run -i monera-browserify

clean-js:
		if [ -d $(DEST_JS) ]; then rm -rf $(DEST_JS)*; else mkdir -p $(DEST_JS); fi

clean-content:
		rm -rf $(DEST)/*.html

clean-sass:
		if [ -d $(DEST_SASS) ]; then rm -rf $(DEST_SASS)*; else mkdir -p $(DEST_SASS); fi

compile: compile-js compile-sass compile-content

compile-js:
		$(MAKE) clean-js && \
		cd $(SRC_JS) && \
		tar c -h * | \
		docker run -e "TYPE=tar" -i monera-es6 | \
		docker run -e "TYPE=tar" -i monera-browserify | \
	  tar x -v -C "$(DEST_JS)" && \
		echo "JS Compiled!"

compile-sass:
		$(MAKE) clean-sass && \
		cd $(SRC_SASS) && \
		tar c -h * | \
		docker run -e "TYPE=tar" -i monera-sass | \
	  tar x -v -C "$(DEST_SASS)" && \
		echo "SASS Compiled!"

compile-content:
		cd $(SRC) && \
		tar c -h content/* layouts/* partials/* | docker run -i -e "TYPE=tar" monera-metalsmith | \
	  tar x -v -C "$(DEST)" && \
		echo "Content Compiled!"


.PHONY: ${COMPILERS}
