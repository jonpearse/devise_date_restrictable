class DeviseAdd<%= @model_name.camelize.singularize %>DateRestrictionFields < ActiveRecord::Migration
 def change
  add_column :<%=@model_name.tableize%>, :valid_from, :date
  add_column :<%=@model_name.tableize%>, :valid_until, :date
 end
end
