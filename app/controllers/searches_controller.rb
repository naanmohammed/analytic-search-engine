require 'text'

class SearchesController < ApplicationController
  @@logger = Logger.new(STDOUT)

  def index
    @searches = Search.all
    render json: { message: "ok" }
  end

  def create
    @ip = IpAddress.find_or_create_by(address: request.remote_ip)
    @search = @ip.searches.build(search_params)
    @search.ip_address.increment!(:search_count)

    if @search.save
      @ip.increment!(:search_count)
      render json: { message: "ok" }
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @ip = IpAddress.find_by(address: params[:ip_address])
    @searches = @ip.searches
    @searches_grouped = group_searches(@searches)
    render_searches_grouped
  end

  def ip
    @ip_addresses = IpAddress.all
    render json: { 
      ip_addresses: @ip_addresses.pluck(:address),
      ip_addresses_id: @ip_addresses.pluck(:id)       
    }
  end

  private

  def search_params
    params.require(:search).permit(:query)
  end

  def normalize_query(query)
    query.gsub(/\s+/, '').downcase
  end

  def calculate_similarity(query1, query2)
    normalized1 = normalize_query(query1)
    normalized2 = normalize_query(query2)

    distance = Text::Levenshtein.distance(normalized1, normalized2)
    max_length = [normalized1.length, normalized2.length].max
    similarity = 1 - (distance.to_f / max_length)

    similarity
  end

  def find_most_complete_query(group)
    most_complete = group.max_by { |s| normalize_query(s.query).length }
    most_complete&.query
  end
  

  def group_searches(searches)
    groups = []
  
    valid_searches = searches.select { |search| search.query.length >= 2 }
  
    valid_searches.sort_by(&:created_at).reverse_each do |search|
      group = groups.find { |g| g.any? { |s| calculate_similarity(s.query, search.query) >= 0.5 } }
  
      unless group&.any? { |s| s.query.length < search.query.length }
        if group
          group << search
        else
          groups << [search]
        end
      end
    end
  
    groups.each do |group|
      first_four_chars = group.first.query[0, 4]
      group_within_60_seconds = group.all? { |search| (search.created_at - group.first.created_at).abs < 60.seconds.to_i }
  
      if group_within_60_seconds
        most_complete_query = find_most_complete_query(group)
        group.reject! { |search| search.query[0, 4] == first_four_chars && search.query.length < most_complete_query.length }
      end
    end
  
    groups
  end
  

  

  def render_searches_grouped
    @searches_grouped = @searches_grouped.map do |group|
      most_complete_query = find_most_complete_query(group)
      search_count = calculate_search_count(group)
      { query: most_complete_query, search_count: search_count } if most_complete_query
    end.compact

    render json: {
      ip_id: @ip.id,
      ip: @ip.address,
      searches: @searches_grouped
    }
  end

  def calculate_search_count(group)
    sorted_group = group.sort_by(&:created_at)
    intervals = []
  
    current_interval = [sorted_group[0]]
    sorted_group[1..].each do |search|
      if (search.created_at - current_interval.last.created_at).abs < 60.seconds.to_i
        current_interval << search
      else
        intervals << current_interval
        current_interval = [search]
      end
    end
    intervals << current_interval
  
    intervals.length
  end  
end
