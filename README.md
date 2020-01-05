# gosu.cr
Shard for using Gosu with Crystal

_Under development:_ implementation is incomplete.

## Status
Implemented
* [x] Gosu
* [x] Window
* [x] TextInput
* [ ] Song (in-progress)
* [ ] Color (in-progress)
* [ ] Image (in-progress)
* [ ] Sample
* [ ] Font
* [ ] GLTexInfo
* [ ] Channel
* [ ] Numeric helper functions e.g. `90.degrees_to_radians`

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     gosu:
       github: gosu/gosu.cr
   ```

2. Run `shards install`

## Usage

```crystal
require "gosu"

class Window < Gosu::Window
  def initialize
    super(512, 512)
  end
end

Window.new.show
```

Where possible gosu.cr imitates the [Ruby gem](https://rubydoc.info/github/gosu/gosu).

## Development

1. Install [gosu](https://github.com/gosu/gosu) as a system library, [see wiki](https://github.com/gosu/gosu/wiki/Getting-Started-on-Linux#compiling-gosu-for-c).
(Note: may need to edit `gosu/cmake/build/cmake_install.cmake` to change `set(CMAKE_INSTALL_PREFIX "/usr/local")` to `set(CMAKE_INSTALL_PREFIX "/usr")`)

## Contributing

1. Fork it (<https://github.com/gosu/gosu.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Cyberarm](https://github.com/cyberarm) - creator and maintainer
