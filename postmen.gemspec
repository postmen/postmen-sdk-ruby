# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.name = 'postmen'
  s.version = '0.0.0'
  s.licenses = ['MIT']
  s.summary = 'Postmen'
  s.description = 'Developed for easy integration with Postmen'
  s.required_ruby_version = '>= 1.8.7'

  s.author = ['postmen.com']
  s.email = ['support@postmen.com']
  s.homepage = 'https://www.postmen.com'

  s.files         = Dir['{bin,lib}/**/*', 'README.md']
  s.require_paths = ['lib']
  s.requirements << 'none'

  s.add_dependency 'httpclient', '~> 2.5.2'

  s.add_development_dependency 'rspec', '~> 2.14.1'
  s.add_development_dependency 'pry'
end
