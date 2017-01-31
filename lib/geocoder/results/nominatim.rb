require 'geocoder/results/base'

module Geocoder::Result
  class Nominatim < Base

    US_STATES = {
      'alabama' => 'AL',
      'alaska' =>	'AK',
      'american samoa' =>	'AS',
      'arizona' =>	'AZ',
      'arkansas' =>	'AR',
      'california' =>	'CA',
      'colorado' =>	'CO',
      'connecticut' =>	'CT',
      'delaware' =>	'DE',
      'district of columbia' => 'DC',
      'florida' =>	'FL',
      'georgia' =>	'GA',
      'guam' =>	'GU',
      'hawaii' =>	'HI',
      'idaho' =>	'ID',
      'illinois' =>	'IL',
      'indiana' =>	'IN',
      'iowa' =>	'IA',
      'kansas' =>	'KS',
      'kentucky' =>	'KY',
      'louisiana' =>	'LA',
      'maine' =>	'ME',
      'maryland' =>	'MD',
      'marshall islands' =>	'MH',
      'massachusetts' =>	'MA',
      'michigan' =>	'MI',
      'micronesia' =>	'FM',
      'minnesota' =>	'MN',
      'mississippi' =>	'MS',
      'missouri' =>	'MO',
      'montana' =>	'MT',
      'nebraska' =>	'NE',
      'nevada' =>	'NV',
      'new hampshire' => 'NH',
      'new jersey' =>	'NJ',
      'new mexico' =>	'NM',
      'new york' =>	'NY',
      'north carolina' =>	'NC',
      'north dakota' => 'ND',
      'northern marianas' => 'MP',
      'ohio' =>	'OH',
      'oklahoma' =>	'OK',
      'oregon' =>	'OR',
      'palau' =>	'PW',
      'pennsylvania' =>	'PA',
      'puerto rico' => 'PR',
      'rhode island' =>	'RI',
      'south carolina' =>	'SC',
      'south dakota' =>	'SD',
      'tennessee' =>	'TN',
      'texas' =>	'TX',
      'utah' =>	'UT',
      'vermont' =>	'VT',
      'virginia' =>	'VA',
      'virgin islands' =>	'VI',
      'washington' =>	'WA',
      'west virginia' => 'WV',
      'wisconsin' =>	'WI',
      'wyoming' =>	'WY'
    }


    def poi
      return @data['address'][place_type] if @data['address'].key?(place_type)
      return nil
    end
    alias_method :name, :poi

    def house_number
      @data['address']['house_number']
    end

    def address
      @data['display_name']
    end

    def street
      %w[road pedestrian highway footway].each do |key|
        return @data['address'][key] if @data['address'].key?(key)
      end
      return nil
    end

    def neighborhood
      @data['address']['neighbourhood']
    end

    def city
      %w[city town village hamlet].each do |key|
        return @data['address'][key] if @data['address'].key?(key)
      end
      return nil
    end

    def village
      @data['address']['village']
    end

    def town
      @data['address']['town']
    end

    def state
      @data['address']['state']
    end

    def state_code
      US_STATES[state.downcase]
    end

    def postal_code
      @data['address']['postcode']
    end

    def county
      @data['address']['county']
    end

    def country
      @data['address']['country']
    end

    def country_code
      @data['address']['country_code']
    end

    def suburb
      @data['address']['suburb']
    end

    def coordinates
      [@data['lat'].to_f, @data['lon'].to_f]
    end

    def place_class
      @data['class']
    end

    def place_type
      @data['type']
    end

    def viewport
      south, north, west, east = @data['boundingbox'].map(&:to_f)
      [south, west, north, east]
    end

    def self.response_attributes
      %w[place_id osm_type osm_id boundingbox license
         polygonpoints display_name class type stadium]
    end

    response_attributes.each do |a|
      unless method_defined?(a)
        define_method a do
          @data[a]
        end
      end
    end
  end
end
