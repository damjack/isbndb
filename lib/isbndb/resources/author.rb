module ISBNdb
  module Resources
    class Author < Base

      attribute :author, String
      attribute :books, Array[Book]

      def ==(other)
        self.author == other.author
      end

      def <=>(other)
        self.author <=> other.author
      end
    end
  end
end
