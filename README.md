# Monera [![Build Status](https://travis-ci.org/Ideabile/monera.svg?branch=master)](https://travis-ci.org/Ideabile/monera)
Kingdom that contained unicellular organisms.

Monera is a customisable containerised swissknife for modern web developers tecnology.

Helps you in being more focus on code instead of project scaffolding and setups.
By helping you in create solid rule that can be used from local development or shipped into your CI or Cloud system.

Because simply it works.

## What is provided?
Some of the most hipster tools:
  - super **js** powers: **es6, bundling, minification** with *babeljs, browserify, uglify*
  - super **css** powers with *node-sass*
  - **static website** generator with *metalsmith and handlebars*
  - ... and more to come

## What doesn't provide?
Currently the approach is to be much purist has possible.
And feel a bit more clean and robust in the way we choose our libraries.

Even if we reconise a great value on libraries like webpack or gulp, althought this doesn't want to replace them, but is evidet how the need of them come less.

---
    
## How to setup
If you're starting from zero:
```
mkdir <my-project> && cd <my-project> && git init
```

add it has git submodule:
```
git submodule add https://github.com/Ideabile/monera.git .monera
```
---

## What can I do with it?

### Make a blog
copy the source code as an example:
```
cp -R .monera/src ./src && rm ./src/content/index.md && echo "# Hello world!" >> ./src/content/index.md
```

compile it and profit!
```
make -C monera compile "SRC=$(realpath .)/src/" "DEST=$(realpath .)/dist/" && open dist/index.html
```

---

### Compile just javascript
```
make -C monera compile "SRC_JS=$(realpath .)/src/" "DEST_JS=$(realpath .)/dist/"
```

### Compile just sass
```
make -C monera compile "SRC_SASS=$(realpath .)/src/" "DEST_SASS=$(realpath .)/dist/"
```

### Compile static website
```
make -C monera compile "SRC=$(realpath .)/src/" "CONTENT_PATH=content/" "LAYOUT_PATH=layouts/" "PARTIALS_PATH=partials/" "DEST=$(realpath .)/dist/"
```

---

## Contributing
We suggest to take a look to the Organism list bellow that monera is officially compose by.
Or you can suggest/submit new Organism.

Apply your contributions is easy like:

  1. Fork it!
  2. Create your feature branch: `git checkout -b my-new-feature`
  3. Commit your changes: `git commit -am 'Add some feature'`
  4. Push to the branch: `git push origin my-new-feature`
  5. Submit a pull request :D

---

## Development
We require you to have `npm` and `node` installed to make able to install [`browser-sync`](http://www.browsersync.io/),
additionally we download and compile [`fsWatch`](http://github.com/emcrisostomo/fswatch) to run `make build` every-time that a file change.
```
git clone git@github.com:Ideabile/monera.git && cd monera
```
```
make install-dev && make dev
```
Now you can do your changes in the content, and when you save them they would be compile, and your browser refresh automatically.

---

## Create your first website with Travis and Github Pages
This documentation is a live example in how you could change your

  1. Fork it!
  2. Create a [GitHub Authentication token](https://help.github.com/articles/creating-an-access-token-for-command-line-use/)
  3. Add your repository to travis.
  4. Add your `GH_TOKEN` to travis `travis encrypt GH_TOKEN=secretvalue`
  5. Commit and push.
  6. Enjoy your website at `http://<username>.github.io/<repo-name>/`

Every change on master would recreate your gh-pages branch. Enjoy :-)

---

## Organisms
Organism (or container) are 
  - [monera-es6](https://github.com/Ideabile/monera/blob/v2/containers/es6/Dockerfile)
  - [monera-browserify](https://github.com/Ideabile/monera/blob/v2/containers/browserify/Dockerfile)
  - [monera-uglify](https://github.com/Ideabile/monera/blob/v2/containers/uglify/Dockerfile)
  - [monera-sass](https://github.com/Ideabile/monera/blob/v2/containers/sass/Dockerfile)
  - [monera-metalsmith](https://github.com/Ideabile/monera/blob/v2/containers/metalsmith/Dockerfile)

---

## Credits
 - [![Mauro](https://avatars.githubusercontent.com/M3kH?size=100)](http://www.ideabile.com)
