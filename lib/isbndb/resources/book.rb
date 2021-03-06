module ISBNdb
  module Resources
    class Book < Base

      attribute :publisher, Publisher
      attribute :language, String
      attribute :image, String
      attribute :binding, String
      attribute :publish_date, String
      attribute :date_published, String
      attribute :overview, String
      attribute :title_long, String
      attribute :dimensions, String
      attribute :dewey_decimal, String
      attribute :subjects, Array[String]
      attribute :authors, Array[String]
      attribute :title, String
      attribute :isbn13, String
      attribute :isbn, String

      def ==(other)
        self.isbn13 == other.isbn13
      end

      def <=>(other)
        self.isbn13 <=> other.isbn13
      end
    end
  end
end
