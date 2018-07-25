MRuby::Gem::Specification.new('mruby-stdio') do |spec|
  spec.license = 'MIT'
  spec.author = 'Hiroshi Mimaki'
  spec.description = 'STDOUT and STDIN for embedded system'

  spec.add_dependency('mruby-string-ext')
end
