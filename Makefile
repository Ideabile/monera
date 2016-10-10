COMPILERS = base es6 browserify uglify metalsmith sass
FSWV = 1.7.0

BASEPATH ?=$(realpath .)/
SRC ?=$(BASEPATH)src/
DEST ?=$(BASEPATH)dist/

DEST_JS ?=$(DEST)js/
SRC_JS ?=$(SRC)js/

DEST_SASS ?=$(DEST)style/
SRC_SASS ?=$(SRC)style/

BEWATCH=./Makefile ./package.json $(COMPILERS) $(SRC)*

${COMPILERS}:
		echo "\n\n--- Building container:$(@)"; \
		docker build -t monera-${@} -f ./${@}/Dockerfile .

install-dev: .
		mkdir -p ./_dev && cd _dev && \
		curl -L -k https://github.com/emcrisostomo/fswatch/releases/download/${FSWV}/fswatch-${FSWV}.tar.gz | tar zx -C . && \
		cd fswatch-${FSWV} && ./configure && make && make install

dev:
		fswatch -Ie "\.#.*" $(BEWATCH) | \
		(while read file event; do \
		ext=$${file##*.}; \
		if [ $${ext} = "scss" ]; then \
		$(MAKE) compile-sass; \
		elif [ $${ext} = "js" ]; then \
		$(MAKE) compile-js; \
		elif [ $${ext} = "html" ]; then \
		$(MAKE) compile-content; \
		else $(MAKE) build && $(MAKE) compile; \
		fi \
		done)

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
		echo "\n\n--- Compiling JS"; \
		$(MAKE) clean-js && \
		cd $(SRC_JS) && \
		tar c -h * | \
		docker run -e "TYPE=tar" -i monera-es6 | \
		docker run -e "TYPE=tar" -i monera-browserify | \
		docker run -e "TYPE=tar" -i monera-uglify | \
	  tar x -v -C "$(DEST_JS)" && \
		echo "JS Compiled!"

compile-sass:
		echo "\n\n--- Compiling Sass"; \
		cd $(SRC_SASS) && \
		tar c -h * | \
		docker run -e "TYPE=tar" -i monera-sass | \
	  tar x -v -C "$(DEST_SASS)" && \
		echo "SASS Compiled!"

compile-content:
		echo "\n\n--- Compiling content"; \
		cd $(SRC) && \
		tar c -h content/* layouts/* partials/* | docker run -i -e "TYPE=tar" monera-metalsmith | \
	  tar x -v -C "$(DEST)" && \
		echo "Content Compiled!"

publish-travis:
		@git config user.name "Travis CI" && \
		git config user.email "info@ideabile.com" && \
		$(MAKE) publish

publish: build compile
		@git branch -D gh-pages 2>/dev/null || true && \
		git branch -D draft 2>/dev/null || true && \
		git checkout -b draft && \
		cp CNAME $(DEST) CNAME && \
		git add -f $(DEST) && \
		git commit -am "Deploy on gh-pages" && \
		git subtree split --prefix $(DEST) -b gh-pages && \
		git push --force "https://${GH_TOKEN}@${GH_REF}.git" gh-pages:gh-pages > /dev/null 2>&1

.SILENT: clean-content clean-js clean-sass dev compile compile-js compile-sass compile-content

.PHONY: ${COMPILERS}
