class Search < ApplicationRecord
  belongs_to :ip_address, counter_cache: :search_count
end