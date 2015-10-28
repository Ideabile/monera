dev: docker-compose.yml
	mkdir -p ./www && \
	export TASK="dev" && \
	docker-compose up

publish: docker-compose.yml
	mkdir -p ./www && \
	git checkout master && \
	export TASK="build" && \
	docker-compose up && \
	git branch -D gh-pages 2>/dev/null || true && \
	git subtree split --prefix www -b gh-pages && \
	git push -f origin gh-pages:gh-pages

stop: www
	docker-compose kill && \
	docker-compose rm -f

.PHONY: dev
