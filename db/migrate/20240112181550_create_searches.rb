class CreateSearches < ActiveRecord::Migration[7.0]
  def change
    create_table :searches do |t|
      t.text :query
      t.references :ip_address, null: false, foreign_key: true

      t.timestamps
    end
  end
end