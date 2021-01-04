# frozen_string_literal: true

require_relative "lib/bridgetown-avatar/version"

Gem::Specification.new do |spec|
  spec.name          = "bridgetown-avatar"
  spec.version       = BridgetownAvatar::VERSION
  spec.author        = "Julian Rubisch"
  spec.email         = "julian.rubisch@hey.com"
  spec.summary       = "Liquid tag to insert a Github avatar"
  spec.homepage      = "https://github.com/username/bridgetown-avatar"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r!^(test|script|spec|features|frontend)/!) }
  spec.test_files    = spec.files.grep(%r!^spec/!)
  spec.require_paths = ["lib"]
  spec.metadata      = { "yarn-add" => "bridgetown-avatar@#{BridgetownAvatar::VERSION}" }

  spec.required_ruby_version = ">= 2.5.0"

  spec.add_dependency "bridgetown", ">= 0.15", "< 2.0"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "nokogiri", "~> 1.6"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop-bridgetown", "~> 0.2"
end
