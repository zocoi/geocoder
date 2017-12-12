module Geocoder
  module Result
    class Base
      
      US_STATES = {
        'alabama' => 'AL',
        'alaska' => 'AK',
        'american samoa' => 'AS',
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
        'vermont' => 'VT',
        'virginia' =>	'VA',
        'virgin islands' =>	'VI',
        'washington' =>	'WA',
        'west virginia' => 'WV',
        'wisconsin' => 'WI',
        'wyoming' => 'WY'
      }


      # data (hash) fetched from geocoding service
      attr_accessor :data

      # true if result came from cache, false if from request to geocoding
      # service; nil if cache is not configured
      attr_accessor :cache_hit

      ##
      # Takes a hash of data from a parsed geocoding service response.
      #
      def initialize(data)
        @data = data
        @cache_hit = nil
      end

      ##
      # A string in the given format.
      #
      def address(format = :full)
        fail
      end

      ##
      # A two-element array: [lat, lon].
      #
      def coordinates
        [@data['latitude'].to_f, @data['longitude'].to_f]
      end

      def latitude
        coordinates[0]
      end

      def longitude
        coordinates[1]
      end

      def state
        fail
      end

      def province
        state
      end

      def state_code
        fail
      end

      def province_code
        state_code
      end

      def country
        fail
      end

      def country_code
        fail
      end
    end
  end
end
