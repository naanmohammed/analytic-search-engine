require 'text'
class SearchesController < ApplicationController

  @@logger = Logger.new(STDOUT) 

  def index
    @searches = Search.all
  end

  def create
    @ip = IpAddress.find_or_create_by(address: request.remote_ip)

    @search = @ip.searches.build(search_params)
    @search.ip_address.increment!(:search_count) 

    if @search.save
      @ip.increment!(:search_count)
      redirect_to root_path
    else  
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @ip = IpAddress.find(params[:id])
    @searches = @ip.searches

    grouped_searches = group_searches(@searches)

    @searches_grouped = grouped_searches.map do |group|
      most_complete_query = find_most_complete_query(group)
      {
        query: most_complete_query,
        search_count: group.count
      } if most_complete_query
    end.compact

    render json: {
      ip: @ip.address,
      searches: @searches_grouped
    }
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
    query.gsub(/\s+/, '')
         .downcase
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

    normalized_queries = group.map { |s| normalize_query(s.query) }
  
    query_counts = normalized_queries.tally
  
    most_common = query_counts.sort_by { |q, count| [-count, -q.length] }.first
  
    group.find { |s| normalize_query(s.query) == most_common.first }.query  
  end

def group_searches(searches)


  groups = []

  valid_searches = searches.select { |search| search.query.length >= 2 }
  valid_searches.each do |search|

    group = groups.find { |g| 
      g.any? { |s| calculate_similarity(s.query, search.query) > 0.35 }
    }

    if group 
      group << search
    else
      groups << [search]
    end

  end
  groups

end

end