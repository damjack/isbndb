require 'isbndb/version'

require 'active_support'
require 'active_support/core_ext'

require 'httparty'
require 'virtus'
require 'json'
require 'pp'
require 'addressable/uri'

module ISBNdb
  autoload :Client, 'isbndb/client'
  autoload :Collection, 'isbndb/collection'

  module Errors
    class ForbiddenAccessKeyError < StandardError; end
    class MissingAccessKeyError < StandardError; end
  end

  module Resources
    autoload :Base, 'isbndb/resources/base'
    autoload :Author, 'isbndb/resources/author'
    autoload :Book, 'isbndb/resources/book'
  end
end
