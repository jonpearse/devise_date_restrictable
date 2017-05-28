# -*- encoding: utf-8 -*-
require File.expand_path('../lib/devise_date_restrictable/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = "Jon Pearse"
  gem.email         = "jon@jonpearse.net"
  gem.description   = "This allows a Devise user’s validity to be restricted by a date range. This allows administrators to set up accounts that are valid to-, or from-, or between specific dates."
  gem.summary       = "Devise plugin to restrict access based on a date range."
  gem.homepage      = "https://github.com/jonpearse/devise_date_restrictable"

  gem.files         = `git ls-files`.split($\)
  gem.name          = "devise_date_restrictable"
  gem.require_paths = ["lib"]
  gem.version       = DeviseDateRestrictable::VERSION

  gem.add_dependency('devise', [">= 4.0.0"])
  gem.add_dependency('rails', [">= 5.0.0"])
end
