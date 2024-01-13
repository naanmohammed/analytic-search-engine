class AddSearchCountToSearches < ActiveRecord::Migration[7.1]
  def change
    add_column :searches, :search_count, :integer
  end
end
