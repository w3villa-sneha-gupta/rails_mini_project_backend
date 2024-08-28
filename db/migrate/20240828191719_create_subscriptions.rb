class CreateSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :plan
      t.datetime :starts_at
      t.datetime :ends_at
      t.boolean :active

      t.timestamps
    end
  end
end
