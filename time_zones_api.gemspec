# frozen_string_literal: true

require_relative "lib/time_zones_api/version"

Gem::Specification.new do |spec|
  spec.name = "time_zones_api"
  spec.version = TimeZonesApi::VERSION
  spec.authors = ["Niko Roberts", "Vasco Orey"]
  spec.email = ["niko@tasboa.com", "vasco.orey@airtasker.com"]

  spec.summary = "SDK for the timezonesapi.com API"
  spec.description = "SDK for the timezonesapi.com API"
  spec.homepage = "https://www.timezonesapi.com"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/NikoRoberts/timezonesapi-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/NikoRoberts/timezonesapi-ruby/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
