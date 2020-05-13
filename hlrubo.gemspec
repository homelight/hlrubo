require_relative 'lib/hlrubo/version'

Gem::Specification.new do |spec|
  spec.name          = "hlrubo"
  spec.version       = Hlrubo::VERSION
  spec.authors       = ["HomeLight Engineering"]
  spec.email         = ["engineering@homelight.com"]

  spec.summary       = "Homelight Shared Ruby Style Guides"
  spec.homepage      = "https://github.com/homelight/hlrubo"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/homelight/hlrubo/blob/master/CHANGLOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rubocop", "0.80.0"
  spec.add_dependency "rubocop-performance", "1.5.2"
  spec.add_dependency "rubocop-rails", "2.5.2"
  spec.add_dependency "rubocop-rspec", "1.39.0"
end
