require "devise_date_restrictable/version"
require "devise_date_restrictable/rails"

unless defined?( Devise )

  require 'devise'

end

Devise.add_module( :date_restrictable, model: 'devise_date_restrictable/active_record' )

module DeviseDateRestrictable; end
