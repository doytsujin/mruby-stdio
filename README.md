# mruby-stdio   [![Build Status](https://travis-ci.org/mimaki/mruby-stdio.svg?branch=master)](https://travis-ci.org/mimaki/mruby-stdio)
STDOUT and STDIN for embedded system

It is necessary to prepare STDOUT._putc and STDIN._getc for target device.

## install by mrbgems
- add conf.gem line to `build_config.rb`

```ruby
MRuby::Build.new do |conf|

  # ... (snip) ...

  conf.gem :git => 'https://github.com/mimaki/mruby-stdio'
  conf.gem :git => 'https://github.com/mimaki/mruby-stdio-grpeach'  # _putc/_getc for target device
end
```

## example
```ruby
$stdout.print '=> '
$stdout.puts $stdin.gets.chomp
```

## License
under the MIT License:
- see LICENSE file
