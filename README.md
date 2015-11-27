# Monera
**Working in progress** for a Kingdom that contained unicellular organisms.

In short, you should have docker installed.
And then you could do:
```
git clone git@github.com:Ideabile/monera.git --recursive && \
cd monera &&
make
```

After that you should be able to visit your docker-machine address and see the docs.


---
Something that I want to add.
You could eventually change the submodules:
 - http://stackoverflow.com/questions/913701/changing-remote-repository-for-a-git-submodule
 - I'm actually solving something for this: https://github.com/slimphp/Slim/issues/681
   While I'm doing monera-auth package (with: https://github.com/willdurand/Hateoas).
 - In the same time this would include a refactor of prose/prose as editor
 - I think I would improve the generator using https://github.com/google/incremental-dom and Marionette.
 - Watchers should be installed in the current machine. For this purpose I would use https://github.com/sschober/kqwait
 - I want also implement fixture for propel https://github.com/propelorm/Propel2/issues/740 and I'm gonna solve it inside the monera-auth.
