# docs-preview
A tool for previewing Crystal docs with the same url structure as the live site. (eg. `/api/0.26.1/index.html`)

Usage:
```
$ cd path/to/this/repo
$ shards build
$ cd path/to/crystal-lang/repo
$ make crystal && make docs
$ cd docs
$ path/to/this/repo/bin/docs-preview

# site viewable at http://localhost:8888
```

## Contributing

1. Fork it ( https://github.com/willamin/docs-preview/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [willamin](https://github.com/willamin) Will Lewis - creator, maintainer
