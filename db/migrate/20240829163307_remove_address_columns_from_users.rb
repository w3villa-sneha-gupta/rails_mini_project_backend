class RemoveAddressColumnsFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :latitude, :float
    remove_column :users, :longitude, :float
    remove_column :users, :formatted_address, :string
  end
end
