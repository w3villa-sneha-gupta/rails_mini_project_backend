# app/services/geocoding_service.rb
class GeocodingService
    include HTTParty
    base_uri 'https://api.opencagedata.com/geocode/v1'
  
    def initialize(api_key)
      @api_key = api_key
    end
  
    def geocode_address(address)
      response = self.class.get('/json', query: { q: address, key: @api_key })
      parse_response(response)
    end
  
    private
  
    def parse_response(response)
      if response.success?
        data = response.parsed_response
        results = data['results'].first
        if results
          {
            latitude: results['geometry']['lat'],
            longitude: results['geometry']['lng'],
            formatted_address: results['formatted']
          }
        else
          { error: 'No results found' }
        end
      else
        { error: 'Geocoding request failed' }
      end
    end
end
  