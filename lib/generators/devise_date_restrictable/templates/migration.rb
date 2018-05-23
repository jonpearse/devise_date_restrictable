class DeviseAdd<%= @model_name.camelize.singularize %>DateRestrictionFields < ActiveRecord::Migration[<%= ActiveRecord::Migration.current_version %>]

 def change

  add_column :<%=@model_name.tableize %>, :valid_from, :date
  add_column :<%=@model_name.tableize %>, :valid_until, :date

 end

end
