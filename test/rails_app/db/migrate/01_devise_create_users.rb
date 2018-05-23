# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|

      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Restrictable
      t.date   :valid_from
      t.date   :valid_until

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
  end
end
