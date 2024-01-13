class CreateIpAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :ip_addresses do |t|
      t.string :address
      t.integer :search_count, default: 0

      t.timestamps
    end
  end
end