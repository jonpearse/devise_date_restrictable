require 'rails/generators/migration'

class DeviseDateRestrictableGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  def self.source_root
    @_devise_source_root ||= File.expand_path("../templates", __FILE__)
  end

  def self.next_migration_number(dirname)
    if ActiveRecord::Base.timestamped_migrations
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end

  class_option :model, type: :string, default: 'User'

  desc "Generates a migration to add required fields to devise account model."
  def invoke_migration

    model_name = options['model']
    @model_name = model_name.camelize.singularize

    if columns_exist?
      say "* Date restrictable columns already seem to exist on @{model_name}"
    else
      migration_template 'migration.rb', "db/migrate/devise_add_#{model_name.downcase}_date_restriction_fields.rb"
    end

    puts "Make sure to add :date_restrictable to the devise line of your #{@model_name} model file."
  end

  protected

  def columns_exist?
    @model_name.constantize.column_names.include?("valid_from") and @model_name.constantize.column_names.include?("valid_until")
  end
end
