module ISBNdb
  class Collection < ::Array
    include Enumerable

    def initialize(items, size)
      @items = items
      @size = size
    end

    def first
      @items.first
    end

    def last
      @items.last
    end

    def size
      @size
    end

    def each(*args, &block)
      @items.each(*args, &block)
    end
  end
end
