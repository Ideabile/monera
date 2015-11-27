---
layout: default.html
---
## Monera

> Monera was kingdom that contained unicellular organisms.
From [Wikipedia](https://en.wikipedia.org/wiki/Monera).

But for us (Geeks), Monera is an opinionated kingdom, where Micro-Services meets Web Artisans.

It use Docker as architecture layer, with `docker-compose.yml`,

With Docker we can scale to productions environment, and one of the feature can be include `ambasadors` and some production-ready deploying commands, inspired by: [Orchestration Workshop](https://github.com/jpetazzo/orchestration-workshop) of [jpetazzo](https://github.com/jpetazzo/orchestration-workshop).

But even more important we isolate the

Then the 'dummy' structure around try to show a selection of organisms to compose our kingdom:

We have 2 containers:
  - Http server with nginx
  - Generator container

The Generator container is responsible to parse his resources, in our case style and content, and deliver them under the www directory on the root of the kingdom (project).

Our Generator organism is fine compose with:
  - A NodeJS container image
  - Gulp
  - Metalsmith (with some plugins like MarkDown)
  - Browser-sync (handly for dev mode)
  - Some basic style and layout for this documentation

While doing it we keep in mind:
- **Static Content Generator** is a trend tha is emerging.
Your content can be versioned, and your resources saved.
Nevertheless you can extend your kingdom with your fancy Micro-Service Api's.

  We choose NodeJS with all his fancy 'stream' libraries (Gulp, Metalsmith).

  Someone else choose to create his real with Jekyll and Sass gems; someone else with Django, some additional work could do with Wordpress or Joomla.

- **Diversity is Welcome**, this is not a dependency for your project, and not even a framework where you can depend on fancy api.

  This is a scheme in how to build your own working realm. For that reason you're indeed invited to add Feedbacks or PR's to our repository.

  Keep in mind that git submodule file is the recipe for your real, and in order tho keep the freedom to choose your don't want to use the same style, and content, and maybe not even the same generator.

- **Style**, there isn't much to say here. Sass seems to be the winner where PostCSS would take the place in the features. So for now we opted on Sass with an eye on the feature.

  We use a Bootstrap Style Framework. Maybe some else would choose to use Materials.

- **Ready to productions is the goal**, ready to use is the fact. Yep! Because a simple ``make publish`` would allow you to publish it with github.io pages.


#### How to start
```
git clone git@github.com:Ideabile/monera.git
cd monera
# Fork this repo for some basic content
# Fork the style for some basic content
# Edit .gitmodules with your fork url
git submodule init
# Make sure you open docker locally
make
# Visit the ip of the docker-machine at :3000 you have the live view.
```
