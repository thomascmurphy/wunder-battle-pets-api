module Pets
  class NotFound < StandardError; end
  class TooManyRequests < StandardError; end
  class InvalidAPIResponse < StandardError; end

  class Request

    include HTTParty
    base_uri 'https://wunder-pet-api-staging.herokuapp.com'

    def initialize
      @options = { headers: {"X-Pets-Token": Rails.application.secrets.pets_api_token}}
    end

    def call(url, type="get", data={})
      case type.downcase
      when "get"
        @options[:query] = data
        response = self.class.get(url, @options)
      when "post"
        @options[:body] = data.to_json
        @options[:headers] = @options[:headers].merge({'Content-Type' => 'application/json', 'Accept' => 'application/json'})
        response = self.class.post(url, @options)
      else
        response = nil
      end

      if response.respond_to?(:code) && !(200...300).include?(response.code)
        raise NotFound.new("404 Not Found #{url} #{data}") if response.not_found?
        raise TooManyRequests.new("429 Rate limit exceeded, retry after: #{response.headers['retry-after']}, type: #{response.headers['x-rate-limit-type']}") if response.code == 429
        raise InvalidAPIResponse.new(response)
      end
      response
    end

    def create_pet(stats)
      call("/pets", "post", stats)
    end

    def get_pets
      call("/pets")
    end

    def get_pet_by_id(id)
      call("/pets/#{id}")
    end

  end
end
