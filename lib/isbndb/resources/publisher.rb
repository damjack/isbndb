module ISBNdb
  module Resources
    class Publisher < Base

      attr_reader :name
      attribute :books, Array[Book]

      def initialize(str)
        @name = str
      end
    end
  end
end
