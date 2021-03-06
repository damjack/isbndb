module ISBNdb
  module Resources
    class Author < Base

      attr_reader :name
      attribute :books, Array[Book]

      def initialize(str)
        @name = str
      end
    end
  end
end
