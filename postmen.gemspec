$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'postmen/version'

Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.name = 'postmen'
  s.version = Postmen::VERSION
  s.licenses = ['MIT']
  s.summary = 'Postmen'
  s.description = 'Developed for easy integration with Postmen'
  s.required_ruby_version = '>= 2.1.0'

  s.author = ['postmen.com']
  s.email = ['support@postmen.com']
  s.homepage = 'https://www.postmen.com'

  s.files         = Dir['{bin,lib}/**/*', 'README.md']
  s.require_paths = ['lib']

  s.add_dependency 'http', '= 2.0'
  s.add_dependency 'dry-configurable', '~> 0.5'
  s.add_dependency 'dry-struct', '~> 0.1'

  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'rubocop', '~> 0.4'
  s.add_development_dependency 'webmock', '~> 2.3'
  s.add_development_dependency 'rake', '~> 10.0'
end
