#!/usr/bin/make -f

COMPILERS = base es6 browserify uglify metalsmith sass
FSWV = 1.7.0

BASEPATH ?=$(realpath .)/
SRC ?=$(BASEPATH)src/
DEST ?=$(BASEPATH)dist/

CONTAINERSPATH ?=$(BASEPATH)containers/

DEST_JS ?=$(DEST)js/
SRC_JS ?=$(SRC)js/

DEST_SASS ?=$(DEST)style/
SRC_SASS ?=$(SRC)style/

CONTENT_PATH ?=content/
LAYOUT_PATH ?=layouts/
PARTIALS_PATH ?=partials/

PACKAGE_NAME=$(shell cat "$(BASEPATH)package.json" | grep name | head -1 | awk -F: '{ print $2 }' | sed 's/[",]//g' | tr ':' '\n' | tail -1 | tr -d '[[:space:]]')

# START --- Build Containers

${COMPILERS}: ## Build container
		echo "\n\n--- Building container:$(@)"; \
		docker build -t monera-${@} -f ${CONTAINERSPATH}${@}/Dockerfile .

build-compilers: ${COMPILERS} ## Build all the compilers

build: build-compilers modules

modules: ## Build the Package.json in a specific container
		docker build -t ${PACKAGE_NAME}-modules -f ${CONTAINERSPATH}modules/Dockerfile .

# END



# START --- Dev Resources

install-dev: .
		mkdir -p ./_dev && cd _dev && \
		curl -L -k https://github.com/emcrisostomo/fswatch/releases/download/${FSWV}/fswatch-${FSWV}.tar.gz | tar zx -C . && \
		cd fswatch-${FSWV} && ./configure && make && make install


BEWATCH:=./Makefile README.md ./package.json $(COMPILERS) $(SRC)*
dev:
		$(MAKE) browser-sync-start & \
		fswatch -Ie "\.#.*" $(BEWATCH) | \
		$(call WATCHER)

browser-sync-start:
		@if [ ! -z `which browser-sync` ]; \
		then browser-sync start -s $(DEST) -f $(DEST) 1> /dev/null;\
		else echo "We recommend to install browser-sync"; fi

define WATCHER
while read file event; do \
		ext=$${file##*.}; \
		if [ $${ext} = "scss" ]; then \
		$(MAKE) compile-sass; \
		elif [ $${ext} = "js" ]; then \
		$(MAKE) compile-js; \
		elif [ $${ext} = "html" || $${ext} = "md" ]; then \
		$(MAKE) compile-content; \
		else $(MAKE) build && $(MAKE) compile; \
		fi \
		done
endef

# END



# START --- Tests

test: test-js-buffer test-js-dir ## Test the compilers

test-js-dir: compile-js ## Test to compile dir

test-js-buffer: ## Test compiler just with buffers
		echo "class Test {}" | docker run -i monera-es6 | docker run -i monera-browserify

# END



# START --- Clean tasks

clean: clean-js clean-content clean-sass

clean-js:
		if [ -d $(DEST_JS) ]; then rm -rf $(DEST_JS)*; else mkdir -p $(DEST_JS); fi

clean-content:
		rm -rf $(DEST)/*.html

clean-sass:
		if [ -d $(DEST_SASS) ]; then rm -rf $(DEST_SASS)*; else mkdir -p $(DEST_SASS); fi

# END



# START --- Compiling utils
run := docker run -e "TYPE=tar" -i monera-${1}

start-shared-volumes:
		@$(eval MODULES:=$(shell docker run -d -t $(PACKAGE_NAME)-modules tail -f /dev/null))

define RUN
		docker run -e "TYPE=tar" -i monera-$1
endef

define RUNPKG
		docker run -e "TYPE=tar" -i --volumes-from $(MODULES) monera-$1
endef

define COMPILE_START
		echo "\n\n--- Compiling ${1}"; \
		$(MAKE) clean-$1 && \
		cd $2 && tar c -h $3
endef

define COMPILE_END
		tar x -v -C "$(DEST)"
		if[[ -n $(MODULES) ]]; then docker kill $(MODULES); fi
		echo "--- Compiled!\n"
endef

compile: clean compile-js compile-sass compile-content ## Compile the website

compile-js: start-shared-volumes
		@$(call COMPILE_START,js,$(SRC_JS),*) | \
		$(call RUN,es6) | $(call RUNPKG,browserify) | $(call RUN,uglify) | \
		$(call COMPILE_END,js)

compile-sass:
		@$(call COMPILE_START,sass,$(SRC_SASS),*) | \
		$(call RUN,sass) | \
		$(call COMPILE_END,sass)

compile-content:
		@$(call COMPILE_START,content,$(SRC),"$(CONTENT_PATH)* $(LAYOUT_PATH)* $(PARTIALS_PATH)*") | \
		$(call RUN,sass) | \
		$(call COMPILE_END,content)

# END



# START --- Publish

publish-travis:
		@git config user.name "Travis CI" && \
		git config user.email "info@ideabile.com" && \
		$(MAKE) publish

publish: build compile ## Publish
		@git branch -D gh-pages 2>/dev/null || true && \
		git branch -D draft 2>/dev/null || true && \
		git checkout -b draft && \
		cp ./CNAME dist/CNAME && \
		git add -f dist && \
		git commit -am "Deploy on gh-pages" && \
		git subtree split --prefix dist -b gh-pages && \
		git push --force "https://${GH_TOKEN}@${GH_REF}.git" gh-pages:gh-pages > /dev/null 2>&1

# END

#.SILENT: clean-content clean-js clean-sass dev compile compile-js compile-sass compile-content

# START -- Utils
bar := "\n--------------------------------------------------------\n"
title :="\n             M O N E R A   K I N G D O M"
subtitle :="      containerised web development ready to use"
more := " for more info visit: http://github.com/ideabile/monera"

help: ## This help
	@echo ${title}${bar}${subtitle}"\n"${more}${bar} && \
	grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' && \
	echo ${bar}

# END

.PHONY: ${COMPILERS}
.DEFAULT_GOAL := help
