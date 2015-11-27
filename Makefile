clean: www/index.html
	@rm -rf www/*

server: www/index.html
	@docker-compose up -d www

server-stop: www/index.html
	@docker-compose kill www

update-modules: .gitmodules
	@cd static-transformer && \
	git fetch --all && \
	git reset --hard origin/master && \
	git commit -am 'Update submodules' && \
	git push origin $(git rev-parse --abbrev-ref HEAD)

build: docker-compose.yml
	@mkdir -p ./www && \
	docker-compose build static-transformer && \
	docker-compose run static-transformer build

publish-gh-pages: docker-compose.yml
	@git config user.name "Travis CI" && \
	git config user.email "info@ideabile.com" && \
	git branch -D gh-pages 2>/dev/null || true && \
	git branch -D draft 2>/dev/null || true && \
	git checkout -b draft && \
	git add -f www && \
	git commit -am "Deploy on gh-pages" && \
	git subtree split --prefix www -b gh-pages && \
	git checkout origin/master -- ./CNAME && \
	git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" master:gh-pages > /dev/null 2>&1

stop: docker-compose.yml
	@docker-compose kill && \
	docker-compose rm -f

.PHONY: dev
