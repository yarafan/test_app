class AddModerToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :moder, :boolean, default:  false
  end
end
