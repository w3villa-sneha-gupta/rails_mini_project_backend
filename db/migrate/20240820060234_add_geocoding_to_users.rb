class AddGeocodingToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
    add_column :users, :formatted_address, :string
  end
end
