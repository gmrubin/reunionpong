class AddAcceptToUser < ActiveRecord::Migration
  def change
    add_column :users, :accept, :boolean, default: false
  end
end
