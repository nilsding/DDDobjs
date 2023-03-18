# lastfm-skyline

With heavy inspiration from [GitHub Skyline][skyline], this is a model that
gives you a nice overview of your last.fm scrobbles of a year.

## Usage

First-time setup:

```sh
# copy the example config and adapt it
cp config.rb.example config.rb
vi config.rb

# install the bundle
bundle install
```

Generating the data:

```sh
# generate a skyline for @nilsding in 2022 (if it's currently 2023)
USER_NAME=nilsding ./gen_skyline_data.rb

# generate a skyline for @nilsding in 2017
USER_NAME=nilsding YEAR=2017 ./gen_skyline_data.rb
```

## Credits

The last.fm logo SVG was made by _Font Awesome Free 6.3.0 by @fontawesome_
(CC-BY-4.0).

[skyline]: https://skyline.github.com
