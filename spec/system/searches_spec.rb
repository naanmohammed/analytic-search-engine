require 'rails_helper'
require 'capybara/rspec'
require 'selenium-webdriver'

RSpec.describe 'Searches', type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  describe 'search functionality' do
    it 'creates and shows grouped searches' do
      ip_address = IpAddress.create(address: '127.0.0.1')
      Search.create(ip_address: ip_address, query: 'Hello')
      Search.create(ip_address: ip_address, query: 'Hello World')

      visit "http://127.0.0.1:3000/searches/#{ip_address.address}"
      json_response = page.body.match(/<pre.*?>(\{.*?\})<\/pre>/m)[1]
      
      expect(json_response).to eq("{\"ip_id\":1,\"ip\":\"127.0.0.1\",\"searches\":[{\"query\":\"hello world how are you\",\"search_count\":1}]}")

    end

    it 'handles search grouping within 60 seconds' do
      ip_address = IpAddress.create(address: '127.0.0.1')
      Search.create(ip_address: ip_address, query: 'hello world how are you', created_at: 80.seconds.ago)
      Search.create(ip_address: ip_address, query: 'hello', created_at: 30.seconds.ago)

      visit "http://127.0.0.1:3000/searches/#{ip_address.address}"

      json_response = page.body.match(/<pre.*?>(\{.*?\})<\/pre>/m)[1]

      expect(json_response).to eq("{\"ip_id\":1,\"ip\":\"127.0.0.1\",\"searches\":[{\"query\":\"hello world how are you\",\"search_count\":1}]}")
    end

    it 'does not show incomplete queries' do
      ip_address = IpAddress.create(address: '127.0.0.1')
      Search.create(ip_address: ip_address, query: 'hello')
      Search.create(ip_address: ip_address, query: 'hellow world how are you')

      visit "http://127.0.0.1:3000/searches/#{ip_address.address}"

      json_response = page.body.match(/<pre.*?>(\{.*?\})<\/pre>/m)[1]

      expect(json_response).to eq("{\"ip_id\":1,\"ip\":\"127.0.0.1\",\"searches\":[{\"query\":\"hello world how are you\",\"search_count\":1}]}")
    end
  end
end
