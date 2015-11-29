FSWV = 1.7.0
INDEX_README = true
clean: www
	@rm -rf www/* 2>/dev/null && \
	docker stop `docker ps -lq` || true && \
	docker rm `docker ps -lq` || true && \
	docker rmi `docker images -qa` || true

install-dev: .
	mkdir -p ./dev && cd dev && \
	curl -L -k https://github.com/emcrisostomo/fswatch/releases/download/${FSWV}/fswatch-${FSWV}.tar.gz | tar zx -C fswatch && \
	cd fswatch && ./configure && make && make install && cd ../../ && \
	npm install -g browser-sync || sudo npm install -g browser-sync || true

dev-start: dev-fswatch

dev-fswatch: dev-browsersync
	fswatch -Ie ".*\.css$$" ./content | (while read; do make build; done)

dev-browsersync: dev-server
	browser-sync start --proxy="192.168.99.100" --files="www/**" &

dev-server: www/index.html
	@docker-compose up -d www

dev-server-stop: www/index.html
	@docker-compose kill www

update-modules: .gitmodules
	@cd static-transformer && \
	git fetch --all && \
	git reset --hard origin/master && \
	git commit -am 'Update submodules' && \
	git push origin $(git rev-parse --abbrev-ref HEAD)

build: docker-compose.yml
	@mkdir -p ./www && mkdir -p ./content/posts && \
	if [ ${INDEX_README} ]; then \
		(rm -rf ./content/posts/index.md && cp README.md ./content/posts/index.md); \
	fi; \
	docker-compose build --no-cache static-transformer && \
	docker-compose run static-transformer build

publish-gh-pages: docker-compose.yml
	@git config user.name "Travis CI" && \
	git config user.email "info@ideabile.com" && \
	git branch -D gh-pages 2>/dev/null || true && \
	git branch -D draft 2>/dev/null || true && \
	git checkout -b draft && \
	cp CNAME www/CNAME && \
	git add -f www && \
	git commit -am "Deploy on gh-pages" && \
	git subtree split --prefix www -b gh-pages && \
	git push --force "https://${GH_TOKEN}@${GH_REF}.git" gh-pages:gh-pages > /dev/null 2>&1

stop: docker-compose.yml
	@docker-compose kill && \
	docker-compose rm -f

.PHONY: dev
