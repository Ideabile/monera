# Monera [![Build Status](https://travis-ci.org/Ideabile/monera.svg?branch=master)](https://travis-ci.org/Ideabile/monera)
## [Currently under development]
Kingdom that contained unicellular organisms.

Monera is a customisable containerised swissknife for modern web developers.
<div id="cmds">
</div>

Helps you in being more focus on code instead of project scaffolding and setups.
By helping you in create solid rule that can be used from local development or shipped into your CI Cloud System.

Because simply it works.

<script type="text/javascript" src="https://asciinema.org/a/bzuj6ef4b3qqbp0lf1ti0mflj.js" id="asciicast-bzuj6ef4b3qqbp0lf1ti0mflj" data-autoplay="true" async></script>

## What is provided?
![Hipster tools](http://i.giphy.com/vfKVWywzbRu3C.gif)

Some of the most hipster tools:
  - super **js** powers: **es6, bundling, minification** with *babeljs, browserify, uglify*
  - super **css** powers with *node-sass*
  - **static website** generator with *metalsmith and handlebars*
  - ... and more to come

## What doesn't provide?
Currently the approach is to be much purist has possible.
And feel a bit more clean and robust in the way we choose our libraries.

Even if we recognize a great value on libraries like webpack or gulp, although this doesn't want to replace them, but is evident how the need of them come less.

---
    
## How to setup

**Prerequisite**<br/>
Monera works with `docker` containers, `make` files and `tar` streams to do all his 'magic'.
But for local development use `fswatch` and `browsersync` (a nodejs dependecie).

**Mandatory**
- [`docker`](https://www.docker.com/products/overview) || ```curl -o https://get.docker.com/ | sh```;
- [`make`](https://www.gnu.org/software/make/) || `sudo apt-get install make` || `brew install make`;

**Development**
- [`nodejs`](https://nodejs.org/)
- [`npm install -g browsersync`](https://www.browsersync.io/) || `monera install-dev`
- [`fswatch`](emcrisostomo.github.io/fswatch/) -> `monera install-dev`

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
./.monera/monera compile && open dist/index.html
```

---

### Compile just javascript
```
./.monera/monera compile-js
```

### Compile just sass
```
./.monera/monera compile-sass
```

### Compile static website
```
./.monera/monera compile-content
```

... and since I get [inspired](https://blog.jessfraz.com/post/docker-containers-on-the-desktop/)...
You can also run **Atom** on it!
```
./.monera/monera atom
```
(although you need `xQuartz` and `socat` to make it work)

---

## How does it work?
![Containerised life](http://i.giphy.com/6AFldi5xJQYIo.gif)

The idea is that each container gets only one job to get done similar to a service / domain model.
The way we split responsibilities is nothing new for people that already work with microservices.

Monera tries to learn from microservices and tries to define a model (or contract) for interoperability. Focusing in how Preprocessors should work in a containerised environment.

In short a container should be able to handle a tar stream has an input and should return another tar stream.

```
+---------------------+ +------------------------------------+ +--------------------+
|                     | |                                    | |                    |
|                     | |         C O N T A I N E R          | |                    |
|    S R C  T A R     | |                                    | |   D E S T  T A R   |
|                     | |                                    | |                    |
|     S T R E A M     | |         +---------------+          | |     S T R E A M    |
|                     | |         |               |          | |                    |
|                     | |         |               |          | |                    |
+----------+----------+ |         |    T O O L    |          | +---------^----------+
           |            |      +-->               +--+       |           |
           |            |      |  |               |  |       |           |
           |            |      |  |               |  |       |           |
           |            |      |  +---------------+  |       |           |
           |            |      |                     |       |           |
           |            |  +---+----------+  +-------v-----+ |           |
           |            |  |              |  |             | |           |
           |            |  |              |  |             | |           |
           |            |  |              |  |             | |           |
           +--------------->     S R C    |  |   D I S T   +-------------+
                        |  |              |  |             | |
                        |  |              |  |             | |
                        |  +--------------+  +-------------+ |
                        |                                    |
                        +------------------------------------+
```

With a model like this we're able to chain the containers and pass our code from one to another by being dependencies free in our host machine.

## Why?
![Why?](http://i.giphy.com/bw5OY9zTKlOHS.gif)
The web is constantly saturated with new tools that pops up to keep your development much fancier than it was before. Shaming on all you've done until now.

... said by the new *'cool tool'*...

It's frustrating keep always up to date to the latest hype and technology and scaffolding your new project. Ending up spending 30% of your development time in looking for appropriated tools.

We stand to solidity has base for our container; containers reinforce the concepts of static.
And static is a good thing, computationally speaking.

Although our performance and MB numbers aren't that exciting; we compromise them by gaining portability and flexibility.

In fact we think that compilers don't deserve to be part of our package.json. But rather a binary installed in your system or in our case a container.

Giving us the opportunity to real cherry pick the values of our tools and dependencies.

## Why should I use and trust it?
For now this is just a fun experiment, but we believe that is ready for production now.
Monera is based upon tools that have already hundreds (if not thousand) of production stories, that you might be already using.

Monera is not a software itself but rather an approach or a way of doing things.
You should give it a try because can really boost your productivity by providing tools of tomorrow in solid and portable way, today.

Companies and [developers](https://muffinresearch.co.uk/tips-for-building-a-dev-env-with-docker/) are already working in similars manners.

Monera is just a way of sharing those experiences by improving together our daily life tools.

## How I can create / submit my 'organisms'?
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

## Some sugar left? 
*Shh...!* ***You can build a static website with Travis and Github Pages***

  1. Fork it!
  2. Change the README.md
  3. Create a [GitHub Authentication token](https://help.github.com/articles/creating-an-access-token-for-command-line-use/)
  4. Add your repository to travis.
  5. Add your `GH_TOKEN` to travis `travis encrypt GH_TOKEN=secretvalue`
  6. Commit and push.
  7. Enjoy your website at `http://<username>.github.io/<repo-name>/`

Every change on master would recreate your gh-pages branch. Enjoy :-)

---

## Organisms
Organism (or container) are 
  - [monera-es6](https://github.com/Ideabile/monera/blob/master/containers/es6/Dockerfile)
  - [monera-browserify](https://github.com/Ideabile/monera/blob/master/containers/browserify/Dockerfile)
  - [monera-uglify](https://github.com/Ideabile/monera/blob/master/containers/uglify/Dockerfile)
  - [monera-sass](https://github.com/Ideabile/monera/blob/master/containers/sass/Dockerfile)
  - [monera-metalsmith](https://github.com/Ideabile/monera/blob/master/containers/metalsmith/Dockerfile)

---

## Credits
 - [![Mauro](https://avatars.githubusercontent.com/M3kH?size=100)](http://www.ideabile.com)
