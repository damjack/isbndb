module ISBNdb
  class Client
    include HTTParty

    base_uri 'https://api.isbndb.com'
    headers 'Content-Type' => 'application/json'
    format :json

    attr_reader :response, :name

    # Create the connection to ISBNdb
    def initialize
      self.class.headers.merge!({'x-api-key' => api_key})
    end

    def api_key
      if ENV['ISBNDB_API_KEY']
        ENV['ISBNDB_API_KEY']
      else
        raise 'APY KEY must be specified'
      end
    end

    def send_response(endpoint, query)
      url = Addressable::URI.encode("/#{endpoint}/#{query}").to_s
      @response = self.class.get(url)
      @name = endpoint

      check_response
      build_results
    end

    def method_missing(sym, *args, &block)
      send_response(sym.to_s.downcase, args.first)
    end

    def size
      @response.parsed_response["total"] || @collections.count
    end

    private
      def check_response
        raise ISBNdb::Errors::ForbiddenAccessKeyError if @response.message && @response.parsed_response['message'] == "Forbidden"
        raise ISBNdb::Errors::MissingAccessKeyError if @response.message && @response.parsed_response['message'] == "Missing Authentication Token"
      end

      def build_results
        if(is_singular?(@name))
          ISBNdb::Resources.const_get(@name.titleize.singularize).new(@response.parsed_response[@name])
        else
          ISBNdb::Collection.new((@response.parsed_response[@name] || []).map {|resource| ISBNdb::Resources.const_get(@name.titleize.singularize).new(resource) }, size)
        end
      end

      def is_singular?(str)
        str.singularize == str
      end
  end
end
