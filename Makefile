dev: docker-compose.yml
	mkdir -p ./www && \
	export TASK="dev" && \
	docker-compose up

publish: docker-compose.yml
	mkdir -p ./www && \
	export TASK="build" && \
	docker-compose up -d && \
	git branch -d gh-pages && \
	git checkout -b --no-track --orphan gh-pages && \
	rm -rf ./!(www) && \
	mv -R ./www/* ./ && \
	rm -rf ./www && \
	git rm -rf . && \
	git rm .gitignore && \
	gut add . && \
	git commit -a -m "First pages commit" &&
	git push origin -f origin gh-pages

stop: www
	docker-compose kill && \
	docker-compose rm -f

.PHONY: dev
