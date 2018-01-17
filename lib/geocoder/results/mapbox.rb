require 'geocoder/results/base'

module Geocoder::Result
  class Mapbox < Base

    def coordinates
      data['geometry']['coordinates'].reverse.map(&:to_f)
    end

    def place_name
      data['place_name']
    end
    
    def name
      if place_types.include?('address')
        street
      else
        data['text']
      end
    end

    def street
      if data['properties']['address']
        data['properties']['address']
      elsif data['address']
        "#{data['address']} #{data['text']}"
      end
    end
    
    alias_method :street_address, :street
    
    def place_types
      data['place_type']
    end

    def city
      context_part('place')
    end

    def state
      context_part('region')
    end
    
    def state_code
      US_STATES[state.downcase] if state
    end

    def postal_code
      context_part('postcode')
    end

    def country
      context_part('country')
    end
    
    def country_code
      context_short_code_part('country')
    end

    def neighborhood
      context_part('neighborhood')
    end

    def address
      [place_name, street, city, state, postal_code, country].compact.join(', ')
    end

    private

    def context_part(name)
      if data['id'] =~ Regexp.new(name)
        return data['text']
      end
      context.map { |c| c['text'] if c['id'] =~ Regexp.new(name) }.compact.first
    end
    
    def context_short_code_part(name)
      if data['id'] =~ Regexp.new(name)
        return data['properties']['short_code']
      end
      context.map { |c| c['short_code'] if c['id'] =~ Regexp.new(name) }.compact.first
    end

    def context
      Array(data['context'])
    end
  end
end
