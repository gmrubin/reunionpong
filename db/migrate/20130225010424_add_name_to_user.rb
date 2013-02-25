class AddNameToUser < ActiveRecord::Migration
  change_table :users do |t|
    t.string :name
    t.string :handle
  end
end
