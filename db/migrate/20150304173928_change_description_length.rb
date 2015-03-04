class ChangeDescriptionLength < ActiveRecord::Migration
  def change
  	change_column :users, :description, :string, :limit => 2000
  end
end
