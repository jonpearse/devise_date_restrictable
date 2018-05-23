Devise.setup do |config|
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  require 'devise/orm/active_record'
  config.secret_key = '24213d5a635a381c4d4758564214314d5e514e34405507614c'
  config.case_insensitive_keys = [:email]

  config.strip_whitespace_keys = [:email]
end
